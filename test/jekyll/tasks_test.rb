require "test_helper"

class Jekyll::TasksTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jekyll::Tasks::VERSION
  end
end
