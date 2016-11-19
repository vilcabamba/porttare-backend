class UserDecorator < Draper::Decorator
  delegate_all

  def to_s
    object.name.presence || object.nickname.presence || object.email
  end

  def image_url
    image.presence || gravatar_image
  end

  private

  def gravatar_image
    h.gravatar_image_url(email)
  end
end
