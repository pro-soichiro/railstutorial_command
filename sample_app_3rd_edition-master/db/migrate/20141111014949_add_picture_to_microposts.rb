class AddPictureToMicroposts < ActiveRecord::Migration
  def change # 関数定義
    add_column :microposts, :picture, :string
  end
end
