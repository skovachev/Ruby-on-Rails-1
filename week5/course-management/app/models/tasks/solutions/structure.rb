module Tasks
  module Solutions
    class Structure
      attr_reader :lecture, :task
      attr_accessor :solutions, :solution

      def initialize(lecture, task, solution, solutions = [])
        @lecture, @task, @solution, @solutions = lecture, task, solution, solutions
      end

      def self.from_request(params)
        solution = params.include?(:id) ? Solution.find(params[:id]) : Solution.new
        Structure.new(Lecture.find(params[:lecture_id]), Task.find(params[:task_id]), solution)
      end
    end
  end
end
