# Lectures controller
class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def new
    @lecture = Lecture.new
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

  def create
    @lecture = Lecture.new(lecture_params)

    if @lecture.save
      flash[:notice_ok] = 'Lecture saved successfully.'
      redirect_to action: 'show', id: @lecture.id
    else
      render 'new'      
    end  
  end

  def update
    @lecture = Lecture.find(params[:id])
    if @lecture.update_attributes(lecture_params)
      redirect_to action: "show", id: @lecture.id      
    else
      render 'edit'
    end
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
