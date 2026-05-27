import 'package:flutter/material.dart';
import 'dashboard_view.dart';
import 'diary_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  // Lista que mapeia o índice da aba para a respectiva View
  final List<Widget> _views = [
    const DashboardView(), // 0: Hoje
    const DiaryView(),     // 1: Diário
    
    // Placeholders para as próximas telas que você for desenvolver
    const Center(child: Text('Tela de Chat em construção')),   // 2: Chat
    const Center(child: Text('Tela de Fotos em construção')),  // 3: Fotos
    const Center(child: Text('Tela de Perfil em construção')), // 4: Perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O segredo está aqui: o body muda dinamicamente conforme o índice
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
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
          label: 'Hoje'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined), 
          label: 'Diário'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline), 
          label: 'Chat'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library_outlined), 
          label: 'Fotos'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), 
          label: 'Perfil'
        ),
      ],
    );
  }
}