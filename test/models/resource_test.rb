# == Schema Information
#
# Table name: resources
#
#  id           :integer          not null, primary key
#  name         :string
#  address      :string
#  notes        :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  latitude     :float
#  longitude    :float
#  slug         :string
#  phone_number :string
#  website      :string
#

require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
