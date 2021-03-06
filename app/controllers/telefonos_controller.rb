class TelefonosController < ApplicationController
  before_filter :load_persona

  # Carga los datos de la persona
  def load_persona
    if params[:persona_id].nil?
      redirect_to personas_path
    else
      @persona = Persona.find(params[:persona_id])
    end
  end

  # Muestra los telefonos de la persona
  def index
    @telefonos = @persona.telefonos.find(:all, :order => "tipo ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @telefonos }
    end
  end

  # Muestra el telefono especifico de la persona
  def show
    @telefono = @persona.telefonos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @telefono }
    end
  end

  # Determina un nuevo telefono para la persona
  def new
    @telefono = @persona.telefonos.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @telefono }
    end
  end

  # Edita el telefono seleccionado de la persona
  def edit
    @telefono = @persona.telefonos.find(params[:id])
  end

  # Crea un nuevo telefono para la persona
  def create
    @telefono = @persona.telefonos.build(params[:telefono])

    respond_to do |format|
      if @telefono.save
        flash[:notice] = "El Telefono #{@telefono.numero.to_s} se le ha agregado a #{@persona.nombre_completo}."
        format.html { redirect_to([@persona, @telefono]) }
        format.xml  { render :xml => @telefono, :status => :created, :location => @telefono }
      else
        flash[:error] = "Hubo un error creando el teléfono"
        format.html { render :action => "new" }
        format.xml  { render :xml => @telefono.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Actualiza la informacion del telefono especifico de la persona especifica
  def update
    @telefono = @persona.telefonos.find(params[:id])

    respond_to do |format|
      if @telefono.update_attributes(params[:telefono])
        flash[:notice] = "El Telefono #{@telefono.numero.to_s} de #{@persona.nombre_completo} se ha actualizado."
        format.html { redirect_to([@persona, @telefono]) }
        format.xml  { head :ok }
      else
        flash[:error] = "Hubo un error actualizando el teléfono"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @telefono.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Elimina el telefono seleccionado de la persona
  def destroy
    @telefono = @persona.telefonos.find(params[:id])
    @telefono.destroy

    respond_to do |format|
      format.html { redirect_to(persona_telefonos_url(@persona)) }
      format.xml  { head :ok }
    end
  end
end
