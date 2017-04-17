class Tag < ApplicationRecord
  searchkick suggest: [:name], word_start: [:name]

  scope :search_tag, ->q{where "name LIKE '%#{q}%'"}
  scope :list_tag, ->name{where name: name}
end

Tag.reindex
