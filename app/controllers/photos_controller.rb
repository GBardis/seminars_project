class PhotosController < ApplicationController
  #before_action :require_user, only: [:index, :show]
  before_action :find_photo, only:[:index,:show]

  def index
    @seminar = Seminar.find(params[:seminar_id])

    @photos = @seminar.photos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  def show
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  def new
    @seminar = Seminar.find(params[:seminar_id])
    @photo = @seminar.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      respond_to do |format|
        format.html do
          render json: [@photo.to_jq_upload].to_json,
          content_type: 'text/html',
          layout: false
        end
        format.json do
          render json: [@photo.to_jq_upload].to_json
        end
      end
    else
      render json: [{ error: 'custom_failure' }], status: 304
    end
  end
  def edit
     @photo = Photo.find(params[:id])
  end

  def update
    @seminar = Seminar.find(params[:seminar_id])
    @photo = @seminar.photos.find(params[:id])
    respond_to do |format|
      if @photo.update_attributes(photo_params)
        format.html { redirect_to seminar_path(@seminar), notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end


  private
  def find_photo 
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require.permit(:photo, :seminar_id,:image, :image_file_name, :image_content_type, :image_file_size)
  end
end
