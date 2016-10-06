require 'fast_priority_queue/version'
require 'thermite/fiddle'

class FastPriorityQueue
  def initialize
    @array = [nil]
    if block_given?
      @cmp = ->(a,b) { yield a,b }
    else
      @cmp = ->(a,b) { a <=> b }
    end
  end

  def length
    @array.length - 1
  end

  def compare(a,b)
    _compare(@cmp,a,b)
  end

  def add(x)
    _add(@array,@cmp,x)
  end

  def top
    @array[1]
  end

  def pop
    if length == 0
      nil
    elsif length == 1
      @array.pop
    else
      top_val = top
      @array[1] = @array[-1]
      @array.pop
      _bubble_down(@array,@cmp)
      top_val
    end
  end

  def empty?
    length == 0
  end

end

toplevel_dir = File.dirname(File.dirname(__FILE__))
Thermite::Fiddle.load_module('init_fast_priority_queue',
                             cargo_project_path: toplevel_dir,
                             ruby_project_path: toplevel_dir)