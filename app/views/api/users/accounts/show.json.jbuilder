json.user do
  json.extract!(
    @user,
    :id,
    :name,
    :email,
    :ciudad,
    :fecha_nacimiento
  )
  json.fecha_nacimiento(
    l(@user.fecha_nacimiento, format: :api)
  ) if @user.fecha_nacimiento.present?
end
