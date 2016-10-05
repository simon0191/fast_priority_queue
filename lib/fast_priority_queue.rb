require 'fast_priority_queue/version'
require 'thermite/fiddle'

class FastPriorityQueue
end

toplevel_dir = File.dirname(File.dirname(__FILE__))
Thermite::Fiddle.load_module('init_fast_priority_queue',
                             cargo_project_path: toplevel_dir,
                             ruby_project_path: toplevel_dir)