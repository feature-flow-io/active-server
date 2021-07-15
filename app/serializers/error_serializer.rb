module ErrorSerializer
  class << self
    def serialize(errors)
      return if errors.nil?

      json = {}

      error_hash = if errors.is_a?(ActiveModel::Errors)
                     errors.to_hash(true).map { |k, v| render_errors(errors: v, type: k) }
                   else
                     errors.to_hash.map { |k, v| render_errors(errors: v, type: k, klass: false) }
                   end.flatten

      json[:errors] = error_hash
      json
    end

    def render_errors(errors:, type:, klass: true)
      errors.map do |msg|
        normalized_type = type.to_s.humanize
        msg = "#{normalized_type} #{msg}" unless klass

        { source: { pointer: "/data/attributes/#{type}" }, type: type, detail: msg }
      end
    end
  end
end
