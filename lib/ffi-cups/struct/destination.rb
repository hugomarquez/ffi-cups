module Cups::Struct
  class Destination < FFI::Struct
    layout  :name,        :string,
            :instance,    :string,
            :is_default,  :int,
            :num_options, :int,
            :options,     :pointer
  end
end