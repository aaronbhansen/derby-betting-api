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

require 'test_helper'

class RaceDateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
