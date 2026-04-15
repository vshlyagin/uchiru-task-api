module Api
  module V1
    class SchoolsController < Api::BaseController
      def index
        schools = School.all

        render json: { data: schools }
      end
    end
  end
end