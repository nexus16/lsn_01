class Supports::Category
  def initialize category
    @category = category
  end

  def category_child
    @category.descendants
  end

  def show_question
    @category.questions
  end
end
