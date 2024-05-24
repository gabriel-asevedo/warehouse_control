class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.integer :quantity
      t.string :action_type
      t.references :user, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true

      t.timestamps
    end
  end
end
