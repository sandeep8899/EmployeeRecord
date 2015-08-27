class IncreaseLimitOfColumnsInUserDetails < ActiveRecord::Migration
  def change
  	change_column :user_details , :contact_number , :string , :limit=> 10
  	change_column :user_details , :emergency_contact_number , :string , :limit=>10
  	change_column :user_details , :date_of_joining , :string , null: :false
  end
end
