if @api_resource.errors.present?
  json.errors do
    @api_resource.errors.to_hash.each do |key, value|
      json.set! key, value
    end
  end
end
