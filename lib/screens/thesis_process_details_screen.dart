import 'package:flutter/material.dart';
import '../models/thesis_step.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/navigation_helper.dart';
import '../services/authentication_service.dart'; // if needed

class ThesisStepDetailScreen extends StatelessWidget {
  final ThesisStep step;
  final bool isLoggedIn;
  final String? userId;

  const ThesisStepDetailScreen({
    super.key,
    required this.step,
    required this.isLoggedIn,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
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
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF59A9FF)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1461B4),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Валидира',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF686868),
                                ),
                              ),
                              Text(
                                step.validator,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Color(0xFF686868),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Опис',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF686868),
                                ),
                              ),
                              Text(
                                step.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Color(0xFF686868),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        navBarColor: const Color(0xFF59A9FF),
        isLoggedIn: isLoggedIn,
        onTap: (index) => NavigationHelper.navigateByIndex(context, index, isLoggedIn),
      ),
    );
  }
}
