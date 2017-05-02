class Category < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_closure_tree dependent: :destroy

  scope :list_objects, ->name{where name: name}

  def count_question_by_class
    list_questions = []
    self.descendants.each do |subject|
      (list_questions << subject.questions).flatten!
    end
    list_questions.count
  end
end
