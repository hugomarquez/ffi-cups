module FFI::Cups
  module Ipp
    extend FFI::Library

    ffi_lib('cups')
    
    # Allocate a new IPP request message.
    # @overload ippNewRequest(Cups::Enum::IPP::Op)
    #   @param ipp_op_t op [Cups::Enum::IPP::Op]
    #   @return [Pointer] pointer to a ipp_t object
    # {https://www.cups.org/doc/cupspm.html#ippNewRequest}
    attach_function 'ippNewRequest', [Cups::Enum::IPP::Op], :pointer, blocking: true

    # Add a integer attribute to an IPP message.
    # @overload ippAddInteger(pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, string, int)
    #   @param ipp [Pointer]
    #   @param group [Cups::Enum::IPP::Tag]
    #   @param value [Cups::Enum::IPP::Tag]
    #   @param name [String]
    #   @param value [Integer]
    # {https://www.cups.org/doc/cupspm.html#ippAddInteger}
    attach_function 'ippAddInteger', [:pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, :string, :int], :pointer, blocking: true

    # Add a language-encoded string to an IPP message.
    # @overload ippAddString(pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, string, string, string)
    #   @param ipp_t [Pointer]
    #   @param group [Cups::Enum::IPP::Tag]
    #   @param value [Cups::Enum::IPP::Tag]
    #   @param name [String]
    #   @param language [String]
    #   @param value [String]
    #   @return [Pointer] pointer to a ipp_attribute_t object
    # {https://www.cups.org/doc/cupspm.html#ippAddString}
    attach_function 'ippAddString', [:pointer, Cups::Enum::IPP::Tag, Cups::Enum::IPP::Tag, :string, :string, :string], :pointer, blocking: true

    # @overload ippFindAttribute(pointer, string, Cups::Enum::IPP::Tag)
    #   @param ipp [Pointer]
    #   @param name [String]
    #   @param type [Cups::Enum::IPP::Tag]
    #   @return [Pointer] pointer to a ipp_attribute_t
    # {https://www.cups.org/doc/cupspm.html#ippFindAttribute}
    attach_function 'ippFindAttribute', [:pointer, :string, Cups::Enum::IPP::Tag], :pointer, blocking: true

    # @overload ippFirstAttribute(pointer)
    #   @param ipp [Pointer]
    #   @return [Pointer] First attribute or NULL if none
    # {https://www.cups.org/doc/cupspm.html#ippFirstAttribute}
    attach_function 'ippFirstAttribute', [:pointer], :pointer, blocking: true

    # @overload ippNextAttribute(pointer)
    #   @param ipp [Pointer]
    #   @return [Pointer] Next attribute or NULL if none
    # {https://www.cups.org/doc/cupspm.html#ippNextAttribute}
    attach_function 'ippNextAttribute', [:pointer], :pointer, blocking: true

    # Get the attribute name.
    # @overload ippGetName(pointer)
    #   @param ipp_attribute_t [Pointer]
    #   @return [String] Attribute name or NULL for separators
    # {https://www.cups.org/doc/cupspm.html#ippGetName}
    attach_function 'ippGetName', [:pointer], :string, blocking: true

    # Get the integer/enum value for an attribute.
    # @overload ippGetInteger(pointer, int)
    #   @param ipp_attribute_t [Pointer]
    #   @param element [Integer]
    #   @return [Integer] Value or 0 on error
    # {https://www.cups.org/doc/cupspm.html#ippGetInteger}
    attach_function 'ippGetInteger', [:pointer, :int], :int, blocking: true

    # Get the string value for an attribute.
    # @overload ippGetString(pointer, int, pointer)
    #   @param ipp_attribute_t [Pointer]
    #   @param element [Integer] Value number (0-based)
    #   @param language [Pointer] Language code (NULL for don't care)
    #   @return [String] Get the string and optionally the language code for an attribute.
    # {https://www.cups.org/doc/cupspm.html#ippGetString}
    attach_function 'ippGetString', [:pointer, :int, :pointer], :int, blocking: true
    
    # @overload cupsDoRequest(pointer, pointer, string)
    #   @param http [Pointer]
    #   @param request [Pointer]
    #   @param resource [String]
    #   @return [Pointer] pointer to a ipp_t response object
    attach_function 'cupsDoRequest', [:pointer, :pointer, :string], :pointer, blocking: true

  end
end