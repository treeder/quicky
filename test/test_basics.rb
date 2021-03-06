# Put config.yml file in ~/Dropbox/configs/ironmq_gem/test/config.yml

require 'test/unit'
require 'yaml'
require 'test_base'

class TestBasics < TestBase
  def setup
    super
  end

  def test_basics
    quicky = Quicky::Timer.new
    quicky.time(:test1) do
      sleep 2
    end
    p quicky.results(:test1).duration
    assert quicky.results(:test1).duration > 2

    quicky = Quicky::Timer.new
    quicky.loop(:test2, 10) do
      puts 'sleeping'
      sleep 1
    end
    p quicky.results(:test2).inspect
    p quicky.results(:test2).duration
    assert quicky.results(:test2).duration >= 1 && quicky.results(:test2).duration < 2
    assert quicky.results(:test2).total_duration >= 10

    quicky = Quicky::Timer.new
    quicky.loop_for(:test3, 10) do
      puts 'sleeping'
      sleep 0.5
    end
    result = quicky.results(:test3)
    p result.inspect
    p result.duration
    p quicky.results.count
    assert result.duration >= 0.5 && result.duration < 1
    assert result.total_duration >= 5
    assert result.min_duration < 0.55 && result.min_duration > 0.1
    assert result.max_duration > 0.5 && result.max_duration < 0.7

    r1 = quicky.results
    p r1
    hash = r1.to_hash
    p hash
    assert hash[:test3][:duration] >= 0.5

    r2 = Quicky::ResultsHash.from_hash(hash)
    p r2
    assert_equal r1.size, r2.size
    r1.each_pair do |k, v|
      # v should be a TimeCollector
      assert_equal v.count, r2[k].count
    end

  end

end

