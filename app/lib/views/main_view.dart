import 'package:flutter/material.dart';
import 'package:kinderedu/models/login_model.dart';
import 'package:kinderedu/views/diary_tab_navigator.dart';
import 'package:kinderedu/views/photo_tab_navigator.dart';
import 'package:kinderedu/views/profile_view.dart';
import 'dashboard_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  String get cpf => widget.user.cpf;

  late final List<Widget> _views = [
    DashboardView(cpf: cpf),
    DiaryTabNavigator(cpfResponsavel: cpf),
    PhotoTabNavigator(cpfResponsavel: cpf),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _views),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7B3AED),
      unselectedItemColor: Colors.grey[400],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Hoje',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Diario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library_outlined),
          label: 'Fotos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
