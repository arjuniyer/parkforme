class SpotsController < ApplicationController
  # GET /spots
  # GET /spots.xml
  def index
    @spots = Spot.all
    @map = Cartographer::Gmap.new( 'map' )
  @map.zoom = :bound
  @map.marker_clusterer = true

  icon_building = Cartographer::Gicon.new(:name => "building_icon",
          :image_url => '/images/icon.gif',
          :width => 31,
          :height => 24,
          :anchor_x => 0,
          :anchor_y => 20,
          :info_anchor_x => 5,
          :info_anchor_x => 1)

  building_cluster_icon = Cartographer::ClusterIcon.new({:marker_type => "Building"})
  #Clustering requires various variant of icon for different grouping/zoom level
  #push first variant
  building_cluster_icon << {
                 :url => '/images/small_icon.gif',
                 :height => 33,
                 :width => 58,
                 :opt_anchor => [10, 0],
                 :opt_textColor => 'black'
               }
  #push second variant
  building_cluster_icon << {
                 :url => '/images/bigger_icon.gif',
                 :height => 63,
                  :width => 98,
                 :opt_anchor => [20, 0],
                 :opt_textColor => 'black'
               }

  #push third variant
  building_cluster_icon << {
                 :url => '/images/biggest_icon.gif',
                 :height => 73,
                 :width => 118,
                 :opt_anchor => [26, 0],
                 :opt_textColor => 'black'
               }

  @map.marker_clusterer_icons = [building_cluster_icon]


  marker1 = Cartographer::Gmarker.new(:name=> "taj_mahal", :marker_type => "Building",
              :position => [27.173006,78.042086],
              :info_window_url => "/url_for_info_content",
              :icon => icon_building)
  marker2 = Cartographer::Gmarker.new(:name=> "raj_bhawan", :marker_type => "Building",
              :position => [28.614309,77.201353],
              :info_window_url => "/url_for_info_content",
              :icon => icon_building)

  @map.markers << marker1
  @map.markers << marker2
    #@map = Cartographer::Gmap.new( 'map' )
    #@map.icons << Cartographer::Gicon.new
    #@map.zoom = :bound
    #marker1 = Cartographer::Gmarker.new(:name=> "taj_mahal", :marker_type => "Building",
    #          :position => [27.173006,78.042086],
    #          :info_window_url => "/url_for_info_content")
    #marker2 = Cartographer::Gmarker.new(:name=> "raj_bhawan", :marker_type => "Building",
#              :position => [28.614309,77.201353],
#              :info_window_url => "/url_for_info_content")
#
#    @map.markers << marker1
#    @map.markers << marker2
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spots }
    end
  end

  # GET /spots/1
  # GET /spots/1.xml
  def show
    @spot = Spot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spot }
    end
  end

  # GET /spots/new
  # GET /spots/new.xml
  def new
    @spot = Spot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spot }
    end
  end

  # GET /spots/1/edit
  def edit
    @spot = Spot.find(params[:id])
  end

  # POST /spots
  # POST /spots.xml
  def create
    @spot = Spot.new(params[:spot])

    respond_to do |format|
      if @spot.save
        format.html { redirect_to(@spot, :notice => 'Spot was successfully created.') }
        format.xml  { render :xml => @spot, :status => :created, :location => @spot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /spots/1
  # PUT /spots/1.xml
  def update
    @spot = Spot.find(params[:id])

    respond_to do |format|
      if @spot.update_attributes(params[:spot])
        format.html { redirect_to(@spot, :notice => 'Spot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.xml
  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy

    respond_to do |format|
      format.html { redirect_to(spots_url) }
      format.xml  { head :ok }
    end
  end
end
