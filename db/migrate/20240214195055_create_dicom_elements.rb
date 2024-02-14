class CreateDicomElements < ActiveRecord::Migration[6.1]
  def change
    create_table :dicom_elements do |t|
      t.string :tag
      t.string :vr
      t.string :value
      t.integer :length

      t.timestamps
    end
  end
end
