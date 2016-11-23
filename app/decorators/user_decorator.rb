class UserDecorator < GenericResourceDecorator
  delegate_all

  def to_s
    object.name.presence || object.nickname.presence || object.email
  end

  def image_url
    image.presence || gravatar_image || gravatar_mystery_man
  end

  def card_attributes
    [
      :provider,
      :email
    ]
  end

  def detail_attributes
    card_attributes + [
      :nickname,
      :ciudad,
      :fecha_nacimiento
    ]
  end

  def highest_privilege
    privileges.sort_by do |privilege|
      User::PRIVILEGES.index(privilege)
    end.last
  end

  private

  def gravatar_image
    h.gravatar_image_url(email) if email.present?
  end

  def gravatar_mystery_man
    h.gravatar_image_url(nil, "mm")
  end
end
