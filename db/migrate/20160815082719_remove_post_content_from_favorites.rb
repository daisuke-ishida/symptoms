class RemovePostContentFromFavorites < ActiveRecord::Migration
  def change
    remove_column :favorites, :post_content, :text
  end
end
