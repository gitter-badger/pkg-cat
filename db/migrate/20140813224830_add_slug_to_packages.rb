class AddSlugToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :slug, :string, null: false
    add_index :packages, :slug, unique: true
  end
end
