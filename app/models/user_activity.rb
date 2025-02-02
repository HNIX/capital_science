# == Schema Information
#
# Table name: user_activities
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_user_activities_on_activity_id  (activity_id)
#  index_user_activities_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (user_id => users.id)
#
class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity
end
