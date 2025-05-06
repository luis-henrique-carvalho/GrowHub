# frozen_string_literal: true

module Api
  module V1
    module Mentor
      class ProfilesController < ApiController
        before_action :set_profile, only: %i[show update]
        before_action :authenticate_user!, only: %i[show update]

        def show
          result = ::Mentor::Profiles::Show.call(params: @mentor_profile)

          if result.success?
            render json: ::Mentor::ProfileSerializer.render(result.payload, view: :private, root: :data)
          else
            render_errors(result.error, status: result.status)
          end
        end

        def update
          result = ::Mentor::Profiles::Update.call(params: update_params, current_user:)

          if result.success?
            render json: ::Mentor::ProfileSerializer.render(result.payload, view: :private, root: :data)
          else
            render_errors(result.error, status: result.status)
          end
        end

        private

        def set_profile
          @mentor_profile = ::Mentor::Profile.find(params[:id])
        end

        def update_params
          params_with_id(params.require(:mentor_profile))
        end
      end
    end
  end
end
