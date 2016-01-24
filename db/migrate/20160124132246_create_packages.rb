class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.date :published_date
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
