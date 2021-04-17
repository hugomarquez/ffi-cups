# cups.h
# {https://www.cups.org/doc/cupspm.html Programming Manual}
# {https://github.com/apple/cups/blob/master/cups/cups.h cups.h source}

module FFI::Cups
  extend FFI::Library

  ffi_lib('cups')
  
  # Get the current encryption settings.
  # @return [Integer] encryption settings
  # {https://www.cups.org/doc/cupspm.html#cupsEncryption}
  attach_function 'cupsEncryption', [], :int, blocking: true

  # Check that the option and value are supported by the destination.
  # @overload cupsCheckDestSupported(pointer, pointer, pointer, string, string)
  #   @param http [Pointer]
  #   @param destination [Pointer]
  #   @param dinfo [Pointer]
  #   @param option [String]
  #   @param value [String]
  #   @return [Integer] 1 if supported, 0 otherwise
  # {https://www.cups.org/doc/cupspm.html#cupsCheckDestSupported}
  attach_function 'cupsCheckDestSupported', [:pointer, :pointer, :pointer, :string, :string], :int, blocking: true

  # Get the supported values/capabilities for the destination.
  # @overload cupsCopyDestInfo(pointer, pointer)
  #   @param http [Pointer]
  #   @param dest [Pointer]
  #   @return [Pointer] Destination information
  # {https://www.cups.org/doc/cupspm.html#cupsCopyDestInfo}
  attach_function 'cupsCopyDestInfo', [:pointer, :pointer], :pointer, blocking: true

  # Get the named destination from the list.
  # @overload cupsGetDest(string, string, int, pointer)
  #   @param name [String]
  #   @param instance [String] instance name or NULL
  #   @param num_dests [Integer] number of destinations
  #   @param destinations [Pointer]
  #   @return [Pointer, NULL] destination or NULL
  # {https://www.cups.org/doc/cupspm.html#cupsGetDest}
  attach_function 'cupsGetDest', [:string, :string, :int, :pointer], :pointer, blocking: true

  # Get the list of destinations from the specified server.
  # @overload cupsGetDests2(pointer, pointer)
  #   @param pointer [Pointer] to http connection for server or CUPS_HTTP_DEFAULT
  #   @param pointer [Pointer] to destinations
  #   @return [Integer] number of destinations
  # {https://www.cups.org/doc/cupspm.html#cupsGetDests2}
  attach_function 'cupsGetDests2', [:pointer, :pointer], :int, blocking: true

  # Free the memory used by the list of destinations.
  # @overload cupsFreeDests(int, pointer)
  #   @param number [Integer] of destinations
  #   @param pointer [Pointer] to destinations
  # {https://www.cups.org/doc/cupspm.html#cupsFreeDests}
  attach_function 'cupsFreeDests', [:int, :pointer], :void, blocking: true

  # Prints a File
  # @overload cupsPrintFile(string, string, string, int, pointer)
  #   @param name [String] of the printer
  #   @param name [String] of the file
  #   @param title [String] of the job
  #   @param number [Integer] of options
  #   @param pointer [Pointer] to a CupsOptionS struct
  #   @return [Integer] job number or 0 on error
  attach_function 'cupsPrintFile', [ :string, :string, :string, :int, :pointer ], :int, blocking: true
  
  # Prints a file from a specific connection
  # @overload cupsPrintFile2(pointer, string, string, string, int, pointer)
  #   @param pointer [Pointer] to an http connection
  #   @param name [String] of the printer
  #   @param name [String] of the file
  #   @param title [String] of the title
  #   @param number [Integer] of options
  #   @param pointer [Pointer] to a CupsOptionS struct
  #   @return [Integer] number of the job or 0 on error
  attach_function 'cupsPrintFile2', [ :pointer, :string, :string, :string, :int, :pointer ], :int, blocking: true

  # Returns the last error in string format
  # @return [String] error
  attach_function 'cupsLastErrorString', [], :string, blocking: true

  # Cancel a job on a destination.
  # @overload cupsCancelDestJob(string, int)
  #   @param connection [Pointer] to a http server
  #   @param pointer [Pointer] to a destination
  #   @param id [Integer] of the job
  #   @return [Integer] IPP status
  # {https://www.cups.org/doc/cupspm.html#cupsCancelDestJob}
  attach_function 'cupsCancelDestJob', [:string, :int], :void, blocking: true

  # Cancel a job on a destination name
  # @overload cupsCancelJob(string, int)
  #   @param name [String] of the destination
  #   @param id [Ingeger] of the job
  attach_function 'cupsCancelJob', [:string, :int], :void, blocking: true

  # Cancel a job on a destination
  # @overload cupsCancelJob2(pointer, string, int)
  #   @param pointer [Pointer] of the http connection
  #   @param name [String] of the destination
  #   @param id [Ingeger] of the job
  attach_function 'cupsCancelJob2', [:pointer, :string, :int], :void, blocking: true

  # Get the jobs from a connection
  # @overload cupsGetJobs2(pointer, pointer, string, int, int)
  #   @param pointer [Pointer] to a http connection object
  #   @param pointer [Pointer] to Cups::Struct::Job
  #   @param name [String] of the printer
  #   @param number [Integer] of type of job (0 == all users, 1 == mine)
  #   @param which [Integer] jobs (CUPS_WHICHJOBS_ALL, CUPS_WHICHJOBS_ACTIVE, or CUPS_WHICHJOBS_COMPLETED)
  #   @return [Integer] number of jobs
  # {https://www.cups.org/doc/cupspm.html#cupsGetJobs2}
  attach_function 'cupsGetJobs2', [:pointer, :pointer, :string, :int, :int], :int, blocking: true

  # Get the jobs
  # @overload cupsGetJobs(pointer, string, int, int)
  #   @param pointer [Pointer] to Cups::Struct::Job to populate
  #   @param name [String] of the printer
  #   @param number [Integer] of type of job (0 == all users, 1 == mine)
  #   @param which [Integer] jobs (CUPS_WHICHJOBS_ALL, CUPS_WHICHJOBS_ACTIVE, or CUPS_WHICHJOBS_COMPLETED)
  #   @return [Integer] number of jobs
  attach_function 'cupsGetJobs', [:pointer, :string, :int, :int], :int, blocking: true

  # Free memory used by job data.
  # @overload cupsFreeJobs(int, pointer)
  #   @param number [Integer] of jobs
  #   @param pointer [Pointer] to the first Cups::Struct::Job to free
  # {https://www.cups.org/doc/cupspm.html#cupsFreeJobs}
  attach_function 'cupsFreeJobs', [:int, :pointer ], :void, blocking: true

  # Create a job on a destination.
  # @overload cupsCreateJob(pointer, string, string, int, pointer)
  #   @param pointer [Pointer] to http connection to server or CUPS_HTTP_DEFAULT
  #   @param name [String] of the printer
  #   @param title [String] of the job
  #   @param number [Integer] of options
  #   @param pointer [Pointer] to a Cups::Struct::Option object
  #   @return [Integer] job number or 0 on error
  attach_function 'cupsCreateJob', [:pointer, :string, :string, :int, :pointer], :int, blocking: true

  # Start a document
  # @overload cupsStartDocument(pointer, string, int, string, string, int)
  #   @param pointer [Pointer] to http connection to server or CUPS_HTTP_DEFAULT
  #   @param name [String] of the printer
  #   @param id [Integer] of the job
  #   @param name [String] of the document
  #   @param mime_type [String] format of the document
  #   @param number [Integer] of the last document (1 for last document in job, 0 otherwise)
  #   @return [Cups::Enum::HTTP::Status] HttpStatus
  # {https://www.cups.org/doc/cupspm.html#submitting-a-print-job}
  attach_function 'cupsStartDocument', [:pointer, :string, :int, :string, :string, :int], Cups::Enum::HTTP::Status, blocking: true

  # @overload cupsWriteRequestData(pointer, pointer, bytesize)
  #   @param pointer [Pointer] to http connection to server or CUPS_HTTP_DEFAULT
  #   @param data [Pointer] in a character string pointer
  #   @param length [Byte] of data
  #   @return [Cups::Enum::HTTP::Status] HttpStatus
  attach_function 'cupsWriteRequestData', [:pointer, :pointer, :size_t], Cups::Enum::HTTP::Status, blocking: true

  # @overload cupsFinishDocument(pointer, string)
  #   @param pointer [Pointer] to http connection to server or CUPS_HTTP_DEFAULT
  #   @param name [String] of the printer
  #   @return [Cups::Enum::IPP::Status] IppStatus
  attach_function 'cupsFinishDocument', [:pointer, :string], Cups::Enum::IPP::Status, blocking: true

  # Add an option to an option array.
  # @overload cupsAddOption(string, string, int, pointer)
  #   @param name [String] of option
  #   @param value [String] of option
  #   @param number [Integer] of options
  #   @param pointer [Pointer] to options
  #   @return [Integer] number of options
  # {https://www.cups.org/doc/cupspm.html#cupsAddOption}
  attach_function 'cupsAddOption', [:string, :string, :int, :pointer], :int, blocking: true

  # Free all memory used by options.
  # @overload cupsFreeOptions(int, pointer)
  #   @param number [Integer] of options
  #   @param pointer [Pointer] to options
  # {https://www.cups.org/doc/cupspm.html#cupsFreeOptions}
  attach_function 'cupsFreeOptions', [:int, :pointer], :void, blocking: true
end
