class SubjectModel {
  final String name;
  final String icon;
  final String description;
  final String schedule;
  final String instructor;

  SubjectModel({
    required this.name,
    required this.icon,
    required this.description,
    required this.schedule,
    required this.instructor,
  });

  static List<SubjectModel> getSubjects() {
    return [
      SubjectModel(
        name: 'Mobile App Development',
        icon: '📱',
        description: 'Learn to build mobile apps using Flutter framework.',
        schedule: 'Monday & Wednesday, 10:00 AM - 12:00 PM',
        instructor: 'Dr.Rishita',
      ),
      SubjectModel(
        name: 'Software Re-engineering',
        icon: '🔄',
        description: 'Understanding and improving existing software systems.',
        schedule: 'Tuesday & Thursday, 2:00 PM - 4:00 PM',
        instructor: 'Dr.Shamoon',
      ),
      SubjectModel(
        name: 'Management Information Systems',
        icon: '💼',
        description: 'How organizations use information systems.',
        schedule: 'Friday, 9:00 AM - 12:00 PM',
        instructor: 'Prof.Sohaib',
      ),
    ];
  }
}
