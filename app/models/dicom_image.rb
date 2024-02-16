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

    # Maybe future: add png filename to DicomImageToFilename records
    # @generated_png_filename = nil
  end

  def set_content_from_file
    @dcm = DICOM::DObject.read(local_filename)
    self
  end

  def set_content_from_string(content)
    @dcm = DICOM::DObject.parse(content)
    self
  end

  def save_locally
    dcm.write(local_filename)
  end

  def self.load(id)
    filename_mapping = DicomImageToFilename.find(id)
    dcmi = self.new(
      filename: filename_mapping.original_filename,
      id: id
    )

    dcmi.set_content_from_file
  end

  def png
    png_filename = local_filename + ".png"

    if @generated_png_filename.nil?
      generate_png(png_filename)
      @generated_png_filename = png_filename
    end

    png_filename
  end

  def generate_png(png_filename)
    Rails.logger.info("DICOM: Saving PNG version of DICOM file to: #{png_filename}")
    dcm.image.normalize.write(png_filename)
  end

  def element_for_tag(tag)
    dcm[tag].to_json
  end

  def local_filename
    IMAGE_DIRECTORY + "/#{id}-#{filename}"
  end
end