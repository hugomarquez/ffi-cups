module Cups::Struct
  class Option < FFI::Struct
    layout  :name, :string, :value, :string
  end
end