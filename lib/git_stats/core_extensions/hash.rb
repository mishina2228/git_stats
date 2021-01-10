class Hash
  def to_key_indexed_array(params = {})
    raise ArgumentError, 'all the keys must be numbers to convert to key indexed array' unless all? { |k, v| k.is_a? Numeric }

    min_size = params[:min_size] || 0
    default = params[:default]
    each_with_object(Array.new(min_size, default)) { |(k, v), acc| acc[k] = v; }.map { |e| e || default }
  end

  def fill_empty_days!(params = {aggregated: true})
    return self if empty?

    self_with_date_keys = Hash[map { |k, v| [k.to_date, v] }]
    days_with_data = self_with_date_keys.keys.sort.uniq
    prev = 0

    days_with_data.first.upto(days_with_data.last) do |day|
      if days_with_data.include? day
        prev = self_with_date_keys[day]
      else
        self[day] = params[:aggregated] ? prev : 0
      end
    end
    self
  end
end
