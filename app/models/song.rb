class Song < ApplicationRecord
    validates :title, presence: :true
    validate :title_validation
    validates :released, inclusion: {in: [true, false]}
    validate :release_year_validation

    validates :artist_name, presence: :true
    def title_validation
        matches=Song.where(artist_name: artist_name, title: title, release_year: release_year)
        return unless matches.any?
        errors.add(:title_val,"Title is already taken for this artist this year!") if matches.count>1 || matches.first.id != self.id
    end
    def release_year_validation
        if(released)
            if(release_year==nil || release_year>Time.now.year)
                errors.add(:release_year,"Bad release year.")
            end
        end
    end
end
