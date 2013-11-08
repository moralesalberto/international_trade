require 'debugger'

class RateCalculator

  attr_reader :rate_map

  def initialize(rates)
    @rates = rates
    @rate_map = {}
    init_rate_map
  end

  def init_rate_map
    @rates.each do |row|
      set_rate_map_for(row) 
    end
  end

  def set_rate_map_for(params={'from' => 'GBP', 'to' => 'USD', 'conversion' => 0.99})
    @rate_map[params['from']] ||= {}
    @rate_map[params['from']].merge!({params['to'] => params['conversion'].to_f})
    @rate_map[params['to']] ||= {}
    @rate_map[params['to']].merge!({params['from'] => 1.0/params['conversion'].to_f})
  end

  def get_known_rate(params = {'from' => 'GBP', 'to' => 'USD'})
    @rate_map[params['from']][params['to']]
  end

  # this is the base condition
  def rate_map_exists?(params={'from' => 'USD', 'to' => 'GBP'})
    @rate_map[params['from']] and @rate_map[params['from']][params['to']]
  end

  def rate(params={'from' => 'USD', 'to' => 'CAD'})
    if rate_map_exists?(params)
      return get_known_rate(params)
    else
      @rate_map.each do |from, to_hash|
        node_to_end_rate = rate({'from' => from, 'to' => params['to']})
        start_to_node_rate = rate({'from' => params['from'], 'to' => from})
        if node_to_end_rate != 0 and start_to_node_rate != 0
          new_rate = node_to_end_rate * start_to_node_rate
          set_rate_map_for({'from' => params['from'], 'to' => params['to'], 'conversion' => new_rate})
          return new_rate
        end
      end
      return 0
    end
  end



end
