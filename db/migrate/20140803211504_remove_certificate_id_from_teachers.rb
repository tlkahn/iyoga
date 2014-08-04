class RemoveCertificateIdFromTeachers < ActiveRecord::Migration
  def change
  	remove_column :teachers, :certificate_id
  end
end
