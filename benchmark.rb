$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'benchmark'
require 'fast_priority_queue'
require 'algorithms'

t = 50_000
nums = (0..t).to_a
Benchmark.bmbm do |x|
  fpq = FastPriorityQueue.new { |a,b| b <=> a  }
  apq = Containers::PriorityQueue.new


  x.report('Fast#add') { nums.each { |x| fpq.add x } }
  x.report('Algorithms#add') { nums.each { |x| apq.push x,x } }

  x.report("Fast#pop")  { fpq.pop until fpq.empty? }
  x.report("Algorithms#pop")  { apq.pop until apq.empty? }
end
