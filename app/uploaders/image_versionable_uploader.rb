class ImageVersionableUploader < ApplicationUploader
  unless defined?(Cloudinary)
    include CarrierWave::MiniMagick
  end

  version :small do
    process resize_to_fit: [500, 500]
  end

  version :small_cropped do
    process resize_to_fill: [500, 500]
  end
end
