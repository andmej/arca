# Maneja las fechas y motivos de la ausencia de alumnos
class FaltaDeAsistencia < ActiveRecord::Base
  validates_presence_of :fecha, :motivo, :persona_id
  validates_uniqueness_of :persona_id, :fecha, :scope => [:persona_id, :fecha]
  belongs_to :persona #En verdad pertenece a un alumno, pero un alumno no tiene su propio alumno_id sino persona_id


  # Busca las faltas de asistencias de un alumno en particular, se puede filtrar por periodos cerrados de fechas, fechas en aaaa-mm-dd
  def self.search(alumno,antes,despues)
    a = string_a_fecha(antes) if antes
    d = string_a_fecha(despues) if despues
    if a and d
      alumno.falta_de_asistencias.find :all, :order => "fecha ASC", :conditions => { :fecha => a..d }
    else
      nil
    end
  end
  
  # Busca las faltas de asistencias de todos los alumno en particular, se puede filtrar por periodos cerrados de fechas, fechas en aaaa-mm-dd
  def self.searchAll(antes,despues)
    a = string_a_fecha(antes) if antes
    d = string_a_fecha(despues) if despues
    if a and d
      find :all, :order => "fecha ASC", :conditions => { :fecha => a..d }
    else
      nil
    end
  end


  protected
  #Si s es una fecha la retorna un objeto Date, sino retorna nil
  def self.string_a_fecha(s) 
    begin s.to_date rescue nil end
  end

end
