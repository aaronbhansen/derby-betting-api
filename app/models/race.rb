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
end
