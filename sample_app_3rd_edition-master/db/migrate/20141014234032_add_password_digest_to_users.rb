class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change # 関数定義
    add_column :users, :password_digest, :string
  end
end
