class AddUserToRecords < ActiveRecord::Migration[6.0]
  def change
    # 在 records 表上, 添加 user_id 的字段
    add_reference :records, :user
  end
end
