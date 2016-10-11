# FastPriorityQueue

[![Build Status](https://travis-ci.org/simon0191/fast_priority_queue.svg?branch=master)](https://travis-ci.org/simon0191/fast_priority_queue)
[![Gem Version](https://badge.fury.io/rb/fast_priority_queue.svg)](https://badge.fury.io/rb/fast_priority_queue)

A blazzingly fast implementation of priority queue using [Rust](https://www.rust-lang.org/en-US/) + [Ruru](https://github.com/d-unseductable/ruru)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fast_priority_queue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fast_priority_queue

## Usage

```
fpq = FastPriorityQueue.new
# or use a custom comparator function
fpq = FastPriorityQueue.new { |a,b| a<=>b }
# add elements to the queue
fpq.add 5
fpq.add 4
fpq.add 3
fpq.add 2
fpq.add 1
# see what's in the top of the queue
fpq.top # => 1
# take the top element
fpq.pop # => 1
fpq.pop # => 2
# see how many elements are in the queue
fpq.length # => 3
```

## Benchmarks
Fast Priority Queue is 130 times faster than a pure ruby implementation. Here are some benchmarks against [Algorithms](https://github.com/kanwei/algorithms/):

Benchmark of add and pop with 50'000 numbers:

*(the smallest the number, the better)*

```
                     user     system      total        real

Fast#add         0.440000   0.010000   0.450000 (  0.506917)
Fast#pop         0.590000   0.000000   0.590000 (  0.591405)
---------------------------------------   total (  1.098322)

Algorithms#add 135.220000   8.640000 143.860000 (147.354989)
Algorithms#pop   0.290000   0.010000   0.300000 (  0.296598)
---------------------------------------   total (147.651587)
```

*(the biggest the number, the better)*
```
                  ops/sec
Fast#add         98635.48
Fast#pop         84544.43
-------------------------
Algorithms#add     339.31
Algorithms#pop  168578.34

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simon0191/fast_priority_queue.

