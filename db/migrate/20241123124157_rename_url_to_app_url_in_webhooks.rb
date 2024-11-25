class RenameUrlToAppUrlInWebhooks < ActiveRecord::Migration[7.0]
  def change
    rename_column :webhooks, :url, :app_url
  end
end
