require 'spec_helper'

describe HttpRemocon do

  def app
    HttpRemocon::Application
  end

  describe 'GET /' do
    it 'shows hello messege' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello! \n-#{HttpRemocon}/
    end
  end
end

