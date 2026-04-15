module Api
  module V1
    class ClassesController < Api::BaseController
      def index
        classes = SchoolClass.where(school_id: params[:school_id])

        render json: {
          data: classes.as_json(only: %i[id number letter students_count])
        }
      end
    end
  end
end