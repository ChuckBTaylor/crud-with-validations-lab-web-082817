class SongTitleValidator < ActiveModel::Validator

  def validate(record)
      if record[:title] && Song.where(artist_name: record[:artist_name], release_year: record[:release_year]).find {|song| song.title == record[:title]}
        record.errors[:title] << "That artist already has a song with that title for that year."
      end
  end

end

class Song < ActiveRecord::Base
  validates :title, presence: true
  validates_with SongTitleValidator
  validates :artist_name, presence: true
  validate :assert_release_year

  def assert_release_year

    if self.released #If the song is released...
      if self.release_year #...and has a release year...
        if self.release_year > Time.now.year #...and the release year is in the futre
          # binding.pry
          self.errors[:release_year] << "Can't add song in the future" #invalid for futre release
        end
      else
        self.errors[:release_year] << "The song is released so it needs a release year" #invalid for no release date
      end
    end
  end

end
