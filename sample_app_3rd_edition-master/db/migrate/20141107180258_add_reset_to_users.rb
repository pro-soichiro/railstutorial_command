class AddResetToUsers < ActiveRecord::Migration
  def change # 関数定義
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
