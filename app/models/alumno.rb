class Alumno < Persona
  validates_presence_of :fecha_nacimiento, :fecha_ingreso, :cuidados_especiales
  belongs_to :familia, :exalumno

  def self.alumnos_sin_familia
    Alumno.find_all_by_familia_id(nil, :order => "apellidos ASC")
  end
end
