# Lectures controller
class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def new
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

  def create
    lecture = Lecture.new(lecture_params)

    unless lecture.save
      flash[:notice_err] = 'Invalid data submitted.'
      flash[:errors] = lecture.errors
      redirect_to action: 'new'
    else
      redirect_to action: 'show', id: lecture.id
    end  
  end

  def update
    lecture = Lecture.find(params[:id])
    lecture.update(lecture_params)
    # TODO: check if valid
    redirect_to action: "show", id: lecture.id
  end

  def destroy
    lecture = Lecture.find(params[:id])
    lecture.destroy
    flash[:notice_ok] = 'Lecture deleted successfully.'
    redirect_to action: "index"
  end

  private

  def lecture_params
    params.require(:lecture).permit(:name, :description)
  end
end
