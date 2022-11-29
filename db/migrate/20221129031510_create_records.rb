class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.integer :amount, null: false
      t.integer :category, null: false, :limit => 1 #By default SQL String limit 255 character 
      t.string :notes
      t.timestamps
    end
  end
end
