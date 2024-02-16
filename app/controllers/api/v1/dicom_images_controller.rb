module Api::V1
  class DicomImagesController < ApplicationController
    def create
      dicom_image = DicomImage.new(
        filename: dicom_image_params[:filename],
      ).set_content_from_string(dicom_image_params[:raw].read)
      dicom_image.save_locally
      render json: dicom_image, status: :created
    end

    def png
      id = params[:id]
      dcm_image = DicomImage.load(id)
      send_file dcm_image.png
    end

    def elements
      id = params[:id]
      tag = params[:tag]

      dcm_image = DicomImage.load(id)
      render json: dcm_image.element_for_tag(tag), status: :ok
    end

    private

    def dicom_image_params
      params.permit(:raw, :filename)
    end
  end
end