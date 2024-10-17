require 'rails_helper'

RSpec.describe Present, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:size) }
    it { should validate_inclusion_of(:size).in_array(Present.sizes.keys) }
  end
end
