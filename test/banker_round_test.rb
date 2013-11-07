require 'test/unit'

require_relative '../banker_round.rb'

class BakerRoundText < Test::Unit::TestCase
  setup do
    @banker_round = BankerRound.new(2.52523)
  end
  test "a banker_round should take a number" do
    assert(@banker_round)
  end

  test "a banker_round should first get an integer with three decimals as integers" do
    assert_equal(2525, @banker_round.significant_digits)
  end
  test "then it should test if the last digit is 5" do
    assert(@banker_round.last_digit_is_5, "expected the last digit to be 5")
  end

  test "then it should test if the second to last digit is even" do
    assert(@banker_round.second_to_last_digit_is_even, "expected this to be even")
  end

  test "if the last number is 5 and the second to last number is even then it should return the number unrounded" do
    assert_equal(2.52, @banker_round.round)
  end

  test "if the last number is less than 5 then it should return the number unrounded" do
    br = BankerRound.new(2.2222)
    assert_equal(2.22, br.round)
  end

  test "if the last digit is greater than 5 it should return the number rounded up one" do
    br = BankerRound.new(2.336324)
    assert_equal(2.34, br.round)
  end

  test "if the last number is 5 and the second to last number is odd then it should return the number unrounded" do
    br = BankerRound.new(2.335324)
    assert_equal(2.34, br.round)
  end
end
