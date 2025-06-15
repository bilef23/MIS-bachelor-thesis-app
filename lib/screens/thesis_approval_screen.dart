import 'package:flutter/material.dart';
import '../services/thesis_approval_service.dart';
import '../models/thesis_approval.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/navigation_helper.dart';
import 'package:intl/intl.dart';

class ThesisApprovalScreen extends StatefulWidget {
  const ThesisApprovalScreen({super.key});

  @override
  _ThesisApprovalScreenState createState() => _ThesisApprovalScreenState();
}

class _ThesisApprovalScreenState extends State<ThesisApprovalScreen> {
  final Color primaryTextColor = const Color(0xFF1461B4);
  final ThesisApprovalService thesisApprovalService = ThesisApprovalService();

  int _currentIndex = 1;
  bool isLoggedIn = true;
  String? userId = "211097";

  void handleLogin() {
    setState(() {
      isLoggedIn = true;
      userId = "211097";
    });
  }

  void handleLogout() {
    setState(() {
      isLoggedIn = false;
      userId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThesisApproval approval = thesisApprovalService.getThesisApproval();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              isLoggedIn: isLoggedIn,
              userId: userId,
              onLogin: handleLogin,
              onLogout: handleLogout,
            ),
            // This is the missing box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0x3359A9FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD3E3F4)),
              ),
              child: const Text(
                "Прифаќање на темата од студент: Студентот се согласува со пријавената тема. "
                    "Системот праќа известување по електронска пошта до менторот и службата за студентски прашања.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    _buildCardItem("Индекс", approval.index),
                    _buildCardItem("Студент", approval.studentName),
                    _buildCardItem("Датум", DateFormat('dd.MM.yyyy').format(approval.date)),
                    _buildCardItem("Теза", approval.thesisTitle),
                    _buildCardItem("Статус", approval.status),
                    _buildCardItem("Согласност од студентот", approval.studentConsent ? "Да" : "Не"),
                    _buildCardItem("Пријавена со кредити (${approval.totalCredits})", "${approval.creditsApplied}"),
                    _buildCardItem("Документација", approval.isDocumentationAvailable ? "Достапна" : "Моментално не е достапна"),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // download functionality goes here
                      },
                      icon: const Icon(Icons.download, color: Colors.black,),
                      label: const Text('Преземи датотека', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16
                      ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF59A9FF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        navBarColor: const Color(0xFF59A9FF),
        isLoggedIn: isLoggedIn,
        onTap: (index) => NavigationHelper.navigateByIndex(context, index),
      ),
    );
  }

  Widget _buildCardItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FA),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w500
            )
          ),
        ],
      ),
    );
  }
}
