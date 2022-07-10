module Cups
  module Http
    extend FFI::Library
    
    ffi_lib(Cups.libcups)

    # @overload httpConnectEncrypt(string, int, int)
    #   @param hostname [String]
    #   @param port [int]
    #   @param encryption_settings [int]
    #   @return [Pointer] pointer to a http_t object
    # @deprecated Please use httpConnect2 instead
    attach_function 'httpConnectEncrypt', [ :string, :int, :int], :pointer, blocking: true

    # @overload httpClose(pointer)
    #   @param pointer [Pointer] to a http_t object
    attach_function 'httpClose', [ :pointer ], :void, blocking: true

    # Get a list of addresses for a hostname.
    # @overload httpAddrGetList(string, int, string)
    #   @param hostname [String]
    #   @param family [Integer]
    #   @param port [String]
    #   @return [Pointer] List of addresses or NULL
    attach_function 'httpAddrGetList', [:string, :int, :string], :pointer, blocking: true

    # Connect to a HTTP server.
    # @overload httpConnect2(string, int, pointer, int, int, int, int, pointer)
    #   @param hostname [String]
    #   @param port [Integer]
    #   @param addrlist [Pointer] can be NULL
    #   @param family [Integer] (AF_UNSPEC=0)
    #   @param encryption_settings [Integer] from Cups.cupsEncryption()
    #   @param blocking [Integer]
    #   @param msec [Integer] use 5000 or less
    #   @param cancel[Pointer] integer pointer, can be NULL
    #   @return [Pointer] http_t object
    attach_function 'httpConnect2', [:string, :int, :pointer, :int, :int, :int, :int, :pointer], :pointer, blocking: true
  end
end
