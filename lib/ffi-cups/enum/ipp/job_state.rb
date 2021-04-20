module Cups::Enum
  module IPP
    extend FFI::Library
    JobState = enum [
      :pending, 3,
      :held,
      :processing,
      :stopped,
      :canceled,
      :aborted,
      :completed
    ]
  end
end
