import 'package:local_auth/local_auth.dart';

class BiometricsService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        useErrorDialogs: true,
        stickyAuth: true
    );
  }
}
