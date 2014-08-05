class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :subject, null: false, default: ""
      t.string :email, null: false
      t.string :author, null: false, default: ""
      t.text :bio, null: false, default: ""
      t.string :twitter, null: false, default: ""
      t.string :github, null: false, default: ""
      t.string :blog, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :links, null: false, array: true, default: []

      t.timestamps null: false
    end
  end
end
