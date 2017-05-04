# == Schema Information
#
# Table name: races
#
#  id                       :integer          not null, primary key
#  race_date_id             :integer          not null
#  track_id                 :integer          not null
#  number                   :integer          not null
#  name                     :text
#  distance                 :text
#  last_updated_on          :datetime
#  post_time                :datetime
#  surface                  :text
#  track_condition          :text
#  wager_type               :text
#  exacta_base_bet_amount   :decimal(, )
#  exacta_payoff_amount     :decimal(, )
#  trifecta_base_bet_amount :decimal(, )
#  trifecta_payoff_amount   :decimal(, )
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_races_on_race_date_id  (race_date_id)
#  index_races_on_track_id      (track_id)
#

class Race < ApplicationRecord

  #############
  # Relations
  #############
  belongs_to :race_date
  belongs_to :track

  has_many :race_entries

  # https://racedb.cdinet.net/tracks/CD/race-days/2017-05-02/races.js
  URL = "https://racedb.cdinet.net/tracks/CD/race-days/{{DATE}}/races.js"
  def self.load_races_for_date(race_date)
    url = URL.gsub("{{DATE}}", race_date.date.strftime("%Y-%m-%d"))
    result = Faraday.get do |req|
      req.url url
    end

    data = result.body

    if data.blank?
      Rails.logger.warn("No races found on result body")
      return
    end

    data.gsub!(/\AloadRaceDay\(/, "")
    data.gsub!(/\);\Z/, "")
    json = JSON.parse(data)

    races = 0
    json.each do |race_json|
      race = load_from_json(race_date, race_json)
      race_entries_json = race_json["Entries"]
      if race_entries_json.present?
        RaceEntry.load_entries_for_race(race, race_entries_json)
      end
      races += 1
    end

    Rails.logger.info("#{races} Races Found")
    true
  end

  def self.load_from_json(race_date, race_json)
    # Sample Json
    # =============
    # AgeRestriction: "4 Years and Older"
    # DailyDoublePool: 31539
    # Date: "2017-05-02"
    # Distance: "1 1/16 Miles"
    # Entries: [,…]
    # ExactaPool: 54323
    # ExoticResults: [{WagerType: "Exacta", WagerAmount: 2, WinningNumbers: "2/1", PayoffAmount: 10.399999618530273,…},…]
    # IsStakes: false
    # LastUpdatedAt: "2017-05-03T03:46:51Z"
    # Name: ""
    # Number: 1
    # PlacePool: 18069
    # PostTime: "2017-05-02T12:46:00-04:00"
    # Purse: 18000
    # ReplayVideo: {Filename: "201705021244CHD1", FilenameFlash: "mp4:2017/1308/201705021244CHD1_1308.mp4"}
    # SexRestriction: ""
    # ShowPool: 12274
    # Surface: "Dirt"
    # Track: {Id: 348, Name: "Churchill Downs", Country: "USA", BrisCode: "CD", TwinspiresCode: "CD",…}
    # TrackCondition: "Fast"
    # TrifectaPool: 35803
    # Type: "Claiming"
    # WagerType: "Daily Double / Exacta / Trifecta / Superfecta / Pick 3 (1-2-3) Pick 4 (1-2-3-4) "
    # Weather: {Summary: "Clear", Icon: "clear-day", Temperature: 61, PrecipitationProbability: 0.17000000178813934,…}
    # WinPool: 50014
    # Yards: 1870
    race = self.find_or_initialize_by(race_date: race_date, number: race_json["Number"])
    race.track = race_date.track
    race.name = race_json["Name"]
    race.distance = race_json["Date"]
    race.last_updated_on = DateTime.parse(race_json["LastUpdatedAt"])
    race.post_time = DateTime.parse(race_json["PostTime"])
    race.surface = race_json["Surface"]
    race.track_condition = race_json["TrackCondition"]
    race.wager_type = race_json["WagerType"]
    if race_json["ExoticResults"].present?
      exacta_result = race_json["ExoticResults"].select { |result| result["WagerType"] == "Exacta" }.first
      if exacta_result.present?
        race.exacta_base_bet_amount = exacta_result["WagerAmount"]
        race.exacta_payoff_amount = exacta_result["PayoffAmount"]
      end

      trifecta_result = race_json["ExoticResults"].select { |result| result["WagerType"] == "Trifecta" }.first
      if trifecta_result.present?
        race.trifecta_base_bet_amount = trifecta_result["WagerAmount"]
        race.trifecta_payoff_amount = trifecta_result["PayoffAmount"]
      end
    end
    race.save!
    race
  end

end
