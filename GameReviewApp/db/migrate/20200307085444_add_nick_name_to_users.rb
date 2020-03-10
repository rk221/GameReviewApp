class AddNickNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false, limit: 30, default: '名無しさん'
  end
end
