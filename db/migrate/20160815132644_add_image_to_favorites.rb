class AddImageToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :image, :string
  end
end
