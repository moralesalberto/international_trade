require 'active_support/all'
require_relative 'banker_round.rb'

class CurrencyConverter

  def initialize(xml)
    @xml = xml
  end

  def hash
    @hash ||= Hash.from_xml(@xml)
  end

  def rates
    hash['rates']['rate']
  end

  def rate(params= {:from => 'CAD', :to => 'USD'})
    find_or_derive_rate(params)
  end

  def find_or_derive_rate(params)
    find_rate(params) || derive_rate(params)
  end

  def find_rate(params)
    rate = rates.find {|r| r['from'] == params[:from] and r['to'] == params[:to]}
    rate['conversion'] if rate
  end

  def derive_rate(params)
    same_currency(params) ? 1.0 : calculate_rate(params)
  end
  
  def calculate_rate(params)
    raise "Work in progress will call RateCalculator.rate() eventually"
  end

  def convert(params={:from => 'CAD', :to => 'USD', :amount => 100.02})
    rate(params) ? BankerRound.round(converted_amount(params)) : nil 
  end

  def converted_amount(params={:from => 'CAD', :to => 'USD', :amount => 100.02})
    rate(params).to_f * params[:amount].to_f
  end

  def same_currency(params)
    params[:from] == params[:to]
  end

end
