module ErrorSerializer
  def self.serialize(errors)
    return if errors.nil?

    json = {}

    error_hash = errors.to_hash.map do |k, v|
      v.map do |msg|
        { source: { pointer: "/data/attributes/#{k}" }, type: k, detail: msg }
      end
    end.flatten

    json[:errors] = error_hash
    json
  end
end
