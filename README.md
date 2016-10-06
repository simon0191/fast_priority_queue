# FastPriorityQueue

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/fast_priority_queue`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
FastPriorityQueue is super fast. Here are some benchmarks against [PQueue](https://github.com/rubyworks/pqueue):

*(the smallest the number, the better)*

Benchmark of add and pop with fixnums:
```
Rehearsal -----------------------------------------------
Fast#add      0.830000   0.010000   0.840000 (  0.854182)
PQueue#push  22.610000  40.740000  63.350000 ( 67.128790)
Fast#pop      1.280000   0.010000   1.290000 (  1.331896)
PQueue#pop    0.010000   0.000000   0.010000 (  0.012800)
------------------------------------- total: 65.490000sec

                  user     system      total        real
Fast#add      0.860000   0.010000   0.870000 (  0.896107)
PQueue#push  22.570000  41.690000  64.260000 ( 68.815510)
Fast#pop      1.250000   0.010000   1.260000 (  1.275417)
PQueue#pop    0.010000   0.000000   0.010000 (  0.011788)
```

Benchmark of add and pop with objects:
```
Rehearsal -----------------------------------------------
Fast#add      0.380000   0.010000   0.390000 (  0.393005)
PQueue#push  36.730000  53.990000  90.720000 ( 96.215730)
Fast#pop      1.850000   0.020000   1.870000 (  1.911544)
PQueue#pop    0.010000   0.000000   0.010000 (  0.012731)
------------------------------------- total: 92.990000sec

                  user     system      total        real
Fast#add      0.410000   0.010000   0.420000 (  0.423021)
PQueue#push  37.190000  55.130000  92.320000 (100.046236)
Fast#pop      1.970000   0.010000   1.980000 (  2.031743)
PQueue#pop    0.020000   0.000000   0.020000 (  0.014687)
```
I had to use `Array#pop` from ruby because there's no `Array.pop` native extension by now.
That's why `#pop` benchmark is a little bit worse than PQueue.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fast_priority_queue.

