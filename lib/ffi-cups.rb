require 'ffi'
require 'byebug'

module Cups
  extend FFI::Library

  begin
    if ENV['CUPS_LIB']
      ffi_lib(ENV['CUPS_LIB'])
    else
      ffi_lib('cups')
    end
  rescue LoadError => e
    raise LoadError, "Didn't find libcups on your system."
  end
end

# Constants
require 'ffi-cups/constants'

# Enums
require 'ffi-cups/enum/http/status'
# IPP
require 'ffi-cups/enum/ipp/status'
require 'ffi-cups/enum/ipp/job_state'
require 'ffi-cups/enum/ipp/op'
require 'ffi-cups/enum/ipp/tag'

# Structs
require 'ffi-cups/struct/option'
require 'ffi-cups/struct/destination'
require 'ffi-cups/struct/job'

# Functions
require 'ffi-cups/ffi/cups'
require 'ffi-cups/ffi/http'
require 'ffi-cups/ffi/array'
require 'ffi-cups/ffi/ipp'

# wrappers
require 'ffi-cups/connection'
require 'ffi-cups/job'
require 'ffi-cups/printer'
