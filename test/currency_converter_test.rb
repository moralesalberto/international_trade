require 'test/unit'
require_relative '../currency_converter.rb'

class CurrencyConverterTest < Test::Unit::TestCase

  setup do
    @conversion_table = File.read "test/conversion_table.xml"
    @currency_converter = CurrencyConverter.new(@conversion_table)
  end

  test "A currency converter should take a conversion table" do
    assert(CurrencyConverter.new(@conversion_table))
  end

  test "the converter should have a table of conversions with rates" do
    assert_equal(5, @currency_converter.rates.size)
  end

  test "given a from currency and a to currency it should give us the rate" do
    assert_equal('0.9911', @currency_converter.rate(:from => 'USD', :to => 'CAD'))
  end

  test "given a from currency, a to currency and an amount, it should return the converted amount" do
    assert_equal(34.69, @currency_converter.convert(:from => 'USD', :to => 'CAD', :amount => 35.00))
  end
end