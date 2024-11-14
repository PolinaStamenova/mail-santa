class CreatePresents < ActiveRecord::Migration[7.0]
  def change
    create_table :presents do |t|
      t.string :name
      t.string :color
      t.integer :size

      t.timestamps
    end
  end
end
