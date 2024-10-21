require 'rails_helper'

RSpec.describe Present, type: :model do
  describe 'associations' do
    it { should have_one(:child_wish) }
    it { should have_one(:user).through(:child_wish) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:size) }

    it 'validates inclusion of size' do
      valid_sizes = %w[small medium large]

      valid_sizes.each do |size|
        expect(Present.new(name: 'Test Present', color: 'Red', size:)).to be_valid
      end
    end
  end
end
