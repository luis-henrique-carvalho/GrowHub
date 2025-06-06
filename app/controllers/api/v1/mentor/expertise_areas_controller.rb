# frozen_string_literal: true

module Api
  module V1
    module Mentor
      class ExpertiseAreasController < ApiController
        before_action :authenticate_user!, only: %i[index]

        def index
          result = ::Mentor::ExpertiseAreas::Filter.call(params: params, current_user:)

          if result.success?
            render json: paginate(result.payload, ::Mentor::ExpertiseAreaSerializer).to_json, status: :ok
          else
            render_errors(result.error, status: result.status)
          end
        end
      end
    end
  end
end
