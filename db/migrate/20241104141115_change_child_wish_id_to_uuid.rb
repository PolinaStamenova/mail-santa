class ChangeChildWishIdToUuid < ActiveRecord::Migration[7.0]
  def up
    # Add a new UUID column to act as primary key temporarily
    add_column :child_wishes, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # Update foreign keys or references if necessary to use :uuid (if you have associated tables)

    # Remove the old primary key and rename uuid column to id
    remove_column :child_wishes, :id
    rename_column :child_wishes, :uuid, :id

    # Set the new id column as primary key
    execute "ALTER TABLE child_wishes ADD PRIMARY KEY (id);"
  end

  def down
  end
end
