module RequestsHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def attribute_keys
    json.dig(:data, :attributes).keys
  end

  def relationship_keys
    json.dig(:data, :relationships).keys
  end

  def response_errors(errors = json[:errors])
    errors.map { |error| error[:type].to_sym }.uniq
  end
end
