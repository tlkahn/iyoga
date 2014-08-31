class AddFullNameToCertificate < ActiveRecord::Migration
  def change
  	add_column :certificates, :full_name, :string
  end
end
