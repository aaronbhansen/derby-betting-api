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
      # load_from_json(date_json)
      races += 1
    end

    Rails.logger.info("#{races} Races Found")
    true
  end

  def self.load_from_json(race_json)

  end

end
