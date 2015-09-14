require 'sinatra'
require 'http_remocon/worker'
require 'json'

#require 'pry'

module HttpRemocon
  class Application < Sinatra::Application
    configure do
      set :locks, Hash.new { |h,k| h[k] = Mutex.new }
    end

    get '/' do
      redirect to('/help')
    end

    get '/help' do
      'hello'
    end

    post '/exec' do
      body = JSON.parse(request.body.read)
      body['commands'] # array
      out_err, status = Worker.new.perform(body['commands'].join(' '))
      response.status = status ? 200 : 500
      response.body = { status: response.status, body: out_err }.to_json
    end

    post '/exec_async' do
      body = JSON.parse(request.body.read)
      body['commands'] # array

#      Worker.new.async.perform(body['commands'].join(' '), settings.locks[params[:lock]])
    end
  end
end
