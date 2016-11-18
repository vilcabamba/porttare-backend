class UserDecorator < Draper::Decorator
  delegate_all

  def to_s
    object.name
  end
end
