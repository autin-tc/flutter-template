import 'package:flutter/material.dart';
import 'package:plume/pages/confirm/view/confirm_page.dart';
import 'package:plume/pages/home/home.dart';
import 'package:plume/pages/login/login.dart';
import 'package:plume/pages/settings/view/settings_page.dart';
import 'package:plume/pages/signUp/sign_up.dart';
import 'package:plume/pages/users/view/users_page.dart';

class RoutesBuilder {
  static const signUp = '/signUp';
  static const start = '/start';
  static const home = '/home';
  static const settings = '/settings';
  static const signIn = 'signIn';
  static const confirm = '/confirm';
  static const users = '/users';

  static Map<String, WidgetBuilder> routes =  {
    RoutesBuilder.signUp: (ctx) => const SignUpPage(),
    RoutesBuilder.signIn: (ctx) => const LoginPage(),
    RoutesBuilder.confirm: (ctx) => const ConfirmPage(),
    RoutesBuilder.home: (ctx) => const HomePage(),
    RoutesBuilder.settings: (ctx) => const SettingsPage(),
    RoutesBuilder.users: (ctx) => const UsersPage(),
  };
}
