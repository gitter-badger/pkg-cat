class AddTokenToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :token, :string, null: false
  end
end
