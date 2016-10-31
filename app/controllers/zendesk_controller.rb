class ZendeskController < ApplicationController
  before_action :authenticate_user!
  require 'securerandom' unless defined?(SecureRandom)

  # Configuration
  ZENDESK_SHARED_SECRET = ENV["ZD_SSO_SECRET"]
  ZENDESK_SUBDOMAIN     = ENV["ZD_SUBDOMAIN"]

  def sso
  end

  def sign_in
    sign_into_zendesk(current_user)
  end

  def sign_out
    destroy_user_session_path
  end


  private
  def sign_into_zendesk(user)
    # This is the meat of the business, set up the parameters you wish
    # to forward to Zendesk. All parameters are documented in this page.
    iat = Time.now.to_i
    jti = "#{iat}/#{SecureRandom.hex(18)}"

    payload = JWT.encode({
      :iat   => iat, # Seconds since epoch, determine when this token is stale
      :jti   => jti, # Unique token id, helps prevent replay attacks
      :name  => user.name,
      :email => user.email,
    }, ZENDESK_SHARED_SECRET)

    redirect_to zendesk_sso_url(payload)
  end

  def zendesk_sso_url(payload)
    url = "https://#{ZENDESK_SUBDOMAIN}.zendesk.com/access/jwt?jwt=#{payload}"
    url += "&return_to=#{URI.escape(params["return_to"])}" if params["return_to"].present?
    url
  end

end

#https://devtest43.zendesk.com/access/jwt?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE0Nzc2NzAwMDcsImp0aSI6IjE0Nzc2NzAwMDcvZTg5YTQ3ZTM1MTAxOTQ0MjJkN2U0MjAxNjMyNDY3ZmMyNzI0IiwibmFtZSI6IlBlcGUgQXJnZW50byIsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSJ9.Vzkgn1IPIpPY4YB-FJJyLdtJgC8q8zNHc6VETLreB0c