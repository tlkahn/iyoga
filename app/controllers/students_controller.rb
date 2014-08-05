class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def edit
    if current_user
      @styles = Style.all
      @old_styles = @student.styles
    else
      flash[:notice] = 'You have not signed in yet.'
      redirect_to :root
    end
  end

  def show
    unless current_user
      flash[:notice] = 'You have not signed in yet.'
      redirect_to :root
    end
  end

  def update
    @student.phone = params["student"]["phone"]
    @student.introduction = params["student"]["introduction"]
    styles = params["student"]["styles"].split(",").collect(&:strip)
    @student.styles = styles
    @student.save
    flash[:notice] = "Saved."
    redirect_to :root
  end

  protected

  def set_student
    @student = Student.find params[:id]
  end
end
