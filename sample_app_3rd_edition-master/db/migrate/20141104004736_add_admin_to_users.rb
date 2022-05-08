class AddAdminToUsers < ActiveRecord::Migration
  def change # 関数定義
    add_column :users, :admin, :boolean, default: false
  end
end
