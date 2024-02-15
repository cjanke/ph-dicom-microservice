class DicomImagesController < ApplicationController
  def create
    dicom_image = DicomImage.new(
      filename: dicom_image_params[:filename],
    ).set_content_from_string(dicom_image_params[:raw].read)
    dicom_image.save_locally
    render json: dicom_image, status: :created
  end

  def show
  end

  def png
    id = params[:id]
    dicom_image = DicomImage.load(id)
  end

  def elements
  end

  private

  def dicom_image_params
    params.permit(:raw, :filename)
  end
end
