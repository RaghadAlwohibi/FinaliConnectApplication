class Course {
  String name;
  String code;
  bool lab;
  String type;

  int creditHours;

  Course({this.name, this.code, this.creditHours, this.lab, this.type});
}

List<Course> courses = [
  Course(
    name: 'C++',
    code: 'CIS112',
    lab: true,
    type: typeList[0],
    creditHours: 3,
  ),
  Course(
    name: 'Java',
    code: 'CIS112',
    type: typeList[1],
    lab: true,
    creditHours: 3,
  ),
  Course(
    name: 'Python',
    code: 'CIS112',
    type: typeList[2],
    lab: true,
    creditHours: 3,
  )
];

List<String> typeList = ['type1', 'type2', 'type3'];
