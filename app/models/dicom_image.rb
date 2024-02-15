require "dicom"

class DicomImage
  attr_accessor :dcm, :filename, :id

  IMAGE_DIRECTORY = "storage"

  def initialize(content:, filename:)
    @dcm =  DICOM::DObject.parse(content)
    @filename = filename
    filename_mapping = DicomImageToFilename.create(original_filename: filename)
    @id = filename_mapping.id
  end

  def save_locally
    dcm.write(local_filename)
  end

  private

  def local_filename
    IMAGE_DIRECTORY + "/#{id}-#{filename}.dcm"
  end
end