import 'package:flutter/material.dart';
import '../models/thesis.dart';
import '../services/thesis_list_service.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/thesis_detail_screen.dart';
import '../utils/navigation_helper.dart';

class ThesisListScreen extends StatefulWidget {
  const ThesisListScreen({super.key});

  @override
  State<ThesisListScreen> createState() => _ThesisListScreenState();
}

class _ThesisListScreenState extends State<ThesisListScreen> {
  final ThesisListService thesisListService = ThesisListService();
  final Color primaryTextColor = const Color(0xFF1461B4);
  bool isLoggedIn = true;
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    List<Thesis> theses = thesisListService.getTheses();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              isLoggedIn: isLoggedIn,
              userId: '211097',
              onLogin: () {
                setState(() {
                  isLoggedIn = false;
                });
              },
              onLogout: () {
                setState(() {
                  isLoggedIn = false;
                });
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0)
            ),

            // Expanded scrollable container
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: theses.length,
                  itemBuilder: (context, index) {
                    final thesis = theses[index];
                    return GestureDetector(
                      onTap: () {
                        if (isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThesisDetailScreen(thesis: thesis),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please log in to view thesis details.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              thesis.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildInfoItem(Icons.school, "${thesis.studentIndex} – ${thesis.studentName}", primaryTextColor),
                            const SizedBox(height: 4),
                            _buildInfoItem(Icons.person, thesis.professorName, Colors.black54),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: isLoggedIn ? _currentIndex : 1,
        navBarColor: const Color(0xFF59A9FF),
        isLoggedIn: isLoggedIn,
        onTap: (index) => NavigationHelper.navigateByIndex(context, index),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color textColor) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
