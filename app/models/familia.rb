class Familia < ActiveRecord::Base
  validates_presence_of :nombre

  has_many :alumnos, :dependent => :nullify
  has_many :personas, :dependent => :nullify

  def personas_no_alumno
    personas.find :all, :conditions => { :type => nil }
  end
end
