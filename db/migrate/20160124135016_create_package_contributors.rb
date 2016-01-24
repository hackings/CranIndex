class CreatePackageContributors < ActiveRecord::Migration
  def change
    create_table :package_contributors do |t|
      t.integer :package_id
      t.integer :contributor_id
      t.string :contributor_type

      t.timestamps null: false
    end
  end
end
