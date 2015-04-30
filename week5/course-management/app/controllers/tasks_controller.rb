# Tasks controller
class TasksController < ApplicationController
  def index
    @struct = Tasks::Structure.from_request(params)
    @struct.tasks = Task.where(lecture_id: @struct.lecture.id)
  end

  def new
    @struct = Tasks::Structure.from_request(params)
  end

  def show
    @struct = Tasks::Structure.from_request(params)
  end

  def edit
    @struct = Tasks::Structure.from_request(params)
  end

  def create
    @struct = Tasks::Structure.from_request(params)

    task = Task.new(task_params)
    task.lecture = @struct.lecture
    @struct.task = task

    unless task.save
      render 'new'
    else
      flash[:notice_ok] = 'Task saved successfully.'
      redirect_to action: 'show', id: @struct.task.id
    end  
  end

  def update
    @struct = Tasks::Structure.from_request(params)
    unless @struct.task.update_attributes(task_params)
      render 'edit'
    else
      redirect_to action: "show", id: @struct.task.id
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:notice_ok] = 'Task deleted successfully.'
    redirect_to action: "index"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
