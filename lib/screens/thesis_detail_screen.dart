import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/thesis.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ThesisDetailScreen extends StatelessWidget {
  final Thesis thesis;

  const ThesisDetailScreen({super.key, required this.thesis});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF59A9FF);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(),

            // Back button below AppHeader
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      "Назад",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        thesis.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(Icons.school, "${thesis.studentIndex} – ${thesis.studentName}"),
                            _infoRow(Icons.person, thesis.professorName),
                            if (thesis.secondProfessorName != null && thesis.secondProfessorName!.isNotEmpty)
                              _infoRow(Icons.person_outline, thesis.secondProfessorName!),
                            if (thesis.commissionMember != null && thesis.commissionMember!.isNotEmpty)
                              _infoRow(Icons.groups, thesis.commissionMember!),
                            if (thesis.date != null && thesis.date!.isNotEmpty)
                              _infoRow(Icons.calendar_today, _formatDate(thesis.date!)),
                            if (thesis.approvalStatus != null && thesis.approvalStatus!.isNotEmpty)
                              _infoRow(Icons.check_circle_outline, thesis.approvalStatus!),
                            if (thesis.description != null && thesis.description!.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  _infoRow(Icons.description, thesis.description!),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (thesis.fileUrl != null && thesis.fileUrl!.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse(thesis.fileUrl!);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Не може да се отвори датотеката.')),
                                );
                              }
                            },
                            icon: const Icon(Icons.download, color: Colors.black),
                            label: const Text(
                              "Преземи датотека",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        navBarColor: const Color(0xFF59A9FF),
        isLoggedIn: true,
        onTap: (index) {
          // Handle navigation if needed
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      return DateFormat('dd.MM.yyyy').format(date);
    } catch (_) {
      return rawDate;
    }
  }
}
