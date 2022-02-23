import 'package:local_auth/local_auth.dart';

class BiometricsService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
        localizedReason: 'Sign in Plume',
        useErrorDialogs: true,
        stickyAuth: false,
    );
  }
}
