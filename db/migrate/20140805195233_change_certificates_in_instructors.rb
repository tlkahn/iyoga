class ChangeCertificatesInInstructors < ActiveRecord::Migration
  def change
  	change_column :instructors, :certificates, :string, array:true, default: []
  end
end
