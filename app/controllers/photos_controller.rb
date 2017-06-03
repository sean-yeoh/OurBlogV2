class PhotosController < ApplicationController
  before_action :authenticate_admin!, except: [:index]
  before_action :set_album, except: [:index]

  def index
    @photos = Photo.all
  end

  def create
    respond_to do |format|
      if params[:photo]
        photo_params[:image].each do |image_file|
          @photo = current_admin.photos.create(image: image_file, album: @album)
        end
        format.html {redirect_to @album}
      elsif params[:file]
        @photo = current_admin.photos.create(image: params[:file], album: @album)
        photo_data = { url: @photo.image_url, size: "#{@photo.image.width}x#{@photo.image.height}" }
        format.json {render json: photo_data, status: 200}
      else
        format.html {redirect_to @album}
      end
    end
  end

  def delete_selected
    Photo.where(id: params[:photos]).delete_all
    redirect_to @album
  end

  def delete_all
    @album.photos.delete_all
    redirect_to @album
  end

  private
  def set_album
    @album = Album.find(params[:album_id])
  end

  def photo_params
    params.require(:photo).permit(:image, :image_data, image: [])
  end
end
