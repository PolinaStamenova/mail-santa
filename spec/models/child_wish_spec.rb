require 'rails_helper'

RSpec.describe ChildWish, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:present) }
  end
end
