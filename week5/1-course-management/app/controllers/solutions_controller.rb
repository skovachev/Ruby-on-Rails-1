# Solutions controller
class SolutionsController < ApplicationController
  def index
    @struct = Tasks::Solutions::Structure.from_request(params)
    @struct.solutions = Solution.where(task_id: @struct.task.id)
  end

  def new
    @struct = Tasks::Solutions::Structure.from_request(params)
  end

  def show
    @struct = Tasks::Solutions::Structure.from_request(params)
  end

  def edit
    @struct = Tasks::Solutions::Structure.from_request(params)
  end

  def create
    @struct = Tasks::Solutions::Structure.from_request(params)

    solution = Solution.new(solution_params)
    solution.task = @struct.task
    @struct.solution = solution

    if solution.save
      flash[:notice_ok] = 'Solution saved successfully.'
      redirect_to action: 'show', id: @struct.solution.id
    else
      render 'new'      
    end  
  end

  def update
    @struct = Tasks::Solutions::Structure.from_request(params)
    if @struct.solution.update_attributes(solution_params)
      redirect_to action: "show", id: @struct.solution.id      
    else
      render 'edit'
    end
  end

  def destroy
    solution = Solution.find(params[:id])
    solution.destroy
    flash[:notice_ok] = 'Solution deleted successfully.'
    redirect_to action: "index"
  end

  private

  def solution_params
    params.require(:solution).permit(:body)
  end
end
