class AddPostContentToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :post_content, :text
  end
end
