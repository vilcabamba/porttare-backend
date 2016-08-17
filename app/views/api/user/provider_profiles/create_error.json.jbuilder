if @provider_profile.present?
  json.errors do
    @provider_profile.errors.to_hash.each do |key, value|
      json.set! key, value
    end
  end
end
