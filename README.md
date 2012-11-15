Quicky if for easily timing chunks of code.

## Getting Started

    gem install quicky

## Timing

### Time anything

```ruby
quicky = Quicky::Timer.new
quicky.time(:test1) do
  sleep 2
end
```

Call time over and over again and when ready for results:

```ruby
# Print average duration for all :test1 timings
p quicky.results(:test1).duration
# Print total duration for all :test1 timings
p quicky.results(:test1).total_duration
# Print longest duration for all :test1 timings
p quicky.results(:test1).max_duration
# Print shortest duration for all :test1 timings
p quicky.results(:test1).min_duration
```

### Time in a loop

Good for performance testing.

```ruby
quicky = Quicky::Timer.new
# This will loop 10 times
quicky.loop(:test2, 10) do |i|
  puts 'sleeping'
  sleep 1
end
```

Or loop for X seconds:

```ruby
# This will loop for 10 seconds
quicky.loop_for(:test3, 10) do |i|
  puts 'sleeping'
  sleep 0.5
end
```

#### Looping Options

- warmup: X -- will throw out the first X results.

## Results

You can get all the results with:

```ruby
results =  quicky.results
```

Or a single result:

```ruby
result = quicky.results(:test1)
```

Or turn it into a straight up hash:

```ruby
hash = quicky.results.to_hash
```

And even marshal a hash back into a quicky objects:

```ruby
results = Quicky::ResultsHash.from_hash(hash)
```

Or merge several results hashes together (if you were doing some tests in parallel):

```ruby
results.merge!(other_results)
```
