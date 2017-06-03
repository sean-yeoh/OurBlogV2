class ImageUploader < Shrine
  # plugins and uploading logic
  plugin :store_dimensions
  plugin :processing

  process(:store) do |io, context|
    original = io.download { |cmd| cmd.auto_orient }
    original
  end
end
