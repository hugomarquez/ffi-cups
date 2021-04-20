module FFI::Cups
  module Ipp
    extend FFI::Library

    ffi_lib('cups')
    
    # Allocate a new IPP request message.
    # @overload ippNewRequest(Cups::Enum::IPP::Op)
    #   @param ipp_op_t op [Cups::Enum::IPP::Op]
    #   @return [Pointer] pointer to a ipp_t object
    attach_function 'ippNewRequest', [Cups::Enum::IPP::Op], :pointer, blocking: true

    # Add a language-encoded string to an IPP message.
    # @overload ippNewRequest(pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, string, string, string)
    #   @param ipp_t [Pointer]
    #   @param ipp_tag_t group [Cups::Enum::IPP::Tag]
    #   @param ipp_tag_t value [Cups::Enum::IPP::Tag]
    #   @param name [String]
    #   @param language [String]
    #   @param value [String]
    #   @return [Pointer] pointer to a ipp_attribute_t object
    attach_function 'ippAddString', [:pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, :string, :string, :string], :pointer, blocking: true


  end
end