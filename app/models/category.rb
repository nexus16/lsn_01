class Category < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_closure_tree

  scope :list_objects,->name {where name: name}
end
