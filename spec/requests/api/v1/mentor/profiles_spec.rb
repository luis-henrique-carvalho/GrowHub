# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Mentor::Profiles', type: :request do
  let(:current_user) { create(:user, :mentor) }

  path '/api/v1/mentor/profiles/{id}' do
    get 'Show Mentor Profile', params: { use_as_request_example: true } do
      tags 'Profiles'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      let(:id) { current_user.mentor_profile.id }
      let(:Authorization) { authenticated_header({}, current_user)['Authorization'] }

      generate_response_examples

      response 200, 'Successful' do
        schema '$ref': '#/components/schemas/v1/profiles/responses/show'

        run_test!
      end

      response 401, 'Unauthorized' do
        let(:Authorization) { nil }

        it 'returns correct error message' do
          expect_error('auth', 'unauthenticated', message_key_type: 'devise.failure')
        end

        run_test!
      end

      response 404, 'Not found' do
        let(:id) { 'not_an_id' }

        it 'returns correct error message' do
          expect_error('base', 'active_record.record_not_found', options: { model: 'Mentor::Profile', id: 'not_an_id' })
        end

        run_test!
      end
    end
  end
end
