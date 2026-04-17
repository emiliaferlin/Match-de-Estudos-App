import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/match/view/match_view.dart';
import 'package:match_estudos_app/src/features/perfil/view/perfil_view.dart';
import 'package:match_estudos_app/src/features/sair/view/sair_view.dart';
import 'package:match_estudos_app/src/features/sessao/view/sessao_view.dart';

class NavigattonBarViews extends StatefulWidget {
  final int? indexView;
  const NavigattonBarViews({super.key, this.indexView});

  @override
  State<NavigattonBarViews> createState() => _NavigattonBarViewsState();
}

class _NavigattonBarViewsState extends State<NavigattonBarViews> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.indexView ?? 0;

    super.initState();
  }

  final List<Widget> pages = const [
    PerfilView(),
    SessaoView(),
    MatchView(),
    SairView(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.green.withOpacity(0.15),
          shadowColor: Colors.green.withOpacity(0.15),
          labelTextStyle: MaterialStateProperty.all(
            TextStyleMatchEstudo.bodySM(color: Colors.black),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemTapped,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.people_outline_outlined),
              label: "Perfis",
            ),
            NavigationDestination(
              icon: Icon(Icons.book_outlined),
              label: "Sessões",
            ),
            NavigationDestination(
              icon: Icon(Icons.handshake_outlined),
              label: "Matchs",
            ),
            NavigationDestination(icon: Icon(Icons.logout), label: "Sair"),
          ],
        ),
      ),
    );
  }
}
