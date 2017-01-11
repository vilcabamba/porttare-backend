class CustomerAddressDecorator < GenericResourceDecorator
  def static_map_image
    GoogleStaticMap.new(
      zoom: 16,
      scale: 2,
      size: "600x300",
      markers: "#{lat},#{lon}"
    ).to_s
  end
end
