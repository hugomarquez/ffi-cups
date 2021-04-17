module Cups
  class Printer
    attr_reader :name, :options

    # @param name [String] printer's name
    # @param options [Hash] printer's options
    def initialize(name, options={})
      @name = name
      @options = options
    end

    # Returns the printer state
    # @return [Symbol] printer state from options
    def state
      case options['printer-state']
      when '3' then :idle
      when '4' then :printing
      when '5' then :stopped
      else :unkown
      end
    end

    # Returns the reason for the printer state
    # @return [Array] array of reasons in string format
    def state_reasons
      options['printer-state-reasons'].split(/,/)
    end

    # Get all destinations (printer devices)
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    def self.get_destinations(connection=nil)
      pointer = FFI::MemoryPointer.new :pointer
      dests = cupsGetDests2(connection, pointer)
      printers = []
      dests.each do |d|
        printer = Cups::Printer.new(d[:name].dup, printer_options(d))
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
      # Get all destinations with cupsGetDests2
      dests = FFI::MemoryPointer.new :pointer
      num_dests = FFI::Cups.cupsGetDests2(connection, dests)

      # Get the destination from name with cupsGetDest
      p_dest = FFI::Cups.cupsGetDest(name, nil, num_dests, dests.get_pointer(0))
      dest = Cups::Struct::Destination.new(p_dest)
      raise "Destination with name: #{name} not found!" if dest.null?

      printer = Cups::Printer.new(dest[:name].dup, printer_options(dest))
      cupsFreeDests(num_dests, dests)
      return printer
    end

    private
    # Wrapper around {::FFI::Cups#cupsGetDests2}
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    # @param pointer [Pointer] pointer to the destinations
    # @return [Hash] hashmap of destination structs
    def self.cupsGetDests2(connection=nil, pointer)
      num_dests = FFI::Cups.cupsGetDests2(connection, pointer)
      size = Cups::Struct::Destination.size
      destinations = []
      num_dests.times do |i|
        destination = Cups::Struct::Destination.new(pointer.get_pointer(0) + (size * i))
        destinations.push(destination)
      end
      return destinations
    end

    # Wrapper around {::FFI::Cups#cupsCheckDestSupported}
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    # @param dest [Pointer] pointer to the destination
    # @param option [String]
    # @param value [String]
    # @return [Boolean] true if supported, false otherwise
    def self.cupsCheckDestSupported(connection=nil, dest, option, value)
      info = FFI::Cups.cupsCopyDestInfo(connection, dest)
      i = FFI::Cups.cupsCheckDestSupported(connection, dest, info, option, value)
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

    # Wrapper around {::FFI::Cups#cupsFreeDests}
    # @param num_dests [Integer]
    # @param pointer [Pointer] pointer to the destinations
    def self.cupsFreeDests(num_dests, pointer)
      FFI::Cups.cupsFreeDests(num_dests, pointer.get_pointer(0))
    end

    # Wrapper around {::FFI::Cups#cupsFreeOptions}
    # @param num_opts [Integer]
    # @param pointer [Pointer] pointer to the options
    def self.cupsFreeOptions(num_opts, pointer)
      FFI::Cups.cupsFreeOptions(num_opts, pointer.get_pointer(0))
    end
  end
end
