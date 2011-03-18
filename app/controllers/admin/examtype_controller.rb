### Author :Upender
## Date and Time :30-09-2008 1:50 am
class Admin::ExamtypeController < ApplicationController
   layout 'admin_home'
  def list
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype,examtype_description")
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype,examtype_description",:order=>'examtype')
  end  
  def new 
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype")
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
    @examtype=Admin::Examtype.new
  end
  def create
     @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype")
     @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
    @examtype=Admin::Examtype.new(params[:examtype])
    if @examtype.save
      redirect_to :action => 'show', :id => @examtype
    else
      render :action => 'new'
    end
  end
  def edit
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype")
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
    @examtype=Admin::Examtype.find(params[:id])
  end
  def update
     @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype")
     @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
    @examtype=Admin::Examtype.find(params[:id])
    if @examtype.update_attributes(params[:examtype])
      flash[:notice] = 'Successfully Updated'
      redirect_to :action => 'show', :id => @examtype
    else
      render :action => 'edit'
    end
  end

  def show
   
   @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype")
  @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
   @examtype=Admin::Examtype.find(params[:id])   
   
  end
end
