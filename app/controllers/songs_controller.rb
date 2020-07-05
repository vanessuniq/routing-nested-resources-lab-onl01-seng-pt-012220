class SongsController < ApplicationController
  def index
    
    if params[:artist_id]
      @artist = find_instance(Artist, params[:artist_id])
      if @artist
        @songs = @artist.songs
      else
        flash[:alert] = 'Artist not found'
        redirect_to artists_path
      end
      
    else
      @songs = Song.all
    end
  end

  def show
    @song = find_instance(Song, params[:id])
    if @song
      @song 
    elsif params[:artist_id]
      flash[:alert] = 'Song not found'
      redirect_to artist_songs_path(params[:artist_id])
    else
      flash[:alert] = 'Song not found'
      redirect_to songs_path
    end
    
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end

  def find_instance(klass, id)
    klass.find_by(id: id)
  end
end

