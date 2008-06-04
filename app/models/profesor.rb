class Profesor < Persona
  validates_presence_of :salario
  has_many :grupos, :dependent => :nullify
  
  def self.search(profesor)
    s=limpiar_string_buscadora(profesor)
    @profesor = Profesor.find(:all,
                             :conditions => ["LOWER(nombres || apellidos) LIKE ?",
                                             "%#{s}%"] )
  end

  def self.limpiar_string_buscadora(s)
    s ||= ""
    s.gsub(/[ ]+/, "%").downcase.gsub(/[áéíóúÁÉÍÓÚ]+/, "%")
   
  end
end
