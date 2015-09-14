require 'sucker_punch'
require 'pp'
require 'open3'

module HttpRemocon
  class Worker
    include SuckerPunch::Job
    workers 5

    def perform(input, lock = nil)
      out_err, status = Open3.capture2e(input)
#      pp  lock
#      proc = -> {
#        puts "working with lock data: #{input}"
#        sleep 10
#        puts "finished unlock ! data: #{input}"
#      }
#      unless lock.nil?
#        lock.synchronize do
#          proc.call
#        end
#      else
#        proc.call
#      end
    end
  end
end
