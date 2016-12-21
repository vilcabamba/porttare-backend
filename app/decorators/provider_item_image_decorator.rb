class ProviderItemImageDecorator < GenericResourceDecorator
  def link_to_resource(&block)
    h.link_to(
      imagen_url,
      target: "_blank",
      &block
    )
  end

  def to_s
    imagen.file.filename
  end
end
