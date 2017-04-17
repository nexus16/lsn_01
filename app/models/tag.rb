class Tag < ApplicationRecord
  scope :search, ->q{where "name LIKE '%#{q}%'"}
  scope :list_tag, ->name{where name: name}
end
