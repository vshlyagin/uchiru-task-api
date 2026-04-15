school = School.create!(name: 'Test School')

klass_1 = SchoolClass.create!(
  school_id: school.id,
  number: 1,
  letter: 'A',
  students_count: 0
)

klass_2 = SchoolClass.create!(
  school_id: school.id,
  number: 2,
  letter: 'B',
  students_count: 0
)

Student.create!(
  first_name: 'Ivan',
  last_name: 'Ivanov',
  surname: 'Ivanovich',
  school_id: school.id,
  class_id: klass_1.id
)

Student.create!(
  first_name: 'Petr',
  last_name: 'Petrov',
  surname: 'Petrovich',
  school_id: school.id,
  class_id: klass_1.id
)