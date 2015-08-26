class ChangeColumnTypeHistories < ActiveRecord::Migration
  def change
  	change_column :histories , :in_time , :time
  	change_column :histories , :out_time , :time
  end
end
