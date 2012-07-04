# Put config.yml file in ~/Dropbox/configs/ironmq_gem/test/config.yml

gem 'test-unit'
require 'test/unit'
require 'yaml'
require_relative 'test_base'

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
    quicky.loop(:test2, 10) do |i|
      puts 'sleeping'
      sleep 1
    end
    p quicky.results(:test2).inspect
    p quicky.results(:test2).duration
    assert quicky.results(:test2).duration >= 1 && quicky.results(:test2).duration < 2
    assert quicky.results(:test2).total_duration >= 10

  end

end

