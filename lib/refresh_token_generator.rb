# frozen_string_literal: true

class RefreshTokenGenerator
  attr_reader :resource

  REFRESH_TOKEN_VALIDITY_DAYS = 1

  def initialize(resource)
    @resource = resource
  end

  def payload
    {
      sub: resource.id,
      jti: resource.jti
    }
  end

  def refresh_token
    {
      value: jwt,
      httponly: true,
      expires: REFRESH_TOKEN_VALIDITY_DAYS.days.from_now,
      secure: Rails.env.production?
    }
  end

  def jwt
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key, 'HS256')
  end
end
