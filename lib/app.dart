import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume/authentication/authentication.dart';
import 'package:plume/packages/apiService/api_service.dart';
import 'package:plume/pages/bioAuthPage/view/bio_auth_page.dart';
import 'package:plume/pages/home/home.dart';
import 'package:plume/pages/login/login.dart';
import 'package:plume/repositories/authentication_repository.dart';
import 'package:plume/routes/routes.dart';
import 'package:plume/splash/splash.dart';
import 'package:plume/theme/plume_theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final ApiService apiService;

  const App({
    Key? key,
    required this.authenticationRepository,
    required this.apiService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ApiService>(create: (_) => apiService),
        ],
        child: RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
            child: AppView(),
          ),
        ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: PlumeTheme.dartTheme,
      routes: RoutesBuilder.routes,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.bioAuth:
                _navigator.pushAndRemoveUntil<void>(
                  BioAuthPage.route(),
                      (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
