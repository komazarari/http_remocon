require 'sinatra/base'
require 'sinatra/json_rpc'

#require 'http_remocon/worker'
#require 'http_remocon/filter'
require 'json'
require 'pry'

module HttpRemocon
  class Application < Sinatra::Application
    configure do
#      set :locks, Hash.new { |h,k| h[k] = Mutex.new }
    end
    set(:http_method) { |value| condition { request.request_method == value }}

    get '/' do
      "Hello! \n- #{HttpRemocon} #{HttpRemocon::VERSION}"
    end

register Sinatra::JsonRpc
#    before http_method: 'POST' do
#      begin
#        @request_body = JSON.parse(request.body.read)
#      rescue JSON::ParserError => e
#        halt 400, {
#               jsonrpc: '2.0', error: {
#                 code: -32700, message: "Parse error"
#               }, id: nil
#             }.to_json
#      else
#        if @request_body.empty?
#          halt 400, {
#               jsonrpc: '2.0', error: {
#                 code: -32600, message: "Invalid Request"
#               }, id: nil
#             }.to_json
#        end
#
#@rpcs = 
#        @request_commands = @request_body['method']['params']
#        ##       cmd_filter = Filter::Commands.new(@request_commands, ->(cmds) { cmds.join(' ') })
#        ##      unless cmd_filter.pass?
#        ##        response.status = 403
#        ##        @errors << cmd_filter.error_message
#        ##      end
#        ##      src_filter = Filter::SourceIP.new(request.ip)
#        ##      unless src_filter.pass?
#        ##        response.status = 403
#        ##        @errors << src_filter.error_message
#      end
#    end
#

    post '/', method: 'exec' do
      send_result "ok"

#      commands = @request_commands
#      Worker.new.async.perform(commands.join(' '))
#      {
#        code: 10,
#        status: response.status, commands: commands,
#        results: nil,
#        errors: @errors,
#      }.to_json
    end
#
#    before '/exec*' do
#      @errors = []
#      begin
#        @request_body = JSON.parse(request.body.read)
#      rescue JSON::ParserError => e
#        response.status = 400
#        @errors << e.message
#      else
#        @request_commands = @request_body['commands']
#        cmd_filter = Filter::Commands.new(@request_commands, ->(cmds) { cmds.join(' ') })
#        unless cmd_filter.pass?
#          response.status = 403
#          @errors << cmd_filter.error_message
#        end
#        src_filter = Filter::SourceIP.new(request.ip)
#        unless src_filter.pass?
#          response.status = 403
#          @errors << src_filter.error_message
#        end
#      end
#    end
#
#    get '/' do
#      "Hello! \n- #{HttpRemocon} #{HttpRemocon::VERSION}"
#    end
#
#    post '/exec' do
#      if response.ok?
#        commands = @request_commands
#        Worker.new.async.perform(commands.join(' '))
#      else
#        commands = nil
#      end
#
#      {
#        status: response.status, commands: commands,
#        results: nil,
#        errors: @errors,
#      }.to_json
#    end
#
#    post '/exec_sync' do
#      if response.ok?
#        commands = @request_commands
#        out, err, exitcode = Worker.new.perform(commands.join(' '))
#      else
#        commands = nil
#        out, err, exitcode = []
#      end
#
#      {
#        status: response.status, commands: commands,
#        results: {
#          stdout: out,
#          stderr: err,
#          exitcode: exitcode && exitcode.to_i,
#        },
#        errors: @errors,
#      }.to_json
#    end


  end
end
