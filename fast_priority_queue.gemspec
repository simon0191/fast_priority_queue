# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fast_priority_queue/version'

Gem::Specification.new do |spec|
  spec.name          = "fast_priority_queue"
  spec.version       = FastPriorityQueue::VERSION
  spec.authors       = ["Simon Soriano"]
  spec.email         = ["simon0191@gmail.com"]

  spec.summary       = "Priority queue implementation using Rust"
  spec.description   = "A blazzingly fast implementation of priority queue using Rust + Ruru"
  spec.homepage      = "https://github.com/simon0191/fast_priority_queue"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #  if spec.respond_to?(:metadata)
  #    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #  else
  #    raise "RubyGems 2.0 or newer is required to protect against " \
  #      "public gem pushes."
  #  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "algorithms", "~>  0.6"

  spec.extensions << 'ext/Rakefile'
  spec.add_runtime_dependency 'thermite', '~> 0'
end
