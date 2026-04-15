module Api
  module V1
    class StudentsController < Api::BaseController
      before_action :set_student!, only: :destroy
      before_action :authenticate!, only: :destroy

      rescue_from ActiveRecord::RecordInvalid do |exception|
        render json: { error: "Invalid input: #{exception.message}" }, status: :method_not_allowed
      end

      def index
        students = Student.where(
          school_id: params[:school_id],
          class_id: params[:class_id]
        )

        render json: {
          data: students.as_json(only: %i[id first_name last_name surname class_id school_id])
        }
      end

      def create
        student = Student.create!(student_params)

        token = auth_token(student)
        response.set_header("X-Auth-Token", token)

        render json: student.as_json(only: %i[id first_name last_name surname class_id school_id]),
               status: :created
      end

      def destroy
        @student.destroy!
        head :ok
      end

      private

      def student_params
        params.permit(:first_name, :last_name, :surname, :class_id, :school_id)
      end

      def set_student!
        @student = Student.find_by(id: params[:id])
        return head :bad_request unless @student
      end

      def authenticate!
        token = request.headers["Authorization"]&.split&.last
        expected = auth_token(@student)

        return head :unauthorized unless token == expected
      end

      def auth_token(student)
        Digest::SHA256.hexdigest("#{student.id}#{Rails.application.secret_key_base}")
      end
    end
  end
end