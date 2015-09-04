require 'rails_helper'

RSpec.describe AuthController, :type => :controller do
    describe '#login' do
      context 'without params' do
        it 'redirects to facebook page' do
          get :login
          expect(response).to redirect_to %r(\Ahttps://www.facebook.com)
        end
      end

      context 'with params' do
        it 'sets session and redirects to root' do
          allow(subject.fb).to receive(:get_auth_token).and_return('sometoken')
          get :login, code: '123'
          expect(session[:fb]).to eql 'sometoken'
          expect(response).to redirect_to root_path
        end
      end
    end
end
