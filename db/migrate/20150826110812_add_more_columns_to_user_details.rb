class AddMoreColumnsToUserDetails < ActiveRecord::Migration
  def change
  	add_column :user_details , :contact_number , :integer , null: false
  	add_column :user_details , :date_of_joining , :string , null: false
  	add_column :user_details , :emergency_contact_number , :integer , null: false
  end
end
