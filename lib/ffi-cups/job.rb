module Cups
  class Job
    attr_accessor :id, :title, :printer

    def initialize(id, title, printer=nil)
      @id = id
      @title = title
      @printer = printer
    end

  end
end

