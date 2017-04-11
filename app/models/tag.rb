class Tag < ApplicationRecord
  scope :search, ->q{where "name LIKE '%#{q}%'"}
end
