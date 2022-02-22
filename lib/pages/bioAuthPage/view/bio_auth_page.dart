import 'package:flutter/material.dart';
import 'package:plume/layouts/auth_layout.dart';
import 'package:plume/packages/biometricsService/biometrics_service.dart';
import 'package:plume/routes/routes.dart';

class BioAuthPage extends StatefulWidget {
  final String title = 'Bio Auth';

  const BioAuthPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BioAuthPage());
  }

  @override
  _BioSignInState createState() => _BioSignInState();
}

class _BioSignInState extends State<BioAuthPage> {
  final BiometricsService _bioService = BiometricsService();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var isAuth = await _bioService.authenticate();
    if (isAuth) {
      Navigator.pushNamedAndRemoveUntil(context, RoutesBuilder.home, (route) => false);
    }
  }

  void handlerOpenDialog() async {
    var isAuth = await _bioService.authenticate();
    if (isAuth) {
      Navigator.pushNamed(context, RoutesBuilder.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: widget.title,
      child: GestureDetector(
        onTap: handlerOpenDialog,
        child: const Text(
            'Click to open bio auth dialog',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}
