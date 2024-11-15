class CreateRepositoryChecks < ActiveRecord::Migration[7.1]
  def change
    create_table :repository_checks do |t|
      t.references :repository, null: false, foreign_key: true
      t.string :commit_id
      t.string :state
      t.json :result
      t.boolean :passed, default: false

      t.timestamps
    end
  end
end
