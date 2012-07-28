module Quicky

  class Timer

    def initialize
      @collector = {}
    end

    def loop(name, x, options={}, &blk)
      if options[:warmup]
        options[:warmup].times do |i|
          #puts "Warming up... #{i}"
          yield
        end
      end
      x.times do |i|
        time(name, options, &blk)
      end
    end

    # will loop for number of seconds
    def loop_for(name, seconds, options={}, &blk)
      end_at = Time.now + seconds
      if options[:warmup]
        options[:warmup].times do |i|
          #puts "Warming up... #{i}"
          yield
        end
      end
      while Time.now < end_at
        time(name, options, &blk)
      end
    end

    def time(name, options={}, &blk)
      t = Time.now
      yield
      duration = Time.now.to_f - t.to_f
      #puts 'duration=' + duration.to_s
      r = TimeResult.new(duration)
      @collector[name] ||= TimeCollector.new(name)
      @collector[name] << r
      r
    end

    def results(name=nil)
      if name
        return @collector[name]
      end
      @collector
    end
  end

  class TimeCollector
    attr_accessor :name
    def initialize(name)
      @name = name
      @collector = []
      @total_duration = 0.0
    end

    def <<(val)
      # pull out duration for totals
      @total_duration += val.duration
      @collector << val
    end

    def duration
      @total_duration / @collector.size
    end

    def total_duration
      @total_duration
    end

    def count
      @collector.size
    end

  end

  class TimeResult

    attr_accessor :duration

    def initialize(duration)
      @duration = duration
    end
  end
end
