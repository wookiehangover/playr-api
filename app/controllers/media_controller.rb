class MediaController < ApplicationController
  before_filter :set_access_control_headers
  skip_before_filter :verify_authenticity_token

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = ENV['CLIENT_URL'] || '*'
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, PATCH, DELETE'
    headers['Access-Control-Allow-Headers'] = 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Origin, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
    headers['Access-Control-Max-Age'] = '1000'
  end

  def options
    head :ok
  end

  # GET /media
  # GET /media.json
  def index
    playlist_id = params[:playlist_id]
    @media = Media.where(playlist_id: playlist_id)

    render json: @media
  end

  # GET /media/1
  # GET /media/1.json
  def show
    @medium = Media.find(params[:id])

    render json: @medium
  end

  # GET /media/new
  # GET /media/new.json
  def new
    @medium = Media.new

    render json: @medium
  end

  # POST /media
  # POST /media.json
  def create
    @medium = Media.new(params[:media])
    logger.debug params[:media]

    if @medium.save
      render json: @medium, status: :created
    else
      render json: @medium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /media/1
  # PATCH/PUT /media/1.json
  def update
    @medium = Media.find(params[:id])

    if @medium.update_attributes(params[:media])
      head :no_content
    else
      render json: @medium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    @medium = Media.find(params[:id])
    @medium.destroy

    head :no_content
  end
end
