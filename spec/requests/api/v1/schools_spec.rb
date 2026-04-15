require "swagger_helper"

RSpec.describe "api/v1/schools", type: :request do
  path "/api/v1/schools" do
    get "List schools" do
      tags "Schools"
      produces "application/json"

      response 200, "success" do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: { "$ref" => "#/components/schemas/School" }
            }
          }

        run_test!
      end
    end
  end
end