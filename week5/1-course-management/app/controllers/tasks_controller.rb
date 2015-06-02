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

    if task.save
      flash[:notice_ok] = 'Task saved successfully.'
      redirect_to action: 'show', id: @struct.task.id
    else
      render 'new'
    end  
  end

  def update
    @struct = Tasks::Structure.from_request(params)
    if @struct.task.update_attributes(task_params)
      redirect_to action: "show", id: @struct.task.id      
    else
      render 'edit'
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
