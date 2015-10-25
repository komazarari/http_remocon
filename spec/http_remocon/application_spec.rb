require 'pry-byebug'
require 'spec_helper'

describe HttpRemocon::Application do

  def app
    HttpRemocon::Application
  end

  describe 'GET /' do
    it 'shows hello message' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello! \n- #{HttpRemocon}/
    end
  end

  let(:response_json) { JSON.parse(last_response.body) }

  describe 'POST /' do
    let(:json) { <<-EOS }
'{ "jsonrpc": "2.0", "method": #{method},
   "params": #{params}, "id": "1" }'
    EOS

    context '"method": "exec"' do
      let(:method) { %|"exec"| }
      let(:params) { %|["echo", "hello"]| }

      context "with JSON" do
        it 'accepts posted commands' do
          post '/', json
          expect(last_response).to be_ok, "Actual status: #{last_response.status}"
          expect { response_json }.not_to raise_error
          expect(response_json['result']['status']).to eq 200
        end
      end

      context "with invalid JSON" do
        let(:params) { %|["echo" "no-comma in array"]| }

        it 'returns error messages' do
          post '/', json
          expect(last_response).to be_client_error, "Actual status: #{last_response.status}"
          expect(response_json['error']['code']).to eq -32700
          expect(response_json['error']['message']).not_to be_empty
        end
      end
    end
  end

#
#    context 'with command filter [/echo hello/], max_length=3' do
#      before do
#        HttpRemocon::Filter::Commands.allowed_commands = [/echo hello/]
#        HttpRemocon::Filter::Commands.max_length = 3
#      end
#
#      after do
#        HttpRemocon::Filter::Commands.clear
#      end
#
#      context 'when command not allowed - ["ls", "-l", "/etc"] -' do
#        it "shows bad request" do
#          post '/exec', '{ "commands" : ["ls", "-l", "/etc"] }'
#          expect(last_response).to be_client_error, "Actual status: #{last_response.status}"
#          expect(response_json['status']).to eq 403
#          expect(response_json['errors']).not_to be_empty
#        end
#      end
#
#      context 'when command allowed - ["echo", "hello", "world"] -' do
#        it "accepts request" do
#          post '/exec', '{ "commands" : ["echo", "hello", "world"] }'
#          expect(last_response).to be_ok, "Actual status: #{last_response.status}"
#          expect(response_json['status']).to eq 200
#          expect(response_json['errors']).to be_empty
#        end
#      end
#
#      context 'when command too long - ["echo", "hello", "|", "cat"] -' do
#        it "shows bad request" do
#          post '/exec', '{ "commands" : ["echo", "hello", "|", "cat"] }'
#          expect(last_response).to be_client_error, "Actual status: #{last_response.status}"
#          expect(response_json['status']).to eq 403
#          expect(response_json['errors']).not_to be_empty
#        end
#      end
#    end
#  end
#
#  describe 'POST /exec_sync' do
#    context 'with JSON \'{ commands : ["echo", "hello"] }\'' do
#      it 'accepts posted commands' do
#        post '/exec_sync', '{ "commands" : ["echo", "hello"] }'
#        expect(last_response).to be_ok, "Actual status: #{last_response.status}"
#        expect { response_json }.not_to raise_error
#        expect(response_json['status']).to eq 200
#        expect(response_json['results']['exitcode']).to eq 0
#      end
#    end
#
#    context 'with invalid JSON  \'{ commands : ["echo", "hello",] }\' ' do
#      it 'returns error messages' do
#        post '/exec_sync', '{ commands : ["echo", "hello",] }'
#        expect(last_response).to be_client_error, "Actual status: #{last_response.status}"
#        expect(response_json['status']).to eq 400
#        expect(response_json['errors']).not_to be_empty
#      end
#    end
#  end
end
