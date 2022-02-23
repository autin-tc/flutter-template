import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plume/authentication/authentication.dart';
import 'package:plume/routes/routes.dart';
import 'package:plume/utils/picture_builder.dart';
import 'package:plume/widgets/drawer/plume_drawer.dart';
import 'package:provider/provider.dart';

class BottomTabNavigatorArgs {
  final int currentIndex;
  BottomTabNavigatorArgs({required this.currentIndex});
}

class BottomTabNavigator {
  final int id;
  final Widget icon;
  final String lable;
  const BottomTabNavigator({required this.id, required this.lable, required this.icon});
}

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  const MainLayout({Key? key, required this.child, required this.title}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<BottomTabNavigator> bottomTabNavigator = [
    const BottomTabNavigator(id: 1, lable: 'Home', icon: Icon(Icons.home)),
    const BottomTabNavigator(id: 2, lable: 'Settings', icon: Icon(Icons.settings)),
    const BottomTabNavigator(id: 3, lable: 'Users', icon: Icon(Icons.person)),
  ];

  handlerClick(int item, BuildContext context) {
    if (item == 1) {
      context
        .read<AuthenticationBloc>()
        .add(AuthenticationLogoutRequested());
    }
  }

  _onItemTapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.of(context).pushNamedAndRemoveUntil(RoutesBuilder.home, (route) => false, arguments: BottomTabNavigatorArgs(currentIndex: index));
    } else if (index == 1) {
      Navigator.of(context).pushNamedAndRemoveUntil(RoutesBuilder.settings, (route) => false, arguments: BottomTabNavigatorArgs(currentIndex: index));
    } else if (index == 2) {
      Navigator.of(context).pushNamedAndRemoveUntil(RoutesBuilder.users, (route) => false, arguments: BottomTabNavigatorArgs(currentIndex: index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final curIndex = ModalRoute.of(context)?.settings.arguments != null
        ? (ModalRoute.of(context)?.settings.arguments as BottomTabNavigatorArgs).currentIndex
        : 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: GestureDetector(
          onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(RoutesBuilder.home, (route) => false),
          // child: logo
          child: SvgPicture.asset(SvgBuilder.logo, width: 100,),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 1,
                  child: Text('Sign out'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Action'),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              size: 24,
              color: Colors.white
            ),
            onSelected: (int item) => handlerClick(item, context)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabNavigator.map((item) {
          return BottomNavigationBarItem(
              icon: item.icon,
              label: item.lable,
            );
        }).toList(),
        currentIndex: curIndex,
        selectedItemColor: Colors.white,
        onTap: (int item) => _onItemTapped(item, context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const PlumeDrawer(),
    );
  }
}
