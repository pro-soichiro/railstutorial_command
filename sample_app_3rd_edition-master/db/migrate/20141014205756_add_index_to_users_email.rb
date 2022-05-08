class AddIndexToUsersEmail < ActiveRecord::Migration
  def change # 関数定義
    add_index :users, :email, unique: true
  end
end
