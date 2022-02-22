import 'package:flutter/material.dart';

class PlumeDrawerHeader extends StatelessWidget {
  const PlumeDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 48.0,
              backgroundColor: Colors.brown.shade800,
              child: const Text('AU'),
            ),
            const SizedBox(height: 8),
            const Text('1 Pat', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            const Text('he/him', style: TextStyle(color: Colors.white60)),
            const Divider(
              thickness: 1,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
