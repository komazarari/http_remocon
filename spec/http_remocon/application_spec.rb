require 'spec_helper'

describe HttpRemocon::Application do

  def app
    HttpRemocon::Application
  end

  describe 'GET /' do
    it 'shows hello message' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello! \n-#{HttpRemocon}/
    end
  end

  let(:response_json) { JSON.parse(last_response.body) }

  describe 'POST /exec' do
    context 'with JSON \'{ commands : ["echo", "hello"] }\'' do
      it 'accepts posted commands' do
        post '/exec', '{ "commands" : ["echo", "hello"] }'
        expect(last_response).to be_ok
        expect { response_json }.not_to raise_error
        expect(response_json['status']).to eq 200
      end
    end

    context 'with invalid JSON \'{ commands : ["echo" "hello"] }\'' do
      it 'returns error messages' do
        post '/exec', '{ "commands" : ["echo" "hello"] }'
        expect(last_response).to be_client_error
        expect(response_json['status']).to eq 400
        expect(response_json['errors']).not_to be_empty
      end
    end
  end

  describe 'POST /exec_sync' do
    context 'with JSON \'{ commands : ["echo", "hello"] }\'' do
      it 'accepts posted commands' do
        post '/exec_sync', '{ "commands" : ["echo", "hello"] }'
        expect(last_response).to be_ok

        expect { response_json }.not_to raise_error
        expect(response_json['status']).to eq 200
        expect(response_json['results']['exitcode']).to eq 0
      end
    end

    context 'with invalid JSON  \'{ commands : ["echo", "hello",] }\' ' do
      it 'returns error messages' do
        post '/exec_sync', '{ commands : ["echo", "hello",] }'
        expect(last_response).to be_client_error
        expect(response_json['status']).to eq 400
        expect(response_json['errors']).not_to be_empty
      end
    end
  end

end
