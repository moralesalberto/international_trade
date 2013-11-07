require_relative 'currency_converter'
require 'csv'

class Report
  def initialize(params={:transaction_data => 'stream of csv data', :conversion_table => 'steam of xml data'})
    @data = params[:transaction_data]
    @currency_converter = CurrencyConverter.new(params[:conversion_table])
  end

  def transactions
    CSV.parse(@data, :headers => true).map {|row| Transaction.new(row, @currency_converter)} 
  end

  class Transaction
    def initialize(row, currency_converter)
      @row = row
      @currency_converter = currency_converter
    end

    def for_sku?(sku)
      @row['sku'] == sku
    end

    def amount
      @row['amount'].to_f
    end

    def currency
      @row['amount'].to_s.upcase[/[A-Z]+/]
    end

    def amount_in(to_currency)
      @currency_converter.convert({:from => currency, :to => to_currency, :amount => amount}) 
    end

  end

  def total_for(sku, currency='USD')
    transactions.inject(0.00) {|sum, transaction| sum + (transaction.for_sku?(sku) ? transaction.amount_in(currency) : 0.00)}
  end

end
