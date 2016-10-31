class AddColumnToSuperusers < ActiveRecord::Migration
  def change
    add_column :superusers, :image, :string
    add_column :superusers, :following_count, :integer
    add_column :superusers, :description, :string
  end
end
