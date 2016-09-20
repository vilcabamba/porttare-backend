class ProviderProfilePolicy < ApplicationPolicy
  def create?
    # if the user doesn't have a provider profile already
    user.provider_profile.nil?
  end

  def permitted_attributes
    [
      :ruc,
      :razon_social,
      :actividad_economica,
      :tipo_contribuyente,
      :representante_legal,
      :telefono,
      :email,
      :fecha_inicio_actividad,
      :banco_nombre,
      :banco_numero_cuenta,
      :banco_identificacion,
      :website,
      :facebook_handle,
      :twitter_handle,
      :instagram_handle,
      :youtube_handle,
      :mejor_articulo,
      :nombre_establecimiento,
      formas_de_pago: []
    ]
  end
end
