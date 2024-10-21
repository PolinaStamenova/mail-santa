require 'rails_helper'

RSpec.describe 'ChildWishes', type: :request do
  describe 'POST /create' do
    let(:child) { User.create!(name: 'Thomas', email: 'test@test.com', password: 'password') }
    let(:valid_letter) { 'Dear Santa, I would like a red bike that is medium-sized.' }
    let(:invalid_letter) { 'Dear Santa, I would like a present.' }
    let(:present) { Present.create!(name: 'bike', color: 'red', size: 'medium') }

    before do
      sign_in child
    end

    context 'when the present is successfully created' do
      before { allow(Present).to receive(:create_from_letter).and_return(present) }

      it 'creates a new child wish' do
        expect do
          post child_wishes_path, params: { child_wish: { letter: valid_letter } }
        end.to change { ChildWish.count }.by(1)

        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq('Your wish has been sent to Santa!')
      end
    end

    context 'when the present is NOT successfully created' do
      before { allow(Present).to receive(:create_from_letter).and_return(nil) }

      it 'throw an error message' do
        expect do
          post child_wishes_path, params: { child_wish: { letter: invalid_letter } }
        end.to_not(change { ChildWish.count })

        expect(flash[:alert]).to eq("Sorry, Santa couldn't understand your wish. Please try again and be more specific.") # rubocop:disable Layout/LineLength
      end
    end
  end
end
