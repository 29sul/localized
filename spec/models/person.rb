class Person
  attr_accessor :age

  def age
    @age || Date.new(1988, 1, 22)
  end
end
