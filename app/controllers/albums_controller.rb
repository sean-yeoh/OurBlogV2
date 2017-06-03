class AlbumsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
    @album = Album.new
  end

  def create
    @album = current_admin.albums.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
      else
        format.js
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
      else
        format.js
      end
    end
  end

  def show
    @photo = Photo.new
  end

  def destroy
    @album.destroy
    redirect_to albums_path, notice: 'Album was successfully destroyed.'
  end

  private
  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name)
  end
end
