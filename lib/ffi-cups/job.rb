module Cups
  class Job
    attr_reader :id, :title, :printer
    def initialize(id, title, printer=nil)
      @id = id
      @title = title
      @printer = printer
    end
  end
end

