class User < ApplicationRecord
  enum role: { operator: :operator }

  has_many :availabilities
  has_many :oneoff_availabilities
  has_many :recurrent_availabilities
end
