import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/app_colors.dart';
import 'pages/home_page.dart';
import 'pages/mutun_page.dart';
import 'pages/programs_page.dart';
import 'pages/institutions_page.dart';
import 'pages/admin_gate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// Wrapper app widget. Keep the class named `MyApp` so the default
/// widget test (which looks for `MyApp`) can find it.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حاضرة مليانة',
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deepBlue),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const HomePage(),
    const MutunPage(),
    const ProgramsPage(),
    const InstitutionsPage(),
  AdminGate(),
  ];

  final List<String> _titles = [
    'الرئيسية',
    'المتون',
    'البرامج',
    'المؤسسات',
    'لوحة التحكم',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Only pop if there's an open drawer
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.school, color: AppColors.deepBlue);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _titles[_selectedIndex],
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.deepBlue,
          elevation: 5,
        ),

        drawer: Drawer(
          backgroundColor: AppColors.cream,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.deepBlue, AppColors.lightBlue],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(Icons.school, color: AppColors.deepBlue),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'حاضرة مليانة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Amiri',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(_titles.length, (index) {
                return ListTile(
                  leading: Icon(
                    _getDrawerIcon(index),
                    color: AppColors.deepBlue,
                  ),
                  title: Text(
                    _titles[index],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => _onItemTapped(index),
                );
              }),
              const Divider(thickness: 1.2),
              ListTile(
                leading: const Icon(Icons.info_outline, color: AppColors.deepBlue),
                title: const Text('حول الحاضرة'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_phone, color: AppColors.deepBlue),
                title: const Text('اتصل بنا'),
                onTap: () {},
              ),
            ],
          ),
        ),

        body: _pages[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.deepBlue,
          selectedItemColor: AppColors.lightBlue,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'المتون'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'البرامج'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'المؤسسات'),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'لوحة التحكم'),
          ],
        ),
      ),
    );
  }

  IconData _getDrawerIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.menu_book;
      case 2:
        return Icons.school;
      case 3:
        return Icons.account_balance;
      case 4:
        return Icons.dashboard;
      default:
        return Icons.circle;
    }
  }
}
