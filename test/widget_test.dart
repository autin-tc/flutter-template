// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plume/app.dart';

import 'package:plume/main.dart';
import 'package:plume/packages/apiService/api_service.dart';
import 'package:plume/packages/apiService/native_client.dart';
import 'package:plume/packages/authenticationService/authentication_service.dart';
import 'package:plume/packages/authenticationService/cognito_authentication_client.dart';
import 'package:plume/packages/keyStorageService/key_storage_service.dart';
import 'package:plume/repositories/authentication_repository.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App(
       apiService: ApiService(apiClient: NativeClient()),
        authenticationRepository: AuthenticationRepository(
          authService: AuthenticationService(CognitoAuthenticationClient()),
          keyStorageService: KeyStorageService(),
        ),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
