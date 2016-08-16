class AddContentToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :content, :text
  end
end
