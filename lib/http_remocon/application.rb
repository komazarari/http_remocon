require 'sinatra'
require 'http_remocon/worker'
require 'json'
require 'pry'

module HttpRemocon
  class Application < Sinatra::Application
    configure do
#      set :locks, Hash.new { |h,k| h[k] = Mutex.new }
    end

    get '/' do
      "Hello! \n-#{HttpRemocon} #{HttpRemocon::VERSION}"
    end

    post '/exec' do
      body = JSON.parse(request.body.read)
      Worker.new.async.perform(body['commands'].join(' '))

#      response.status = status ? 200 : 500
#      response.body = { status: response.status, body: out_err }.to_json

      { status: 'ok', accepted: body['commands'], results: nil }.to_json
    end

    post '/exec_sync' do
      body = JSON.parse(request.body.read)
      out, err, status = Worker.new.perform(body['commands'].join(' '))

      {
        status: 'ok', accepted: body['commands'],
        results: {
          stdout: out,
          stderr: err,
          status: status.to_i,
        }
      }.to_json
    end
  end
end
