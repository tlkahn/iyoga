class StudentsController < ApplicationController
  def edit
    if current_user
      @student = Student.find_by_user_id(current_user.id)
      @styles = Style.all
      debugger
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
    styles.each do |s|
      sf = StyleFollowing.new
      sf.student_id = @student.id
      sf.style_id = Style.find_by_name(s).id
      unless Style.find_by_name(s).students.include? @student
        sf.save!
      end
    end
    @student.save
    flash[:notice] = "Saved."
    redirect_to student_path
  end
end
