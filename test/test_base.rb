require 'test/unit'
require 'yaml'
begin
  require File.join(File.dirname(__FILE__), '../lib/quicky')
rescue Exception => ex
  puts "Could NOT load gem: " + ex.message
  raise ex
end


class TestBase < Test::Unit::TestCase
 def setup
    puts 'setup'


  end

  def test_fake
  end
end
