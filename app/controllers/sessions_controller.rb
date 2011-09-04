class SessionsController < ApplicationController
  # GET /sessions/new - login screen
  def new
    @session = Session.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # POST /sessions #login
  def create
    @session = Session.new(params[:session])
    res = User.first( :conditions => {:username => @session.username})
    if res.nil? or res.password_hash != @session.password_hash then
      @session.errors.add :username, "the username/password supplied does not match any known user"
      respond_to do |format|
        format.html { render :action => "new" }
      end
    else
      session[:user_id] = res.id
      params[:id] = res.id
      redirect_to "/"
    end
  end

  # DELETE /sessions/1 - #logout
  def destroy
    unless session[:user_id].nil? then
      session[:user_id] = nil
    end
    redirect_to "/"
  end
end
