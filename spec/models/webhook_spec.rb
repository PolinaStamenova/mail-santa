require 'rails_helper'

RSpec.describe Webhook, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }

    context 'validates the format of url' do
      it { should allow_value('http://example.com').for(:url) }
      it { should allow_value('https://example.com').for(:url) }
      it { should_not allow_value('ftp://example.com').for(:url) }
      it { should_not allow_value('example.com').for(:url) }
    end
  end
end
