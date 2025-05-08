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
        schema '$ref': '#/components/schemas/v1/mentor/profiles/responses/show'

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

    put 'Update Mentor Profile', params: { use_as_request_example: true } do
      tags 'Mentor Profiles'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, schema: { '$ref': '#/components/schemas/v1/mentor/profile/requests/update' }

      let(:id) { create(:mentor_profile, user: current_user).id }
      let(:body) { nil }
      let(:Authorization) { authenticated_header({}, current_user)['Authorization'] }

      generate_response_examples

      response 200, 'Successful' do

        let(:body) { { mentor_profile: mentor_profile_attributes } }
        let(:mentor_profile_attributes) do
          { bio: 'Updated Bio', headline: 'Updated Headline', hourly_rate: 50.0,
            linkedin_url: 'https://linkedin.com/in/updated', profile_name: 'Updated Profile', rating: 4.5, years_of_experience: 5 }
        end

        schema '$ref': '#/components/schemas/v1/mentor/profiles/responses/update'

        it 'returns the correct data' do
          expect(response_body['data']['profile_name']).to eq(mentor_profile_attributes[:profile_name])
        end

        run_test!
      end

      # TODO: Add tests when the profile_name is not null
      # response 422, 'Validates errors' do
      #   let(:id) { create(:mentor_profile, user: current_user).id }
      #   let(:body) { { mentor_profile: { profile_name: nil } } }

      #   it 'returns correct error message' do
      #     expect_error('profile_name', 'blank')
      #   end

      #   run_test!
      # end

      response 401, 'Unauthorized' do
        let(:Authorization) { nil }

        it 'returns correct error message' do
          expect_error('auth', 'unauthenticated', message_key_type: 'devise.failure')
        end

        run_test!
      end
    end
  end
end
