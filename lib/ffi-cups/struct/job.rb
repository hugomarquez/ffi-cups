module Cups::Struct
  class Job < FFI::Struct
    layout  :id,                :int,
            :dest,              :string,
            :title,             :string,
            :user,              :string,
            :format,            :string,
            :state,             Cups::Enum::IPP::JobState,
            :size,              :int,
            :priority,          :int,
            :completed_time,    :long,
            :creation_time,     :long,
            :processing_time,   :long
  end
end