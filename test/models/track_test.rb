# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  external_id :integer          not null
#  name        :text             not null
#  timezone    :text
#  country     :text
#  horse_type  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
