module PaperTrail
  class VersionDecorator < Draper::Decorator
    delegate_all

    def whodunnit_imagen_url
      if whodunnit.present?
        whodunnit.image_url
      else
        default_email = "hola@moviggo.com"
        h.gravatar_image_url(default_email)
      end
    end

    def link_to_whodunnit
      if whodunnit.present?
        h.link_to whodunnit.to_s,
                  h.admin_user_path(whodunnit)
      else
        h.t("admin.history.not_user")
      end
    end

    def action
      model_key = object.item_type.underscore
      h.t("admin.#{model_key}.history.#{event}")
    end

    def created_at
      h.l(object.created_at, format: :admin_full)
    end

    private

    def whodunnit
      return if object.whodunnit.blank?
      @whodunnit ||= User.find(object.whodunnit).decorate
    end
  end
end
