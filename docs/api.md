## API Testing with Rswag

Mail Santa uses Rswag to generate and test the API documentation. To run API tests with Rswag, follow these steps:

1. **Install dependencies:**

    Make sure the necessary gems are installed by running:

    ```
    bundle install
    ```

2. **Run the API tests:**

    To run the tests for the API endpoints, use the following command:

    ```
    rspec spec/integration/api/v1/
    ```

3. **Add your test:**

    Create your test under the following directory `spec/integration/api/v1/`

    _Example:_

    ```
    spec/integration/api/v1/users_spec.rb
    ```

    Use the [Rswag Documentation](https://github.com/rswag/rswag) to create your test, or check existing tests in the project for reference.

4. **Define the expected response:**

    The expected response must be specified as a schema file in `spec/support/schemas/`. This file should be in YAML format.

    _Example:_

      ```
      spec/support/schemas/users.yml:

      type: array
      items:
        type: object
        properties:
          id:
            type: string
            description: "ID of the user"
          name:
            type: string
            description: "The name of the user"

          # Add other properties here
      ```
5. **Add the schema to swagger_helper.rb:**

    To make the schema accessible for reference in your tests, you need to add it to the `components/schemas` section in `spec/swagger_helper.rb`:

    _Example:_

    ```
      components: {
        schemas: {
          Users: YAML.load_file(Rails.root.join('spec', 'support', 'schemas', 'users.yml'))
        }
      }
    ```
6. **Write the API test:**

    When creating a test for an API endpoint, you need to validate the response structure. This ensures the data returned from the API matches the expected format, such as the correct fields and data types.

    By specifying the validation schema in your test with:

    ```
    schema '$ref' => '#/components/schemas/Users'
    ```

    You are linking the test to the schema definition we created earlier. **This means the test will check that the API response adheres to the structure** defined in the users.yml schema.

    **Why this is important:**

    - Consistency: Ensures that all API responses are consistent and match the defined structure. If the API changes, it will be easier to catch issues.
    - Documentation: Automatically updates the API documentation (Swagger UI) based on the schema, making the docs more accurate.
    - Error Checking: Helps catch missing or incorrect fields early in the development process.

    _Example Test:_

    ```
    require 'swagger_helper'

    RSpec.describe 'API::V1::Users', type: :request do
      path '/api/v1/users' do
        get 'Retrieves all users' do
          tags 'Users'
          produces 'application/json'

          response '200', 'successful' do
            before do
              user = User.create!(email: 'test@test.com', password: 'password', name: 'Test')
            end

            # Validate the response using the schema we defined earlier
            schema '$ref' => '#/components/schemas/Users'

            run_test!(openapi_strict_schema_validation: true)
          end
        end
      end
    end
    ```
7. **Generate the Swagger documentation:**
    After running the tests, auto-generate the updated API documentation by running:

    ```
    rake rswag:specs:swaggerize
    ```

    This will update the `swagger/v1/swagger.yaml` file with the newly defined endpoint details and schema.

8. **Access the API Documentation:**

    You can check the generated API documentation by visiting the Swagger UI here [API Documentation](http://localhost:3000/api-docs)
