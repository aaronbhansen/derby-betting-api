# == Schema Information
#
# Table name: race_dates
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  races      :integer          not null
#  track_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_race_dates_on_track_id  (track_id)
#

class RaceDate < ApplicationRecord

  #############
  # Relations
  #############
  belongs_to :track

  has_many :races

  URL = "https://racedb.cdinet.net/tracks/CD/race-days.js"

  def self.load_dates
    result = Faraday.get do |req|
      req.url URL
    end

    data = result.body

    if data.blank?
      Rails.logger.warn("No race data found on result body")
      return
    end

    data.gsub!(/\AloadRaceDays\(/, "")
    data.gsub!(/\);\Z/, "")
    json = JSON.parse(data)

    races = 0
    json.each do |date_json|
      load_from_json(date_json)
      races += 1
    end

    Rails.logger.info("#{races} Races Dates Found")
    true
  end

  def self.load_from_json(date_json)
    track = Track.load_from_json(date_json['Track'])
    date = Date.parse(date_json['Date'], '%Y-%m-%d')
    self.find_or_create_by!(date: date, track: track) do |rd|
      # Sample Json
      # =============
      # "TrackId":348,
      # "TrackCode":"CD",
      # "Track": { JSON }
      # "Date":"2017-06-30",
      # "NumRaces":11

      rd.races = date_json["NumRaces"]
    end
  end
end
