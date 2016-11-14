# encoding: utf-8
class ProviderCategoryImageUploader < ApplicationUploader
  def default_url
    "/images/provider_category/defaults/" + [model.titulo.parameterize, ".jpg"].compact.join('')
  end
end
