class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name, null: false, default: ""
      t.text :url, null: false
      t.belongs_to :package, index: true, null: false
    end
  end
end
