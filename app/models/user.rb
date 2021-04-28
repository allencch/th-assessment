class User < ApplicationRecord
  enum role: { operator: :operator }
end
