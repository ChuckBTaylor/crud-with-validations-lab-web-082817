class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
    @songs = Song.all
    # binding.pry
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.save ? (redirect_to song_path(@song)) : (render :new)
  end

  def show
  end

  def edit
  end

  def update
    @song.update(song_params) ? (redirect_to song_path(@song)) : (render :edit)
  end

  def destroy
    @song.destroy
    redirect_to songs_path
  end


  private


  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist_name, :released, :release_year, :genre)
  end

end
