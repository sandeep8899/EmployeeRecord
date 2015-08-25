class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
    	t.string :date , null: false
    	t.string :time , null: false
    	t.integer :user_detail_id , null: false
      t.timestamps null: false
    end
  end
end
