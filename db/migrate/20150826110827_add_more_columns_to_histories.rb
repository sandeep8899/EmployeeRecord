class AddMoreColumnsToHistories < ActiveRecord::Migration
  def change
  	remove_column :histories , :time
  	add_column :histories , :in_time , :string
  	add_column :histories , :out_time , :string
  end
end
