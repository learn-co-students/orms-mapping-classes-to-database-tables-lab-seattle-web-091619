class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade)
 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
 
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def self.create(name: name, grade: grade)
    student = Student.new(name, grade)
    student.save
    student
  end

end
