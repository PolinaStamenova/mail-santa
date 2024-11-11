class ChangeUserIdToUuid < ActiveRecord::Migration[7.0]
  def up
    # Step 1: Add a new UUID column to `users` as the new primary key
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # Step 2: Backfill the `uuid` column for existing records
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:uuid, SecureRandom.uuid)
    end

    # Step 3: Remove foreign key constraint and old `user_id` from `child_wishes`
    remove_foreign_key :child_wishes, :users
    rename_column :child_wishes, :user_id, :old_user_id
    add_column :child_wishes, :user_id, :uuid

    # Step 4: Migrate data from `old_user_id` to new `user_id`
    execute <<-SQL.squish
      UPDATE child_wishes
      SET user_id = users.uuid
      FROM users
      WHERE child_wishes.old_user_id = users.id;
    SQL

    # Step 5: Remove the integer `id` column from `users` and rename `uuid` to `id`
    remove_column :users, :id
    rename_column :users, :uuid, :id
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"

    # Step 6: Add foreign key constraint back on `child_wishes` for `user_id`
    add_foreign_key :child_wishes, :users, column: :user_id

    # Step 7: Clean up the `old_user_id` column in `child_wishes`
    remove_column :child_wishes, :old_user_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
  
