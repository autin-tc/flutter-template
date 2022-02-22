import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const AuthLayout({Key? key, required this.child, this.title = 'Plume'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
