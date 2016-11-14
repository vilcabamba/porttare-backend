# encoding: utf-8
class ProviderCategoryImageUploader < ApplicationUploader
  def default_url(*args)
    "/images/fallback/" + [model.titulo.parameterize, ".jpg"].compact.join('')
  end
end
