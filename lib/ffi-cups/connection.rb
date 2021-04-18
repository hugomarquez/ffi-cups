module Cups
  class Connection
    extend Gem::Deprecate

    attr_accessor :hostname, :port
    
    @instance_mutex = Mutex.new

    private_class_method :new

    def initialize(hostname, port=nil)
      @hostname = hostname
      @port = port.nil? ? 631 : port
    end

    # Returns or creates a singleton instance
    # @param hostname [String]
    # @param port [Integer]
    # @return [Object] a connection object
    def self.instance(hostname, port=nil)
      return @instance if @instance

      @instance_mutex.synchronize do 
        @instance ||= new(hostname, port)
      end

      @instance
    end
    
    # Wrapper around {::FFI::Cups::Http#httpConnectEncrypt}
    # @deprecated Use {#httpConnect2} instead
    # @return [Pointer] a http pointer 
    def httpConnectEncrypt
      http = FFI::Cups::Http.httpConnectEncrypt(hostname, port, FFI::Cups.cupsEncryption())
      raise "Print server at #{hostname}:#{port} is not available" if http.null?
      return http
    end
    deprecate :httpConnectEncrypt, "This function is deprecated by CUPS, please use httpConnect2 instead", 2025, 12

    # Wrapper around {::FFI::Cups::Http#httpConnect2}
    # Creates a http connection to a print server
    # @return [Pointer] a http pointer
    def httpConnect2
      http = FFI::Cups::Http.httpConnect2(hostname, port, nil, 0, FFI::Cups.cupsEncryption(), 1, 30000, nil)
      raise "Print server at #{hostname}:#{port} is not available" if http.null? 
      return http
    end

    # Closes the http connection and autoreleases the pointer
    # Wrapper around {::FFI::Cups::Http#httpClose}
    # @param http (Pointer)
    def self.close(http)
      FFI::Cups::Http.httpClose(http)
    end
  end
end

