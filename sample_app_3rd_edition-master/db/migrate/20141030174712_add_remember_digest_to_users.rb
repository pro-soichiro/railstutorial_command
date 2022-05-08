class AddRememberDigestToUsers < ActiveRecord::Migration
  def change # 関数定義
    add_column :users, :remember_digest, :string
  end
end
