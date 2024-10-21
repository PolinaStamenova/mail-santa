require 'rails_helper'

RSpec.describe OpenAiService, :vcr do
  let(:service) { OpenAiService.new }
  let(:valid_letter) { 'Dear Santa, I would like a red bicycle that is large.' }
  let(:invalid_letter) { 'Dear Santa, I want something' }

  describe '#extract_present_details' do
    context 'when making a real request to OpenAI' do
      it 'returns present details as a hash' do
        VCR.use_cassette('openai/extract_present_details') do
          result = service.extract_present_details(valid_letter)

          expect(result).to eq({
                                 'present_name' => 'bicycle',
                                 'present_color' => 'red',
                                 'present_size' => 'large'
                               })
        end
      end
    end

    context 'when the request to OpenAI fails' do
      it 'returns nil' do
        VCR.use_cassette('openai/extract_present_details_error') do
          result = service.extract_present_details(invalid_letter)

          expect(result).to be_nil
        end
      end
    end
  end
end
