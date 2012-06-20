Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yammer, 'kvGDzE1a5A125MtYlVa96g', 'Zqep385R9PZ9gQoTab341cfljm9F06krlkORNl8U28' #production

  # monkey-patch for staging
  # provider :yammer, 'B1q8cB3pFrk2fk61B5rTQ', '4uLqYK7y28iTfhatgQp3SB7XfDhthRJsNfCJl3Farr4' #staging
  # 
  # module OmniAuth
  #   module Strategies
  #     class Yammer < OmniAuth::Strategies::OAuth2
  #       option :client_options, {
  #         :site => 'https://www.staging.yammer.com',
  #         :authorize_url => '/dialog/oauth',
  #         :token_url => '/oauth2/access_token.json'
  #       }
  #     end
  #   end
  # end
end