import 'package:flutter/material.dart';
import 'package:kinderedu/views/photos_view.dart';

class PhotoTabNavigator extends StatelessWidget {
  const PhotoTabNavigator({Key? key, required this.cpfResponsavel})
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
            return PhotosView(cpfResponsavel: cpfResponsavel);
          },
        );
      },
    );
  }
}
