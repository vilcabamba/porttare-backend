require "digest/md5"

module GravatarHelper
  def gravatar_image_url(email)
    hash = Digest::MD5.hexdigest(email)
    size = 250
    default = "identicon"
    "//www.gravatar.com/avatar/#{hash}?s=#{size}&d=#{default}"
  end
end
