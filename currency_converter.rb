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
    rate = rates.find {|r| r['from'] == params[:from] and r['to'] == params[:to]}
    rate ? rate['conversion'] : nil
  end

  def convert(params={:from => 'CAD', :to => 'USD', :amount => 100.02})
    rate(params) ? BankerRound.round(rate(params).to_f * params[:amount].to_f) : nil 
  end


end
