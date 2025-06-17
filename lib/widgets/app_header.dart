import 'package:bachelor_thesis_app/screens/thesis_process_screen.dart';
import 'package:flutter/material.dart';
import '../services/authentication_service.dart';
import '../screens/login_screen.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AuthService.getLoggedInUser();
    setState(() {
      username = user?.username;
    });
  }

  Future<void> _handleLogout() async {
    await AuthService.logout();
    setState(() {
      username = null;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ThesisProcessScreen()),
    );
  }

  Future<void> _handleLogin() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const CasLoginScreen()),
    );

    if (result == true) {
      await _loadUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = username != null;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: isLoggedIn ? 190 : 280,
            height: 70,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          ),
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: isLoggedIn
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      children: [
                        const Icon(Icons.person, color: Colors.grey, size: 20),
                        Text(
                          username ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _handleLogout,
                          icon: const Icon(Icons.logout, color: Colors.grey),
                          label: const Text("Одјава"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : TextButton.icon(
                      onPressed: _handleLogin,
                      icon: const Icon(Icons.login, color: Colors.grey),
                      label: const Text("Најава"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
