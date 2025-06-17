class Thesis {
  final String title;
  final String studentIndex;
  final String studentName;
  final String professorName;
  final String? secondProfessorName;
  final String? commissionMember;
  final String? date;
  final String? approvalStatus;
  final String? description;
  final String? fileUrl;

  Thesis({
    required this.title,
    required this.studentIndex,
    required this.studentName,
    required this.professorName,
    this.secondProfessorName,
    this.commissionMember,
    this.date,
    this.approvalStatus,
    this.description,
    this.fileUrl,
  });
}
