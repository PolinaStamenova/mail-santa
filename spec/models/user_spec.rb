require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:child_wishes) }
    it { should have_many(:presents).through(:child_wishes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
