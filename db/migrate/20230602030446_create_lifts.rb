class CreateLifts < ActiveRecord::Migration[7.0]
  def change
    create_table :lifts do |t|
      t.string :name
      t.string :status
      t.references :resort, null: false, foreign_key: true

      t.timestamps
    end
  end
end
