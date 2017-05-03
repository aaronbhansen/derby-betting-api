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

require 'test_helper'

class RaceEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
