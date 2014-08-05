class RegistrationsController < Devise::RegistrationsController
	after_filter :add_account

  def create
    # add custom create logic here
    # but at this time, resource (i.e. the user) has not been saved yet.
    super
  end

  def update
    super
  end

  protected

  def add_account
    if resource.persisted? # user is created successfuly
    	student = Student.create!
      student.user_id = resource.id
      student.save!
    end
 end

end