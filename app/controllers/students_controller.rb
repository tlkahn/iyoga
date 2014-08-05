class StudentsController < ApplicationController
  def edit
    if current_user
      @student = Student.find_by_user_id(current_user.id)
      @styles = Style.all
      @old_styles = @student.styles
    else
      flash[:notice] = 'You have not signed in yet.'
      redirect_to :root
    end
  end

  def show
    if current_user
      @student = Student.find_by_user_id(current_user.id)
    end
  end

  def update
    @student = Student.find_by_user_id(current_user.id)
    @student.phone = params["student"]["phone"]
    @student.introduction = params["student"]["introduction"]
    styles = params["student"]["styles"].split(",").collect(&:strip)
    @student.styles = styles
    @student.save
    flash[:notice] = "Saved."
    redirect_to :root
  end
end
