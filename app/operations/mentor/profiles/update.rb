# frozen_string_literal: true

module Mentor
  module Profiles
    class Update < ApplicationOperation
      def call(params)
        set_params params

        set_model
        restrict_safe_params
        update_model

        success @model
      end

      private

      def set_model
        @model = @current_user.mentor_profile
      end

      def restrict_safe_params
        @safe_params = @params.permit(:bio, :headline, :hourly_rate, :linkedin_url, :profile_name, :rating,
                                 :years_of_experience)
      end

      def update_model
        @model.update!(@safe_params)
      end
    end
  end
end
