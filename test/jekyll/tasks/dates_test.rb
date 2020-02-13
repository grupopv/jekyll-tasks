# frozen_string_literal: true

require 'minitest'

module Jekyll
  module Tasks
    class TasksTest < Minitest::Test
      def test_the_number_of_days_passed_in_a_year
        date = Date.new(2020, 2, 13)
        assert_equal 44, Dates.days_in_year(date)
      end

      def test_the_number_of_days_passed_in_the_current_year
        res = Dates.days_in_year
        assert res.positive? && res <= 366
      end

      def test_the_number_of_sundays_passed_in_a_year
        date = Date.new(2020, 2, 13)
        assert_equal 6, Dates.sundays_in_year(date)
      end

      def test_the_number_of_sundays_passed_in_the_current_year
        res = Dates.sundays_in_year
        assert res.positive? && res <= 53
      end

      def test_the_number_of_working_days_passed_in_a_year
        days = Dates.days_in_year
        sundays = Dates.sundays_in_year
        assert_equal days - sundays, Dates.working_days_in_year
      end

      def test_the_number_of_working_days_passed_in_the_current_year
        res = Dates.working_days_in_year
        assert res.positive? && res <= (366 - 53)
      end
    end
  end
end
