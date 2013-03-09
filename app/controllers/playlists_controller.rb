class PlaylistsController < ApplicationController
  before_filter :set_access_control_headers
  respond_to :json

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = ENV['CLIENT_URL']
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, PATCH, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Origin, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
    headers['Access-Control-Max-Age'] = '1000'
  end

  def options
    head :ok
  end

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.includes(:items).all
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist = Playlist.includes(:items).find(params[:id])
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    @playlist = Playlist.new
  end

  # POST /playlists
  # POST /playlists.json
  def create
    current_user = User.find( session[:user_id] )

    unless current_user
      redirect_to "#{ENV['CLIENT_URL']}#login"
    end

    @playlist = Playlist.includes(:items, :user).new(params[:playlist])
    @playlist.user = current_user

    if @playlist.save
      render json: @playlist, status: :created, location: @playlist
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    @playlist = Playlist.find(params[:id])

    if @playlist.update_attributes(params[:playlist])
      head :no_content
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    head :no_content
  end
end
