class ProviderProfileDecorator < GenericResourceDecorator
  decorates_association :user
  decorates_association :offices
  decorates_association :provider_category

  def logotipo_url
    if object.logotipo?
      object.logotipo_url
    else
      h.gravatar_image_url(provider_profile.email)
    end
  end

  def formas_de_pago
    object.formas_de_pago.join(", ")
  end

  def card_attributes
    [
      :ruc,
      :razon_social,
      :actividad_economica,
      :representante_legal
    ]
  end

  def detail_attributes
    card_attributes + [
      :user,
      :tipo_contribuyente,
      :telefono,
      :email,
      :formas_de_pago,
      :fecha_inicio_actividad,
      :banco_nombre,
      :banco_numero_cuenta,
      :banco_tipo_cuenta,
      :website,
      :facebook_handle,
      :twitter_handle,
      :instagram_handle,
      :youtube_handle
    ]
  end
end
