require 'rails_helper'

RSpec.describe MainController, :type => :controller do
    describe '#index' do
      context 'logged in' do
        it 'sets friends' do
          allow(subject).to receive(:logged_in?).and_return(true)
          allow(subject.fb).to receive(:friends).and_return([Friend.new(name: 'Some friend')])
          get :index
          expect(subject.instance_variable_get(:@friends).first.name).to eql 'Some friend'
        end
      end

      context 'not logged in' do
        it 'friends are not set' do
          allow(subject).to receive(:logged_in?).and_return(false)
          get :index
          expect(subject.instance_variable_get(:@friends)).to be_nil
        end
      end
    end
end
