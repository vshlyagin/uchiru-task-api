require 'rails_helper'

RSpec.describe 'Api::V1::Classes', type: :request do
  path "/api/v1/schools/{school_id}/classes" do
    parameter name: :school_id, in: :path, type: :integer, example: 1

    get "List classes" do
      tags "Сlasses"
      produces "application/json"

      response '200', 'Список классов' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: { "$ref" => "#/components/schemas/Class" }
            }
          }

        let(:school) { School.first || create(:school) }
        let(:school_id) { school.id }

        run_test!
      end
    end
  end
end