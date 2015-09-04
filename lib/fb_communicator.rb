class FbCommunicator
  include HTTParty
  base_uri 'https://graph.facebook.com/v2.4'

  def initialize(access_token, redirect_uri = 'http://localhost:3000')
    @access_token = access_token
    @redirect_uri = redirect_uri
  end

  def get_auth_token(code)
    response = self.class.get('/oauth/access_token', auth_token_params(code))
    @access_token = response['access_token']
    response
  end

  def friends
    friends = []
    self.class.get('/me/taggable_friends', get_friends_params)['data'].each do |f|
      friends << Friend.new(name: f['name'])
    end
    friends
  end

  private

  def auth_token_params(code)
    {
      query: {
        client_id: FB[:app_id],
        redirect_uri: "#{@redirect_uri}/login",
        client_secret: FB[:secret_id],
        code: code
      }
    }
  end

  def get_friends_params
    {
      query: {
        access_token: @access_token,
        limit: 10
      }
    }
  end
end
