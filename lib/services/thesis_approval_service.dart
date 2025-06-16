import '../models/thesis_approval.dart';

class ThesisApprovalService {
  List<ThesisApproval> getThesisApprovals() {
    return [
      ThesisApproval(
        index: '211097',
        studentName: 'Филип Самарџиски',
        date: DateTime(2025, 09, 15),
        thesisTitle: 'Предикција на дијабетична ретинопатија со CNN',
        status: 'Валидирање од службата за студентски прашања',
        studentConsent: true,
        creditsApplied: 240,
        totalCredits: 240,
        isDocumentationAvailable: true,
      ),
      ThesisApproval(
        index: '211079',
        studentName: 'Тамара Стојанова',
        date: DateTime(2025, 09, 15),
        thesisTitle: 'Предикција на дијабетична ретинопатија со CNN',
        status: 'Валидирање од службата за студентски прашања',
        studentConsent: true,
        creditsApplied: 240,
        totalCredits: 240,
        isDocumentationAvailable: true,
      ),
      ThesisApproval(
        index: '211098',
        studentName: 'Биљана Димитрова',
        date: DateTime(2025, 12, 23),
        thesisTitle: 'Предикција на дијабетична ретинопатија со CNN',
        status: 'Валидирање од службата за студентски прашања',
        studentConsent: true,
        creditsApplied: 240,
        totalCredits: 240,
        isDocumentationAvailable: false,
      )
    ];
  }

  ThesisApproval? getThesisByStudentId(String studentIndex) {
    try {
      return getThesisApprovals()
          .firstWhere((thesis) => thesis.index == studentIndex);
    } catch (e) {
      return null;
    }
  }
}
