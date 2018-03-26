class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

  def add_boss(boss)
    @boss = boss
  end
end

# Less than sign herefor known as LTS
class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, employees, boss = nil)
    @employees = employees
    super(name, title, salary, boss)
    employees.each { |employee| employee.add_boss(self) }
  end

  def mine_and_underlings_salary
    underling_salary = 0
    employees.each do |employee|
      unless employee.instance_of?(Manager)
        underling_salary += employee.salary
      else
        underling_salary += employee.mine_and_underlings_salary
      end
    end
    underling_salary + salary
  end



  def bonus(multiplier)
    salary_bonus = mine_and_underlings_salary - salary
    salary_bonus * multiplier
  end
end

david = Employee.new('david', 'TA', 10_000)
shauna = Employee.new('shauna', 'TA', 12_000)
darren = Manager.new('darren', 'TA Manager', 78_000, [david, shauna])
ned = Manager.new('ned', 'founder', 1_000_000, [darren])

p darren.bonus(4)
