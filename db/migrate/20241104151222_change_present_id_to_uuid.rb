class ChangePresentIdToUuid < ActiveRecord::Migration[7.0]
  def up
    # Step 1: Add a new UUID column to `presents`
    add_column :presents, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # Step 2: Backfill the `uuid` column for existing records
    Present.reset_column_information
    Present.find_each do |present|
      present.update_column(:uuid, SecureRandom.uuid)
    end

    # Step 3: Remove foreign key constraint and old `present_id` from `child_wishes`
    remove_foreign_key :child_wishes, :presents
    rename_column :child_wishes, :present_id, :old_present_id
    add_column :child_wishes, :present_id, :uuid

    # Step 4: Migrate data from `old_present_id` to new `present_id`
    execute <<-SQL.squish
      UPDATE child_wishes
      SET present_id = presents.uuid
      FROM presents
      WHERE child_wishes.old_present_id = presents.id;
    SQL

    # Step 5: Remove the integer `id` column from `presents` and rename `uuid` to `id`
    remove_column :presents, :id
    rename_column :presents, :uuid, :id
    execute "ALTER TABLE presents ADD PRIMARY KEY (id);"

    # Step 6: Add foreign key constraint back on `child_wishes` for `present_id`
    add_foreign_key :child_wishes, :presents, column: :present_id

    # Step 7: Clean up the `old_present_id` column in `child_wishes`
    remove_column :child_wishes, :old_present_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
  
