class Picture < ApplicationRecord

  validates :artist, presence: true
  validates :title, presence: true
  validates :url, presence: true
  validates :url, uniqueness: true
  validates :url, format: {with: /https?:\/\/[\S]+/}

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in_year(year)
    start_year = DateTime.new(year)
    end_year   = DateTime.new(year).end_of_year
    Picture.where("created_at BETWEEN ? AND ?", start_year, end_year)
  end

end
