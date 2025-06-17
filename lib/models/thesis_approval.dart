class ThesisApproval {
  final String index;
  final String studentName;
  final DateTime date;
  final String thesisTitle;
  final String status;
  final bool studentConsent;
  final int creditsApplied;
  final int totalCredits;
  final bool isDocumentationAvailable;
  final String? fileUrl;

  ThesisApproval(
      {required this.index,
      required this.studentName,
      required this.date,
      required this.thesisTitle,
      required this.status,
      required this.studentConsent,
      required this.creditsApplied,
      required this.totalCredits,
      required this.isDocumentationAvailable,
      this.fileUrl});
}
