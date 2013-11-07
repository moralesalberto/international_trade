class BankerRound
  def self.round(number)
    self.new(number).round
  end

  def initialize(number)
    @number = number
    @significance = 100 # 2 decimals, precision hardcoded for now
  end

  def round
    if(last_digit_is_5 and second_to_last_digit_is_odd) or (last_digit_is_greater_than_5)
      rounded_up_number
    else
      unrounded_number
    end
  end

  def rounded_up_number
    "#{whole_number_portion}.#{third_to_last_digit}#{second_to_last_digit.to_i+1}".to_f
  end

  def unrounded_number
    "#{whole_number_portion}.#{third_to_last_digit}#{second_to_last_digit}".to_f
  end

  def whole_number_portion
    significant_digits.to_i/(@significance*10)
  end

  def last_digit_is_5
    last_digit == '5'
  end

  def last_digit_is_greater_than_5
    last_digit.to_i > 5
  end

  def last_digit
    significant_digits.to_s[significant_digits.to_s.length-1]
  end

  def second_to_last_digit_is_odd
    !second_to_last_digit_is_even
  end

  def second_to_last_digit_is_even
    (second_to_last_digit.to_i % 2) == 0
  end

  def second_to_last_digit
    n_to_last_digit(2)
  end

  def third_to_last_digit
    n_to_last_digit(3)
  end

  def n_to_last_digit(n)
    significant_digits.to_s[significant_digits.to_s.length-n]
  end

  def significant_digits
    @significant_digits ||= (@number * @significance * 10).round # or truncate? need to check
  end

end
