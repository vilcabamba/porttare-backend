class GenericResourceDecorator < Draper::Decorator
  delegate_all

  def label_for(attribute)
    klass_name = object.class.to_s.underscore
    h.t(
      "activerecord.models.attributes.#{klass_name}.#{attribute}"
    ) + ":"
  end
end
