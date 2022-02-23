import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plume/routes/routes.dart';
import 'package:plume/theme/plume_colors.dart';
import 'package:plume/utils/picture_builder.dart';
import 'package:plume/widgets/drawer/plume_drawer_body.dart';
import 'package:plume/widgets/drawer/plume_drawer_header.dart';

class PlumeDrawer extends StatelessWidget {
  const PlumeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const PlumeDrawerHeader(),
          ListTile(
            minLeadingWidth: 16,
            leading: SvgPicture.asset(
              SvgBuilder.settings,
              width: 20,
              color: PlumeColors.background,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil<void>(RoutesBuilder.settings, (route) => false);
            },
          ),
          ListTile(
            minLeadingWidth: 16,
            leading: SvgPicture.asset(
              SvgBuilder.account,
              width: 20,
              color: PlumeColors.background,
            ),
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

