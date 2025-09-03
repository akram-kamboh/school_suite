class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :full_name
      t.integer :marks
      t.boolean :student_type

      t.timestamps
    end
  end
end
