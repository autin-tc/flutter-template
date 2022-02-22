import 'package:flutter/material.dart';
import 'package:plume/routes/routes.dart';
import 'package:plume/widgets/drawer/plume_drawer_body.dart';
import 'package:plume/widgets/drawer/plume_drawer_header.dart';

class PlumeDrawer extends StatelessWidget {
  const PlumeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          const PlumeDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil<void>(RoutesBuilder.settings, (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Users'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil<void>(RoutesBuilder.users, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

