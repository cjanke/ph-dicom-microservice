require "test_helper"
# require "dicom"

class DicomImageTest < ActiveSupport::TestCase
  # include DICOM

  test ".new returns DicomImage that has a DicomImageToFilename record" do
    dcm_string = File.read("./test/models/TEST-IM000001")
    dcm_image = DicomImage.new(content: dcm_string, filename: "TEST-IM000001")

    dcm_filename_mapping = DicomImageToFilename.find(dcm_image.id)
    assert_equal "TEST-IM000001", dcm_filename_mapping.original_filename
  end
end