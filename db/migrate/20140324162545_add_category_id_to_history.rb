class AddCategoryIdToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :category_id, :integer
  end
end
