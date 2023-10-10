module Cups
  class Printer
    attr_reader :name, :options, :connection

    # @param name [String] printer's name
    # @param options [Hash] printer's options
    def initialize(name, options={}, connection=nil)
      @name = name
      @options = options
      @connection = connection
    end

    # Returns the printer state
    # @return [Symbol] printer state from options
    def state
      case options['printer-state']
      when '3' then :idle
      when '4' then :printing
      when '5' then :stopped
      else :unknown
      end
    end

    # Returns the reason for the printer state
    # @return [Array] array of reasons in string format
    def state_reasons
      options['printer-state-reasons'].split(/,/)
    end

    def print_file(filename, title, options={})
      raise "File not found: #{filename}" unless File.exist? filename
      
      http = @connection.nil? ? nil : @connection.httpConnect2
      # Get all destinations with cupsGetDests2
      dests = FFI::MemoryPointer.new :pointer
      num_dests = Cups.cupsGetDests2(http, dests)

      # Get the destination from name with cupsGetDest
      p_dest = Cups.cupsGetDest(@name, nil, num_dests, dests.get_pointer(0))
      dest = Cups::Struct::Destination.new(p_dest)
      raise "Destination with name: #{@name} not found!" if dest.null?

      p_options = nil
      num_options = 0
      unless options.empty?
        p_options = FFI::MemoryPointer.new :pointer
        options.each do |k, v|
          unless self.class.cupsCheckDestSupported(p_dest, k, v, http)
            raise "Option:#{k} #{v if v} not supported for printer: #{@name}" 
          end
          num_options = Cups.cupsAddOption(k, v, num_options, p_options)
        end
        p_options = p_options.get_pointer(0)
      end

      job_id = Cups.cupsPrintFile2(http, @name, filename, title, num_options, p_options)

      if job_id.zero?
        last_error = Cups.cupsLastErrorString()
        self.class.cupsFreeOptions(num_options, p_options) unless options.empty?
        raise last_error
      end
      #job = Cups::Job.new(job_id, title, @name)
      job = Cups::Job.get_job(job_id, @name, 0, @connection)

      self.class.cupsFreeOptions(num_options, p_options) unless options.empty?
      self.class.cupsFreeDests(num_dests, dests)
      Cups::Connection.close(http)
      return job
    end

    # Get all destinations (printer devices)
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    def self.get_destinations(connection=nil)
      pointer = FFI::MemoryPointer.new :pointer
      dests = cupsGetDests2(pointer, connection)
      printers = []
      dests.each do |d|
        printer = Cups::Printer.new(d[:name].dup, printer_options(d), connection)
        printers.push(printer)
      end
      cupsFreeDests(dests.count, pointer)
      return printers
    end

    # Get a destination by name
    # @param name [String] name of the printer
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    # @return [Printer] a printer object
    def self.get_destination(name, connection=nil)
      http = connection.nil? ? nil : connection.httpConnect2
      # Get all destinations with cupsGetDests2
      dests = FFI::MemoryPointer.new :pointer
      num_dests = Cups.cupsGetDests2(http, dests)

      # Get the destination from name with cupsGetDest
      p_dest = Cups.cupsGetDest(name, nil, num_dests, dests.get_pointer(0))
      dest = Cups::Struct::Destination.new(p_dest)
      raise "Destination with name: #{name} not found!" if dest.null?

      printer = Cups::Printer.new(dest[:name].dup, printer_options(dest), connection)
      cupsFreeDests(num_dests, dests)
      Cups::Connection.close(http) if http
      return printer
    end

    private
    # Wrapper around {::Cups#cupsGetDests2}
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    # @param pointer [Pointer] pointer to the destinations
    # @return [Hash] hashmap of destination structs
    def self.cupsGetDests2(pointer, connection=nil)
      http = connection.nil? ? nil : connection.httpConnect2
      num_dests = Cups.cupsGetDests2(http, pointer)
      size = Cups::Struct::Destination.size
      destinations = []
      num_dests.times do |i|
        destination = Cups::Struct::Destination.new(pointer.get_pointer(0) + (size * i))
        destinations.push(destination)
      end
      Cups::Connection.close(http) if http
      return destinations
    end

    # Wrapper around {::Cups#cupsCheckDestSupported}
    # @param dest [Pointer] pointer to the destination
    # @param option [String]
    # @param value [String]
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    # @return [Boolean] true if supported, false otherwise
    def self.cupsCheckDestSupported(dest, option, value, connection=nil)
      info = Cups.cupsCopyDestInfo(connection, dest)
      i = Cups.cupsCheckDestSupported(connection, dest, info, option, value)
      return !i.zero?
    end

    # Returns a destination's options
    # @param dest [Object] {Cups::Struct::Destination} object
    # @return [Hash] hash of destination' options as {Cups::Struct::Option}
    def self.cups_options(dest)
      size = Cups::Struct::Option.size
      options = []

      dest[:num_options].times do |i|
        option = Cups::Struct::Option.new(dest[:options] + (size * i))
        options.push(option)
      end
      return options
    end

    # Returns a destination's options as hash
    # @param dest [Object] {Cups::Struct::Destination} object
    # @return [Hash] hash of destination' options
    def self.printer_options(dest)
      dest_opts = cups_options(dest)
      options = {}
      dest_opts.each do |o|
        options[o[:name].dup] = o[:value].dup
      end
      return options
    end

    # Wrapper around {::Cups#cupsFreeDests}
    # @param num_dests [Integer]
    # @param pointer [Pointer] pointer to the destinations
    def self.cupsFreeDests(num_dests, pointer)
      Cups.cupsFreeDests(num_dests, pointer.get_pointer(0))
    end

    # Wrapper around {::Cups#cupsFreeOptions}
    # @param num_opts [Integer]
    # @param pointer [Pointer] pointer to the options
    def self.cupsFreeOptions(num_opts, pointer)
      Cups.cupsFreeOptions(num_opts, pointer)
    end
  end
end
