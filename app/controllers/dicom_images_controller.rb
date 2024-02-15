class DicomImagesController < ApplicationController
  def create
    dicom_image = DicomImage.new(
      content: dicom_image_params[:raw].read,
      filename: dicom_image_params[:filename],
    )
    dicom_image.save_locally
  end

  def show
  end

  def elements
  end

  private

  def dicom_image_params
    params.permit(:raw, :filename)
  end
end
