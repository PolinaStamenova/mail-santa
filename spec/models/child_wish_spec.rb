require 'rails_helper'

RSpec.describe ChildWish, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:present) }
  end

  describe 'scopes' do
    context 'from_this_year' do
      it 'returns the child wishes created this year' do
        child = User.create!(name: 'Thomas', email: 'thomas@test.com', password: 'password')
        present = Present.create!(name: 'bike', color: 'red', size: 'medium')
        child_wish_from_this_year = ChildWish.create!(user: child, present:, created_at: Date.today)
        child_wish_from_last_year = ChildWish.create!(user: child, present:, created_at: Date.today - 1.year)

        expect(child.child_wishes.from_this_year).to include(child_wish_from_this_year)
        expect(ChildWish.from_this_year).not_to include(child_wish_from_last_year)
      end
    end
  end
end
