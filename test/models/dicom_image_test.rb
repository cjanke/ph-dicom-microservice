require "test_helper"

class DicomImageTest < ActiveSupport::TestCase
  test ".new.set_content_from_string returns DicomImage that has a DicomImageToFilename record" do
    dcm_string = File.read("./test/models/TEST-IM000001")
    dcm_image = DicomImage.new(filename: "TEST-IM000001").set_content_from_string(dcm_string)

    dcm_filename_mapping = DicomImageToFilename.find(dcm_image.id)
    assert_equal "TEST-IM000001", dcm_filename_mapping.original_filename
  end

  test ".png generates a png version of the image and writes it to file" do
    dcm_string = File.read("./test/models/TEST-IM000001")
    dcm_image = DicomImage.new(filename: "TEST-IM000001").set_content_from_string(dcm_string)

    png_filename = dcm_image.png
    assert File.file?(png_filename)
  end

  test ".load" do
    "TODO because I haven't reviewed docs on setting up mocking in Ruby / minitest recently"
  end
end