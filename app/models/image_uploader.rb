class ImageUploader < Shrine
  # plugins and uploading logic
  plugin :store_dimensions
end
