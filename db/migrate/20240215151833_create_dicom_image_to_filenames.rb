class CreateDicomImageToFilenames < ActiveRecord::Migration[6.1]
  def change
    create_table :dicom_image_to_filenames do |t|
      t.string :original_filename

      t.timestamps
    end
  end
end
