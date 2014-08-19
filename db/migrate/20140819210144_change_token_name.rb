class ChangeTokenName < ActiveRecord::Migration
  def change
    rename_column :packages, :token, :private_token
  end
end
