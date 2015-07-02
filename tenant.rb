class Tenant
  attr_accessor :name, :smoker, :gender, :age
  def initialize(options={})
    @name = options[:name]
    @smoker = options[:smoker]
    @age = options[:age]
    @gender = options[:gender]
  end
end