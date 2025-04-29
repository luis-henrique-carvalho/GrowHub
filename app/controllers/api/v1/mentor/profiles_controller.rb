# frozen_string_literal: true

module Api
  module V1
    module Mentor
      class ProfilesController < ApiController
        before_action :set_user, only: %i[show update]
        before_action :authenticate_user!, only: %i[show update]

        def show
          result = ::Mentor::Profile::Show.call(params: mentor_profile)

          if result.success?
            render json: ::Mentor::ProfileSerializer.render(result.payload, view: :private, root: :data)
          else
            render_errors(result.error, status: result.status)
          end
        end

        private

        def set_profile
          @mentor_profile = Mentor::Profile.find(params[:id])
        end
      end
    end
  end
end
