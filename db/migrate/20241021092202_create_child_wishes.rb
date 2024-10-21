class CreateChildWishes < ActiveRecord::Migration[7.0]
  def change
    create_table :child_wishes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :present, null: false, foreign_key: true

      t.timestamps
    end
  end
end
