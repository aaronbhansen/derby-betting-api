# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  motto      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ApplicationRecord
end
