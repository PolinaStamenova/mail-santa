require 'openai'

class OpenAiService
  # Initialize the OpenAI client with the API key
  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key))
  end

  # Extract the present details from the letter using the GPT-4 model
  def extract_present_details(letter)
    prompt = <<-PROMPT
      You are Santa's assistant. A child wrote a letter asking for a present. Please extract the following details from the letter:
      1. Present name (e.g., bike, doll, toy car, etc.).
      2. Present color.
      3. Present size (small, medium, or large).

      Return the details in the following JSON format:
      {
        "present_name": "example_name",
        "present_color": "example_color",
        "present_size": "example_size"
      }

      Here is the letter: "#{letter}"
    PROMPT

    response = @client.chat(
      parameters: {
        model: 'gpt-4',
        messages: [{ role: 'user', content: prompt }],
        max_tokens: 150
      }
    )

    begin
      JSON.parse(response['choices'].first['message']['content'])
    rescue JSON::ParserError => e
      Rails.logger.error "Error parsing GPT response: #{e.message}"
      nil
    end
  end
end
