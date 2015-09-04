require 'rails_helper'

RSpec.describe FbCommunicator do
  it 'should have set base uri' do
    expect(FbCommunicator.base_uri).to eql 'https://graph.facebook.com/v2.4'
  end

  describe '#get_auth_token' do
    it 'sets access token' do
      stub_request(:get, 'https://graph.facebook.com/v2.4/oauth/access_token')
        .with(
          query: {
            client_id: FB[:app_id],
            redirect_uri: 'http://localhost:3000/login',
            client_secret: FB[:secret_id],
            code: 'code'
          }
        )
        .to_return(
          body: '{"access_token": "sometoken"}',
          headers: {"Content-Type": "application/json"}
        )
      fb = FbCommunicator.new nil
      expect(fb.get_auth_token('code')).to eql({"access_token" => "sometoken"})
      expect(fb.instance_variable_get(:@access_token)).to eql 'sometoken'
    end
  end

  describe '#friends' do
    it 'returns friends list' do
      stub_request(:get, 'https://graph.facebook.com/v2.4/me/taggable_friends')
        .with(
          query: {
            access_token: 'sometoken',
            limit: 10
          }
        )
        .to_return(
          body: '{"data": [{"name": "Some friend"}]}',
          headers: {"Content-Type": "application/json"}
        )
      fb = FbCommunicator.new 'sometoken'
      response = fb.friends
      expect(response.length).to eql(1)
      expect(response.first.name).to eq 'Some friend'
    end
  end
end
