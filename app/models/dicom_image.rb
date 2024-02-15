require "dicom"

class DicomImage
  attr_accessor :dcm, :filename, :id

  IMAGE_DIRECTORY = "storage"

  def initialize(filename:, id: nil)
    @filename = filename

    unless id
      # If no id provided, we have to make a new record
      filename_mapping = DicomImageToFilename.create(original_filename: filename)
      @id = filename_mapping.id
    else
      @id = id
    end
  end

  def set_content_from_file
    @dcm = DICOM::DObject.read(local_filename)
    self
  end

  def set_content_from_string(content)
    @dcm = DICOM::DObject.parse(content)
    self
  end

  def self.load(id)
    filename_mapping = DicomImageToFilename.find(id)
    dcmi = self.new(
      filename: filename_mapping.original_filename,
      id: id
    )

    dcmi.set_content_from_file
  end

  def save_locally
    dcm.write(local_filename)
  end

  def local_filename
    IMAGE_DIRECTORY + "/#{id}-#{filename}"
  end

  def png
    png_filename = local_filename + ".png"
    # TODO: some issue with the Ruby Dicom library and rmagick
    # dcm.image.normalize.write(png_filename)
    png_filename
  end
end