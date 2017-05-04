# == Schema Information
#
# Table name: race_entries
#
#  id                       :integer          not null, primary key
#  race_id                  :integer          not null
#  post_position            :integer          not null
#  program_number           :text
#  scratched                :boolean          not null
#  jockey                   :text
#  horse_name               :text
#  horse_color              :text
#  horse_birth_year         :integer
#  morning_odds_numerator   :integer
#  morning_odds_denominator :integer
#  current_odds_numerator   :integer
#  current_odds_denominator :integer
#  win_payoff               :decimal(, )
#  place_payoff             :decimal(, )
#  show_payoff              :decimal(, )
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_race_entries_on_race_id  (race_id)
#

class RaceEntry < ApplicationRecord

  #############
  # Relations
  #############
  belongs_to :race

  def self.load_entries_for_race(race, race_entries_json)
    race_entries = 0
    race_entries_json.each do |race_entry_json|
      race_entry = load_from_json(race, race_entry_json)
      race_entries += 1
    end

    Rails.logger.info("#{race_entries} Race Entries Found")
    true
  end

  def self.load_from_json(race, race_entry_json)
    # Sample Data
    # =============
    # CurrendOdds: {Numerator: 21, Denominator: 1, Decimal: 21}
    # Earnings: 80
    # FinishPosition: 9
    # Horse: {Id: 98349, BrisId: 4139783, Name: "Logistical", DamName: "", SireName: "", YearOfBirth: 2014,…}
    # Jockey: {Id: 2, BrisPersonId: 838796, Name: "Chris Landeros", Slug: "", FirstName: "", MiddleName: "",…}
    # LengthsAhead: 350
    # LengthsBehind: 1430
    # MorningLineOdds: {Numerator: 8, Denominator: 1, Decimal: 8}
    # Owner: {Id: 647, BrisPersonId: 1871146, Name: "Butzow, Barry and Joni", Slug: "", FirstName: "",…}
    # PlacePool: 1667
    # PostPosition: 1
    # ProgramNumber: "1"
    # Scratched: false
    # ShowPool: 1155
    # Trainer: {Id: 433, BrisPersonId: 2522379, Slug: "", Name: "Joe Sharp", FirstName: "", MiddleName: "",…}
    # WinPool: 4540
    entry = self.find_or_initialize_by(race: race, post_position: race_entry_json["PostPosition"])

    entry.program_number = race_entry_json["ProgramNumber"]
    entry.scratched = race_entry_json["Scratched"]
    entry.jockey = race_entry_json["Jockey"]["Name"]
    entry.horse_name = race_entry_json["Horse"]["Name"]
    entry.horse_color = race_entry_json["Horse"]["Color"]
    entry.horse_birth_year = race_entry_json["Horse"]["YearOfBirth"]
    entry.morning_odds_numerator = race_entry_json["MorningLineOdds"]["Numerator"]
    entry.morning_odds_denominator = race_entry_json["MorningLineOdds"]["Denominator"]
    entry.current_odds_numerator = race_entry_json["CurrentOdds"]["Numerator"]
    entry.current_odds_denominator = race_entry_json["CurrentOdds"]["Denominator"]
    entry.finish_position = race_entry_json["FinishPosition"]
    entry.win_payoff = race_entry_json["WinPayoff"]
    entry.place_payoff = race_entry_json["PlacePayoff"]
    entry.show_payoff = race_entry_json["ShowPayoff"]
    entry.save!
    entry
  end
end
