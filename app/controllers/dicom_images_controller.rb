class DicomImagesController < ApplicationController
  def create
    @dicom_image = DicomImage.new(dicom_image_params)

    if @dicom_image.save
      render json: @dicom_image, status: :created
    else
      render json: {error: 'Dicom image upload failed'}, status: :unprocessable_entity
    end
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
