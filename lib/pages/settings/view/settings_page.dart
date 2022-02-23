import 'package:flutter/material.dart';
import 'package:plume/layouts/main_layout.dart';
import 'package:plume/packages/keyStorageService/key_storage_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsState createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  final _storage = KeyStorageService();
  bool bio = false;

  Future<void> setBio() async {
    final isExist = await _storage.containsItem('bio');
    setState(() {
      bio = isExist ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    setBio();
  }

  void onChanged(bool event) async {
    event ? await _storage.setItem('bio', 'true') : await _storage.deleteItem('bio');

    setState(() {
      bio = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'Settings',
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Biometric', style: TextStyle(color: Colors.black),),
                Switch(value: bio, onChanged: onChanged),
              ],
            ),
          ],
        )
    );
  }
}
