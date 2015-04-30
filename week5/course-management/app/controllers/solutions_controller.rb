# Solutions controller
class SolutionsController < ApplicationController
  before_filter :load_related_models, except: [ :destroy ]

  def index
    @solutions = Solution.where(task_id: @task.id)
  end

  def new
    @solution = Solution.new
  end

  def show
    @solution = Solution.find(params[:id])
  end

  def edit
    @solution = Solution.find(params[:id])
  end

  def create
    @solution = Solution.new(solution_params)
    @solution.task = @task

    unless @solution.save
      render 'new'
    else
      flash[:notice_ok] = 'Solution saved successfully.'
      redirect_to action: 'show', id: @solution.id
    end  
  end

  def update
    @solution = Solution.find(params[:id])
    unless @solution.update_attributes(solution_params)
      render 'edit'
    else
      redirect_to action: "show", id: @solution.id
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

  def load_related_models
    @lecture = Lecture.find(params[:lecture_id])
    @task = Task.find(params[:task_id])
  end
end
