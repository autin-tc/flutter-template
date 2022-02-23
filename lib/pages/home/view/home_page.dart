import 'package:flutter/material.dart';
import 'package:plume/layouts/main_layout.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'Home',
        child: Center(
          child: Column(
            children: const <Widget>[
              Text(
                'Welcome back!',
                style: TextStyle(
                    color: Color(0xFF836554),
                    fontSize: 24.0
                )
              ),
              SizedBox(height: 16.0,),
              Text(
                'If you need anything, send a message to your care team from the message center located in the main menu. We\'re here to help.',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        )
    );
  }
}
