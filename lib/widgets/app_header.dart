import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final bool isLoggedIn;
  final String? userId;
  final VoidCallback onLogin;
  final VoidCallback onLogout;

  const AppHeader({
    super.key,
    required this.isLoggedIn,
    this.userId,
    required this.onLogin,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Make the logo shrink when user is logged in
          Container(
            width: isLoggedIn ? 190 : 280,
            height: 70,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Spacer
          if(!isLoggedIn) const SizedBox(width: 10),

          /// Right side: login or user info
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
                    userId ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onLogout,
                    icon: const Icon(Icons.logout, color: Colors.grey, size: 20),
                    label: const Text(
                      "Одјава",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
                  : TextButton.icon(
                onPressed: onLogin,
                icon: const Icon(Icons.login, color: Colors.grey, size: 20),
                label: const Text(
                  "Најава",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}