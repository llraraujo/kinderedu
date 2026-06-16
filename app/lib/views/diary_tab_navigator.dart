import 'package:flutter/material.dart';
import 'diary_view.dart';

class DiaryTabNavigator extends StatelessWidget {
  const DiaryTabNavigator({Key? key, required this.cpfResponsavel})
    : super(key: key);

  final String cpfResponsavel;

  @override
  Widget build(BuildContext context) {
    // GlobalKey para controlar o Navigator desta aba especificamente
    return Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            // Rota Inicial do Diário (Lista de Anos)
            return DiaryView(cpfResponsavel: cpfResponsavel);
          },
        );
      },
    );
  }
}
