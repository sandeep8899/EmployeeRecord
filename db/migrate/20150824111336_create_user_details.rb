class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
    	t.string :name , null: false
    	t.string :fathers_name , null: false
    	t.string :address , null: false
    	t.boolean :gender , null: false
    	t.integer :deparment_id
      t.timestamps null: false
    end
  end
end
