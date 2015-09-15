require 'sucker_punch'
require 'pp'
require 'open3'

module HttpRemocon
  class Worker
    include SuckerPunch::Job
    workers 3

    def perform(input, lock = nil)
      out, err, status = Open3.capture3(input)

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
