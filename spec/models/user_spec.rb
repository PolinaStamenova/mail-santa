require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#santa?' do
    it 'returns true' do
      user = User.new(name: 'Santa', email: 'santa@test.com', password: '123456', role: 'santa')
      user.save!

      expect(user.santa?).to be(true)
    end
  end
end
