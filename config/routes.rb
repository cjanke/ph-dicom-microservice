Rails.application.routes.draw do
  post '/dicom_images', to: 'dicom_images#create'
  get '/dicom_images/:id', to: 'dicom_images#show'

  get '/dicom_images/:id/dicom_elements/', to: 'dicom_images#elements'
end
