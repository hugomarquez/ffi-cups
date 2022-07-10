module Cups
  module Array
    extend FFI::Library
    
    ffi_lib(Cups.libcups)
    
    # @overload cupsArrayFirst(pointer)
    #   @param pointer [Pointer] to _cups_array_s struct
    #   @return [Pointer] void pointer to first element
    attach_function 'cupsArrayFirst', [:pointer], :pointer, blocking: true

    # @overload cupsArrayNext(pointer)
    #   @param pointer [Pointer] to _cups_array_s struct
    #   @return [Pointer] void pointer to first element
    attach_function 'cupsArrayNext', [:pointer], :pointer, blocking: true
  end
end
