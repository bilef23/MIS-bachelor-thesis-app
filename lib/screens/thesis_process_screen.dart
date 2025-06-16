import 'package:flutter/material.dart';
import '../services/thesis_steps_service.dart';
import '../services/authentication_service.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/thesis_process_details_screen.dart';
import '../utils/navigation_helper.dart';

class ThesisProcessScreen extends StatefulWidget {
  const ThesisProcessScreen({super.key});

  @override
  _ThesisProcessScreenState createState() => _ThesisProcessScreenState();
}

class _ThesisProcessScreenState extends State<ThesisProcessScreen> {
  final ThesisStepsService thesisService = ThesisStepsService();
  final Color primaryTextColor = const Color(0xFF1461B4);
  int _currentIndex = 0;

  bool isLoggedIn = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final user = await AuthService.getLoggedInUser();
    setState(() {
      isLoggedIn = user != null;
      userId = user?.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final steps = thesisService.getThesisSteps();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 12.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
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
                        physics: const BouncingScrollPhysics(),
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          final step = steps[index];
                          return Padding(
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 20),
                              ),
                              onPressed: () {
                                if (isLoggedIn) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          ThesisStepDetailScreen(
                                        step: step,
                                        isLoggedIn: isLoggedIn,
                                        userId: userId,
                                      ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please log in to view step details.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Hero(
                                  tag: 'stepTitle-${step.title}',
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      step.title,
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
                          );
                        },
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          NavigationHelper.navigateByIndex(context, index, isLoggedIn);
        },
      ),
    );
  }
}
