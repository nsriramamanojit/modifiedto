### Author :Upender
## Date and Time :30-09-2008 12:50 am
class Admin::SubjectController < ApplicationController
layout "admin_home" 
  def list
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_code,subject_name,subject_description,last_question_number",:order=>'subject_name')
   end  
  def new 
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
    @subject=Admin::Subject.new
    
  end
  def create
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
    @subject=Admin::Subject.new(params[:subject])
    if @subject.save
      redirect_to :action => 'show', :id => @subject
    else
      render :action => 'new'
    end
  end
  def edit
     @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
    @subject=Admin::Subject.find(params[:id])
  end
  def update
     @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
    @subject=Admin::Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      flash[:notice] = 'Successfully Updated'
      redirect_to :action => 'show', :id => @subject
    else
      render :action => 'edit'
    end
  end
   def show
    @subject=Admin::Subject.find(params[:id])
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
  end
  
end
