class Webhook < ApplicationRecord
  validates :app_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  before_create :check_app_url_existance

  def check_app_url_existance
    return unless Webhook.exists?(app_url:)

    errors.add(:app_url, 'already exists')
    throw(:abort)
  end
end
