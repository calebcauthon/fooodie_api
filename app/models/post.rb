class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :itemable, polymorphic: true
end
