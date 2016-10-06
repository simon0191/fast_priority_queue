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

class Patient < Struct.new(:name,:age,:severity)
  def <=>(other)
    if self.severity != other.severity
      other.severity <=> self.severity
    elsif  self.age != other.age
      other.age <=> self.age
    else
      self.name <=> other.name
    end
  end
end

t = 100_000
r = Random.new 182544861145423751987946792099462507225
patients = t.times.map { |i| Patient.new("patient - #{i}",r.rand(80),r.rand(3)) }
Benchmark.bmbm do |x|
  fpq = FastPriorityQueue.new
  pq = PQueue.new { |a,b| (a <=> b) > 0}


  x.report('Fast#add') { patients.each { |x| fpq.add x } }
  x.report('PQueue#push') { patients.each { |x| pq.push x } }

  x.report("Fast#pop")  { fpq.pop until fpq.empty? }
  x.report("PQueue#pop") { pq.pop until pq.empty? }
end