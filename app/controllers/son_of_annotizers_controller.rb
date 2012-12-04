class SonOfAnnotizersController < ApplicationController
  # GET /api/projects.json
  #def projects
  #  @son_of_annotizers = 
  def login
    if request.post?
      @soa = SonOfAnnotizer.new(params[:user],params[:pwd])
      if @soa.valid_login? 
        session[:user]=params[:user]
        session[:pwd]=params[:pwd]
        redirect_to :action=>:index
      else
        reset_session
      end
    end
  end  

  def logout
    reset_session
    redirect_to :action=>:login
  end



  # GET /son_of_annotizers
  # GET /son_of_annotizers.json
  def index
    unless session[:user] 
      redirect_to :action=>:login and return
    end
    @soa = SonOfAnnotizer.new(session[:user],session[:pwd])
    @projects = @soa.projects
  end

def documents
  @soa = SonOfAnnotizer.new(session[:user],session[:pwd])
  @documents = @soa.documents_for_project_id( params[:project_id])
  render :content_type=>'text/html', :layout=>false
end


def notes
  @soa = SonOfAnnotizer.new(session[:user],session[:pwd])
  @document = @soa.document( params[:document_id])
  render :content_type=>'text/html', :layout=>false
end



  # GET /son_of_annotizers/1
  # GET /son_of_annotizers/1.json
  def show
    @son_of_annotizer = SonOfAnnotizer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @son_of_annotizer }
    end
  end

  # GET /son_of_annotizers/new
  # GET /son_of_annotizers/new.json
  def new
    @son_of_annotizer = SonOfAnnotizer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @son_of_annotizer }
    end
  end

  # GET /son_of_annotizers/1/edit
  def edit
    @son_of_annotizer = SonOfAnnotizer.find(params[:id])
  end

  # POST /son_of_annotizers
  # POST /son_of_annotizers.json
  def create
    @son_of_annotizer = SonOfAnnotizer.new(params[:son_of_annotizer])

    respond_to do |format|
      if @son_of_annotizer.save
        format.html { redirect_to @son_of_annotizer, :notice => 'Son of annotizer was successfully created.' }
        format.json { render :json => @son_of_annotizer, :status => :created, :location => @son_of_annotizer }
      else
        format.html { render :action => "new" }
        format.json { render :json => @son_of_annotizer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /son_of_annotizers/1
  # PUT /son_of_annotizers/1.json
  def update
    @son_of_annotizer = SonOfAnnotizer.find(params[:id])

    respond_to do |format|
      if @son_of_annotizer.update_attributes(params[:son_of_annotizer])
        format.html { redirect_to @son_of_annotizer, :notice => 'Son of annotizer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @son_of_annotizer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /son_of_annotizers/1
  # DELETE /son_of_annotizers/1.json
  def destroy
    @son_of_annotizer = SonOfAnnotizer.find(params[:id])
    @son_of_annotizer.destroy

    respond_to do |format|
      format.html { redirect_to son_of_annotizers_url }
      format.json { head :no_content }
    end
  end
end
