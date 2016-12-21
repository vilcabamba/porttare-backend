class ProviderItemImageDecorator < GenericResourceDecorator
  def link_to_resource(options={}, &block)
    h.link_to(
      imagen_url,
      options.merge(target: "_blank"),
      &block
    )
  end

  def to_s
    imagen.file.filename
  end
end
