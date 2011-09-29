class PicturesController < ApplicationController
  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])
    
    if params[:size].nil? then
      @picture.inc(:views, 1)
      respond_to do |format|
        format.html #show.html.erb
        format.xml
      end
    elsif params[:size] == "thumbnail" then
      send_data @picture.thumbnail.read, :type => @picture.thumbnail_type, :disposition => 'inline'
    elsif params[:size] == "medium" then
      send_data @picture.medium.read, :type => @picture.medium_type, :disposition => 'inline'
    elsif params[:size] == "fullsize" then
      send_data @picture.fullsize.read, :type => @picture.fullsize_type, :disposition => 'inline'
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    params[:picture][:people] = params[:picture][:people].split(",").map{ |s| s.strip }
    params[:picture][:tags] = params[:picture][:tags].split(",").map{ |s| s.strip }
    params[:picture][:date] = "#{params[:picture]["date(1i)"]}-#{params[:picture]["date(2i)"]}-#{params[:picture]["date(3i)"]}"

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        @picture.unset(:needs_tagging)
        format.html { redirect_to(@picture, :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
      else
        p @picture.date
        format.html { render :action => "show" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end
end
