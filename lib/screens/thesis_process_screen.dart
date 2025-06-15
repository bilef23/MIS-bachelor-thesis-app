import 'package:flutter/material.dart';
import '../services/thesis_service.dart';
import '../models/thesis_step.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/navigation_helper.dart';
import 'thesis_process_details_screen.dart';

class ThesisProcessScreen extends StatefulWidget {
  const ThesisProcessScreen({super.key});

  @override
  _ThesisProcessScreenState createState() => _ThesisProcessScreenState();
}

class _ThesisProcessScreenState extends State<ThesisProcessScreen> {
  final Color primaryTextColor = const Color(0xFF1461B4);

  final ThesisService thesisService = ThesisService();

  int _currentIndex = 0;

  bool isLoggedIn = true;
  String? userId = "211097";

  void handleLogin() {
    setState(() {
      isLoggedIn = true;  // Fix here: should be true on login
      userId = "211097"; // Or dynamically assigned
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
    List<ThesisStep> steps = thesisService.getThesisSteps();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Постапка за пријавување, одбрана и\nоценa на дипломска работа',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: steps.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryTextColor,
                              backgroundColor: const Color(0xFFFAFAFA),
                              side: BorderSide(color: Colors.grey.shade300),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ThesisStepDetailScreen(
                                        step: steps[index],
                                        isLoggedIn: isLoggedIn,
                                        userId: userId,
                                        onLogin: handleLogin,
                                        onLogout: handleLogout,
                                      ),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Hero(
                                tag: 'stepTitle-${steps[index]}',
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    steps[index].title,
                                    style: TextStyle(
                                      color: primaryTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
}
