import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/navigation_helper.dart';

class ThesisProcedureScreen extends StatefulWidget {
  const ThesisProcedureScreen({super.key});

  @override
  _ThesisProcedureScreenState createState() => _ThesisProcedureScreenState();
}

class _ThesisProcedureScreenState extends State<ThesisProcedureScreen> {
  final Color primaryTextColor = const Color(0xFF686868);

  int _currentIndex = 2; // Notice: assuming this is screen index 2 (Procedura za diplomksa)
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

  final String generalDescription =
      "Дипломската се запишува на почеток на семестар. "
      "Студентот не мора да има избрано ментор при запишување на семестарот, но мора да има избрано ментор при заверката на семестарот. "
      "Менторот се потпишува во индексот кај предметот Дипломска работа.";

  final List<String> procedures = [
    "Дипломската работа најрано може да се запише при првото запишување на летниот семестар во трета година за 3 годишните или четврта година за 4 годишните студии.",
    "Ментор на дипломскиот труд може да биде наставник избран во наставно-научно звање на Факултетот.",
    "Дипломската работа се пријавува од наставно-научна област која постои на Факултетот и се работи под надзор на ментор.",
    "Дипломската студентот може да ја пријави доколку има освоени минимум 168 ЕКТС кредити на тригодишните, односно 228 кредити на четиригодишните студиски програми . Се проверува во системот или во досието дали е исполнет овој предуслов.",
    "Дипомската работа најрано може да се запише при првото запишување на летниот семестар во трета година за 3 годишните или четврта година за 4 годишните студии.",
  ];

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      generalDescription,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: procedures.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(Icons.note, color: Color(0xFF59A9FF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      procedures[index],
                                      style: TextStyle(
                                        color: primaryTextColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
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
        onTap: (index) => NavigationHelper.navigateByIndex(context, index),
      ),
    );
  }
}
