import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'admin_dashboard.dart';
import 'login_page.dart';
import '../constants/app_colors.dart';

/// Shows `AdminDashboard` only for users with the `admin` role.
class AdminGate extends StatefulWidget {
  const AdminGate({super.key});

  @override
  State<AdminGate> createState() => _AdminGateState();
}

class _AdminGateState extends State<AdminGate> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          // Not signed in → show login page
          return LoginPage(onSignedIn: () => setState(() {}));
        }

        // Signed in — check role from Firestore
        return FutureBuilder(
          future: _auth.getCurrentAppUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
            final appUser = snap.data;
            if (appUser == null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('لم يتم العثور على ملف المستخدم في قاعدة البيانات.'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        await _auth.signOut();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.deepBlue),
                      child: const Text('تسجيل خروج'),
                    ),
                  ],
                ),
              );
            }

            if (appUser.role == UserRole.admin) {
              return const AdminDashboard();
            }

            // For non-admins, show the Hello page (LoginPage with hello page logic)
            return LoginPage(onSignedIn: () => setState(() {}));
          },
        );
      },
    );
  }
}
