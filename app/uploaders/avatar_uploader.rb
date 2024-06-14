# Clase que representa la imagen de perfil de un usuario.
# Clase que representa la imagen de perfil de un usuario.
class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  # Procesamiento opcional
  process convert: 'jpg'
  process tags: ['post_picture']

  # Procesar archivos grandes para reducir su tamaño
  process :compress_large_files

  version :thumb do
    process resize_to_fit: [200, 200]
  end

  def extension_whitelist
    %w(jpg jpeg gif png webp)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end

  private

  def compress_large_files
    quality = 100
    puts 'HOLA'
    manipulate! do |img|
      puts img
      img.resize "1920x1080>"
      puts 'HOLA2'
      while file.size > 10.megabytes
        puts 'HOLA3'
        img.combine_options do |cmd|
          cmd.quality quality.to_s
          cmd.resize "1920x1080>"
        end
        file.recreate_versions! if file.respond_to?(:recreate_versions!)
        break if quality <= 10
        quality -= 5
      end
      img
    end
  end
end
