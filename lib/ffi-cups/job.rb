module Cups
  class Job
    attr_accessor :id, :title, :printer,
      :format, :state, :size, :completed_time,
      :creation_time, :processing_time

    def initialize(id, title, printer)
      @id = id
      @title = title
      @printer = printer
    end

    # get a updated job's state
    # @param connection [Cups::Connection]
    # @return [Symbol] job's state
    def status(connection=nil)
      job = self.class.get_job(@id, @printer, -1, connection)
      self.state = job.state if job
    end

    # Cancel or purge a job
    # @param connection [Cups::Connection]
    def cancel(purge=0, connection=nil)
      job = self.class.get_job(@id, @printer, -1, connection)
      r = FFI::Cups.cupsCancelJob2(connection, @printer, @id, purge)
      raise FFI::Cups.cupsLastErrorString() if r == 0
      return r
    end

    # Get jobs by filter or destination name
    # @param name [String]
    # @param filter [Integer] see Constants
    # @param connection [Cups::Connection]
    # @return [Array] jobs
    def self.get_jobs(name=nil, filter=-1, connection=nil)
      p_jobs = FFI::MemoryPointer.new :pointer
      cups_jobs = cupsGetJobs2(p_jobs, name, filter, connection)
      jobs = []
      cups_jobs.each do |j|
        job = Cups::Job.new(j[:id].dup, j[:title].dup, j[:dest].dup)
        job.format = j[:format]
        job.state = j[:state]
        job.size = j[:size]
        job.completed_time = Time.at(j[:completed_time])
        job.creation_time = Time.at(j[:creation_time])
        job.processing_time = Time.at(j[:processing_time])
        jobs.push(job)
      end
      return jobs
    end

    # Get job from id
    # @param id [Integer]
    # @param name [String]
    # @param filter [Integer] see Constants
    # @param connection [Cups::Connection]
    # @return [Job] job object
    def self.get_job(id, name=nil, filter=-1, connection=nil)
      jobs = get_jobs(name, filter, connection)
      jobs.each do |j|
        return j if j.id == id
      end
      raise "Job with id: #{id} not found!"
    end

    private
    # Wrapper {::FFI::Cups#cupsGetJobs2}
    # @param pointer [Pointer] pointer to the jobs
    # @param name [String] name of the destination or NULL
    # @param filter [Integer] see Constants for more filters
    # @param connection [Cups::Connection]
    # @return [Array] array of job structs
    def self.cupsGetJobs2(pointer, name=nil, filter=-1, connection=nil)
      http = connection.nil? ? nil : connection.httpConnect2
      num_jobs = FFI::Cups.cupsGetJobs2(http, pointer, name, 0, filter)
      size = Cups::Struct::Job.size
      jobs = []
      
      num_jobs.times do |i|
        job = Cups::Struct::Job.new(pointer.get_pointer(0) + (size * i))
        jobs.push(job)
      end

      Cups::Connection.close(http) if http
      return jobs
    end
  end
end

