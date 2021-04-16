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
      destinations = cupsGetDests2(connection, pointer)
      printers = []
      destinations.each do |k, d|
        destination_opt = cupsOptions(d)
        options = {}

        destination_opt.each do |k, o|
          options[o[:name].dup] = o[:value].dup
        end

        printer = Cups::Printer.new(d[:name].dup, options)
        printers.push(printer)
      end
      cupsFreeDests(destinations.keys.count, pointer)
      return printers
    end

    # Get a destination by name
    # @param name [String] name of the printer
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    def self.get_destination(name, connection=nil)
      printers = get_destinations(connection)
      printers.each do |p|
        return p if p.name == name
      end
      raise "Destination with name: #{name} not found!" 
    end

    private
    # Wrapper around {::FFI::Cups#cupsGetDests2}
    # @param connection [Pointer] http pointer from {Cups::Connection#httpConnect2}
    # @param pointer [Pointer] pointer to the destinations
    # @return [Hash] hashmap of destination structs
    def self.cupsGetDests2(connection=nil, pointer)
      count_destinations = FFI::Cups.cupsGetDests2(connection, pointer)
      struct_size = Cups::Struct::Destination.size
      destinations = {}
      count_destinations.times do |index|
        destination = Cups::Struct::Destination.new(pointer.get_pointer(0) + (struct_size * index))
        destinations[index] = destination
      end
      return destinations
    end

    # Returns a destination's options
    # @param destination [Object] {Cups::Struct::Destination} object
    # @return [Hash] hashmap of destination' options as {Cups::Struct::Option}
    def self.cupsOptions(destination)
      struct_size = Cups::Struct::Option.size
      options = {}

      destination[:num_options].times do |index|
        option = Cups::Struct::Option.new(destination[:options] + (struct_size * index))
        options[index] = option
      end
      return options
    end

    # Wrapper around {::FFI::Cups#cupsFreeDests}
    # @param number_destinations [Integer]
    # @param pointer [Pointer] pointer to the destinations
    def self.cupsFreeDests(number_destinations, pointer)
      FFI::Cups.cupsFreeDests(number_destinations, pointer.get_pointer(0))
    end

    # Wrapper around {::FFI::Cups#cupsFreeOptions}
    # @param number_options [Integer]
    # @param pointer [Pointer] pointer to the options
    def self.cupsFreeOptions(number_options, pointer)
      FFI::Cups.cupsFreeOptions(number_options, pointer.get_pointer(0))
    end
  end
end
