import '../models/thesis_approval.dart';

class ThesisApprovalService {
  ThesisApproval getThesisApproval() {
    return ThesisApproval(
      index: '211097',
      studentName: 'Тамара Стојанова',
      date: DateTime(2025, 12, 23),
      thesisTitle: 'Предикција на дијабетична ретинопатија со CNN',
      status: 'Валидаирање од службата за студентски прашања',
      studentConsent: true,
      creditsApplied: 240,
      totalCredits: 240,
      isDocumentationAvailable: false,
    );
  }
}
