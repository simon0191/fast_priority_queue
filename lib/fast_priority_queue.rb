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

  def add(x)
    _add(@array,@cmp,x)
  end

  def top
    @array[1]
  end

  def pop
    _pop(@array,@cmp)
#    if length > 1
#      top_val = @array[1]
#      @array[1] = @array[-1]
#      @array.pop
#      _bubble_down(@array,@cmp)
#      top_val
#    elsif length == 0
#      nil
#    elsif length == 1
#      @array.pop
#    end
  end

  def empty?
    length == 0
  end

  def _pop_last_element
    #TODO: find a way to do this in Rust
    @array.pop
  end
end

toplevel_dir = File.dirname(File.dirname(__FILE__))
Thermite::Fiddle.load_module('init_fast_priority_queue',
                             cargo_project_path: toplevel_dir,
                             ruby_project_path: toplevel_dir)