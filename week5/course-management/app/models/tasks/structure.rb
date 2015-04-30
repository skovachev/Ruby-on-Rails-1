module Tasks
    class Structure
        attr_reader :lecture
        attr_accessor :tasks, :task

        def initialize(lecture, task, tasks = [])
            @lecture, @task, @tasks = lecture, task, tasks
        end

        def self.from_request(params)
            task = params.include?(:id) ? Task.find(params[:id]) : Task.new
            Structure.new(Lecture.find(params[:lecture_id]), task)
        end
    end
end