$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'benchmark'
require 'fast_priority_queue'
require 'pqueue'

t = 100_000
nums = (0..t).to_a
Benchmark.bmbm do |x|
  fpq = FastPriorityQueue.new { |a,b| b <=> a  }
  pq = PQueue.new { |a,b| a > b }

  x.report('Fast#add') { nums.each { |x| fpq.add x } }
  x.report('PQueue#push') { nums.each { |x| pq.push x } }

  x.report("Fast#pop")  { fpq.pop until fpq.empty? }
  x.report("PQueue#pop") { pq.pop until pq.empty? }
end