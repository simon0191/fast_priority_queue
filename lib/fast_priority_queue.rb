require 'fast_priority_queue/version'
require 'thermite/fiddle'

class FastPriorityQueue
  def initialize
    @array = []
    if block_given?
      @cmp = ->(a,b) { yield a,b }
    else
      @cmp = ->(a,b) { a <=> b }
    end
  end

  def compare(a,b)
    _compare(@cmp,a,b)
  end
end

toplevel_dir = File.dirname(File.dirname(__FILE__))
Thermite::Fiddle.load_module('init_fast_priority_queue',
                             cargo_project_path: toplevel_dir,
                             ruby_project_path: toplevel_dir)