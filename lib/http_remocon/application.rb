require 'sinatra'
require 'http_remocon/worker'
require 'json'
require 'pry'

module HttpRemocon
  class Application < Sinatra::Application
    configure do
#      set :locks, Hash.new { |h,k| h[k] = Mutex.new }
    end

    before '/exec*' do
      begin
        @request_body = JSON.parse(request.body.read)
      rescue JSON::ParserError => e
        response.status = 400
        @errors = [e.message]
      end
    end

    get '/' do
      "Hello! \n-#{HttpRemocon} #{HttpRemocon::VERSION}"
    end

    post '/exec' do
      if response.ok?
        commands = @request_body['commands']
        Worker.new.async.perform(commands.join(' '))
      else
        commands = nil
      end

      {
        status: response.status, commands: commands,
        results: nil,
        errors: @errors,
      }.to_json
    end

    post '/exec_sync' do
      if response.ok?
        commands = @request_body['commands']
        out, err, exitcode = Worker.new.perform(commands.join(' '))
      else
        commands = nil
        out, err, exitcode = []
      end

      {
        status: response.status, commands: commands,
        results: {
          stdout: out,
          stderr: err,
          exitcode: exitcode && exitcode.to_i,
        },
        errors: @errors,
      }.to_json
    end
  end
end
