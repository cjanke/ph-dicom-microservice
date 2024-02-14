class CreateDicomImages < ActiveRecord::Migration[6.1]
  def change
    create_table :dicom_images do |t|
      t.binary :raw
      t.string :filename

      t.timestamps
    end
  end
end
