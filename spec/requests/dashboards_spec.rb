require 'rails_helper'

RSpec.describe 'ChildWishes', type: :request do
  describe 'POST /create' do
    let(:child) { User.create!(name: 'Thomas', email: 'test@test.com', password: 'password') }
    let(:present) { Present.create!(name: 'bike', color: 'red', size: 'medium') }

    before do
      sign_in child
    end

    context 'when the child has not created a wish for the current year' do
      it 'shows link to create wish message' do
        get dashboards_path

        expect(response.body).to include("Write your letter to Santa for #{Date.today.year}")
      end
    end

    context 'when the child has already created a wish for the current year' do
      it 'shows a message that they have already written their letter' do
        ChildWish.create!(user: child, present:)
        get dashboards_path

        expect(response.body).to include('You alreaady wrote your letter to Santa for this year.')
      end
    end

    context 'when the child has created a wish for the current year' do
      it 'displays their wishes' do
        ChildWish.create!(user: child, present:)

        get dashboards_path

        expect(response.body).to include('Your wishes')
      end
    end
  end
end
