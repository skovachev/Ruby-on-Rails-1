# Tasks controller
class TasksController < ApplicationController
  before_filter :load_lecture, except: [ :destroy ]

  def index
    @tasks = Task.where(lecture_id: @lecture.id)
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.lecture = @lecture

    unless @task.save
      render 'new'
    else
      flash[:notice_ok] = 'Task saved successfully.'
      redirect_to action: 'show', id: @task.id
    end  
  end

  def update
    @task = Task.find(params[:id])
    unless @task.update_attributes(task_params)
      render 'edit'
    else
      redirect_to action: "show", id: @task.id
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

  def load_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end
end
