import 'package:flutter/material.dart';
import '../screens/thesis_process_screen.dart';
import '../screens/thesis_list_screen.dart';
import '../screens/thesis_approval_screen.dart';
import '../screens/thesis_procedure_screen.dart';

class NavigationHelper {
  static void navigateByIndex(BuildContext context, int index, bool isLoggedIn) {
    if (isLoggedIn) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ThesisProcessScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ThesisApprovalScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ThesisProcedureScreen()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ThesisListScreen()),
          );
          break;
      }
    } else {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ThesisProcessScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ThesisListScreen()),
          );
          break;
      }
    }
  }
}
