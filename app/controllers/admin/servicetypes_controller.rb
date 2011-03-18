class Admin::ServicetypesController < ApplicationController
  # GET /admin_servicetypes
  # GET /admin_servicetypes.xml
 layout 'admin_home'
  def index
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type,servicetype_enabled")
  end

  # GET /admin_servicetypes/1
  # GET /admin_servicetypes/1.xml
  def show
     @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type")
    @servicetype = Admin::Servicetype.find(params[:id])
  end

  # GET /admin_servicetypes/new
  # GET /admin_servicetypes/new.xml
  def new
    @servicetype = Admin::Servicetype.new
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type")
  end

  # GET /admin_servicetypes/1/edit
  def edit
    @servicetype = Admin::Servicetype.find(params[:id])
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type")
  end

  # POST /admin_servicetypes
  # POST /admin_servicetypes.xml
  def create
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type")
    @servicetype = Admin::Servicetype.new(params[:servicetype])
      if @servicetype.save
        flash[:notice] = 'Admin::Servicetype was successfully created.'
        redirect_to :action => 'show',:id =>  @servicetype.id
      else
        render :action => 'new'
      end
  end

  # PUT /admin_servicetypes/1
  # PUT /admin_servicetypes/1.xml
  def update
  @servicetype = Admin::Servicetype.find(params[:id])
      if @servicetype.update_attributes(params[:servicetype])
        flash[:notice] = 'Admin::Servicetype was successfully updated.'
        redirect_to :action=> 'show',:id =>  @servicetype.id
      else
        render :action =>'edit'
      end
  end

end
