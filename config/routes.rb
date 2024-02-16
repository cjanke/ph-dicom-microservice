Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/dicom_images', to: 'dicom_images#create'

      get '/dicom_images/:id/png', to: 'dicom_images#png'

      get '/dicom_images/:id/dicom_elements/', to: 'dicom_images#elements'
    end
  end
end
