class Supports::CategoryAdmin
  def initialize
  end

  def classes
    Category.roots
  end

  def category_class
    Category.new
  end

  def category_subject
    Category.new
  end
end
