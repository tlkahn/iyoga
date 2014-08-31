class RemoveArrayColumnCertificatesAndStylesFromInstructors < ActiveRecord::Migration
  def change
  	remove_column :instructors, :certificates
  	remove_column :instructors, :styles
  end
end
