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
    # @overload ippAddString(pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, string, string, string)
    #   @param ipp_t [Pointer]
    #   @param ipp_tag_t group [Cups::Enum::IPP::Tag]
    #   @param ipp_tag_t value [Cups::Enum::IPP::Tag]
    #   @param name [String]
    #   @param language [String]
    #   @param value [String]
    #   @return [Pointer] pointer to a ipp_attribute_t object
    attach_function 'ippAddString', [:pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, :string, :string, :string], :pointer, blocking: true

    # Add a language-encoded string to an IPP message.
    # @overload ippAddStrings(pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, string, int, string, string)
    #   @param ipp_t [Pointer]
    #   @param ipp_tag_t group [Cups::Enum::IPP::Tag]
    #   @param ipp_tag_t value [Cups::Enum::IPP::Tag]
    #   @param name [String]
    #   @param num_values [Integer]
    #   @param language [String]
    #   @param values [String]
    #   @return [Pointer] pointer to a ipp_attribute_t object
    attach_function 'ippAddStrings', [:pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, :string, :int, :string, :string], :pointer, blocking: true

    # @overload ippFindAttribute(pointer, string, Cups::Enum::IPP::Tag)
    #   @param ipp [Pointer]
    #   @param name [String]
    #   @param ipp_tag_t type [Cups::Enum::IPP::Tag]
    #   @return [Pointer] pointer to a ipp_attribute_t
    attach_function 'ippFindAttribute', [:pointer, :strting, Cups::Enum::IPP::Tag], :pointer, blocking: true

    # Get the attribute name.
    # @overload ippGetName(pointer)
    #   @param ipp_attribute_t [Pointer]
    #   @return [String] Attribute name or NULL for separators
    attach_function 'ippGetName', [:pointer], :string, blocking: true
    
    # @overload cupsDoRequest(pointer, pointer, string)
    #   @param http [Pointer]
    #   @param request [Pointer]
    #   @param resource [String]
    #   @return [Pointer] pointer to a ipp_t response object
    attach_function 'cupsDoRequest', [:pointer, :pointer, :string], :pointer, blocking: true

  end
end