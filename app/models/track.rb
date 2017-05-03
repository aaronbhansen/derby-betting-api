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

class Track < ApplicationRecord

  def self.load_from_json(track_json)
    self.find_or_create_by!(external_id: track_json['Id']) do |t|
      # Same Data
      # =============
      # "Id":348,
      # "Name":"Churchill Downs",
      # "Country":"USA",
      # "BrisCode":"CD",
      # "TwinspiresCode":"CD",
      # "RcnCode":"CHD",
      # "Type":"Thoroughbred",
      # "TimeZone":"US/Eastern",
      # "Latitude":"38.20295000",
      # "Longitude":"-85.77013700",
      # "IsMonitored":true

      t.name = track_json['Name']
      t.timezone = track_json['TimeZone']
      t.country = track_json['Country']
      t.horse_type = track_json['Type']
    end
  end
end
