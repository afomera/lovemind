# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  resource_id :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource
  after_create :send_notification

  def send_notification
    @resource = Resource.find(self.resource_id)
    @user = User.find(@resource.user_id)
    CommentMailer.new_comment(@resource, @user).deliver
  end
end
