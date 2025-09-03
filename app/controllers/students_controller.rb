class StudentsController < ApplicationController
  before_action :set_student, only: %i[ edit update ]

  # GET /students or /students.json
  def index
    @student = Student.new
    @students = Student.all
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.turbo_stream do
          @students = Student.all
          render "students/update"
        end
        
        format.html { redirect_to students_path, notice: "Student created successfully."}
      else
        format.turbo_stream do
          if @student.errors.any?
            render turbo_stream: turbo_stream.append(
              "flash", # container in layout
              partial: "shared/errors_popup",
              locals: { errors: @student.errors.full_messages }
            )
          end
        end
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.turbo_stream do
          @students = Student.all
        end
        format.html { redirect_to students_path, notice: "Student updated!" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "flash", # container in layout
            partial: "shared/errors_popup",
            locals: { errors: @student.errors.full_messages }
          )
        end

        format.html { render :edit }
      end
    end
  end

  # DELETE selected students
  def delete_selected
    if params[:student_ids].present?
      Student.where(id: params[:student_ids]).destroy_all

      respond_to do |format|
        format.html { redirect_to students_path, notice: "Selected students deleted successfully." }
        format.turbo_stream do
          @students = Student.all
          render turbo_stream: turbo_stream.update(
            "students_table",
            partial: "students/students",
            locals: { students: @students }
          )
        end
      end
    else
      redirect_to students_path, alert: "No students selected."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.expect(student: [ :full_name, :marks, :student_type ])
    end
end