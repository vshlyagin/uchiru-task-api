require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  path "/api/v1/schools/{school_id}/classes/{class_id}/students" do
    parameter name: :school_id, in: :path, type: :integer, example: 1
    parameter name: :class_id, in: :path, type: :integer, example: 1

    get "List students" do
      tags "Students"
      produces "application/json"

      response '200', 'Список студентов' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: { "$ref" => "#/components/schemas/Student" }
            }
          }

        let(:school) { School.first || create(:school) }
        let(:klass) { SchoolClass.first || create(:school_class, school:) }

        let(:school_id) { school.id }
        let(:class_id) { klass.id }

        before do
          create(:student, school:, class: klass)
        end

        run_test!
      end
    end
  end

  path "/api/v1/students" do
    post "Create student" do
      tags "Students"
      consumes "application/json"
      produces "application/json"

      parameter name: :student, in: :body, schema: {
        type: :object,
        required: %w[first_name last_name surname school_id class_id],
        properties: {
          first_name: { type: :string, example: "Ivan" },
          last_name: { type: :string, example: "Ivanov" },
          surname: { type: :string, example: "Ivanovich" },
          school_id: { type: :integer, example: 1 },
          class_id: { type: :integer, example: 1 }
        }
      }

      response '201', 'Successful operation' do
        header 'X-Auth-Token', schema: { type: :string }, description: 'Токен для последующей авторизации'
        schema '$ref' => '#/components/schemas/Student'

        let(:school) { School.first || create(:school) }
        let(:klass) { SchoolClass.first || create(:school_class, school:) }

        let(:student) do
          {
            first_name: "Ivan",
            last_name: "Ivanov",
            surname: "Ivanovich",
            school_id: school.id,
            class_id: klass.id
          }
        end

        run_test!
      end

      response '405', 'Invalid input' do
        let(:student) { { first_name: "" } }
        run_test!
      end
    end
  end

  path "/api/v1/students/{user_id}" do
    parameter name: :user_id, in: :path, type: :integer, example: 1

    delete "Delete student" do
      tags "Students"
      produces "application/json"
      security [bearerAuth: []]

      response '200', 'deleted' do
        let(:school) { School.first || create(:school) }
        let(:klass) { SchoolClass.first || create(:school_class, school:) }

        let!(:student_record) do
          Student.create!(
            first_name: "Ivan",
            last_name: "Ivanov",
            surname: "Ivanovich",
            school:,
            class: klass
          )
        end

        let(:user_id) { student_record.id }

        let(:Authorization) do
          token = Digest::SHA256.hexdigest("#{student_record.id}#{Rails.application.secret_key_base}")
          "Bearer #{token}"
        end

        run_test! do
          expect(Student.find_by(id: student_record.id)).to be_nil
        end
      end

      response '401', 'Некорректная авторизация' do
        let(:user_id) { 1 }
        let(:Authorization) { "Bearer invalid_token" }
        run_test!
      end
    end
  end
end