class Song < ApplicationRecord
  validates :title, presence: true
  validates :released, exclusion: { in: [nil] }
  validates :release_year, presence: true, if: :is_released?, numericality: { only_integer: true, less_than_or_equal_to: 2019 }
  validates :artist_name, presence: true
  validate :title_unique_this_year?

  def title_unique_this_year?
    match = Song.find_by(release_year: release_year, artist_name: artist_name, title: title)

    if match != nil
      errors.add(:title, "can't be released twice in the same year")
    end
    #binding.pry
    match == nil
  end

  def is_released?
    released
  end
end
