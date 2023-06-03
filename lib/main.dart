import 'dart:async';
import 'dart:developer';

import 'package:emergencyappui/data/constants.dart';
import 'package:emergencyappui/providers/providers.dart';
import 'package:emergencyappui/routes/dashboard.dart';
import 'package:emergencyappui/routes/error_page.dart';
import 'package:extensionresoft/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then(appCallback);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var state = ref.watch(themeProvider.select((value) => value));
        log(state.toString());
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: Constant.appName,
          themeMode: condition(state, ThemeMode.light, ThemeMode.dark),
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            fontFamily: FontResoft.inter,
            package: FontResoft.package,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            textTheme: const TextTheme(titleMedium: TextStyle(fontWeight: FontWeight.bold)),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
            fontFamily: FontResoft.inter,
            package: FontResoft.package,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            textTheme: const TextTheme(titleMedium: TextStyle(fontWeight: FontWeight.bold)),
          ),
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        );
      },
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      route(Constant.root, const Dashboard()),
      route(Constant.dashboard, const Dashboard()),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}

/// Creates a GoRoute object.
///
/// The `route()` function takes two arguments:
/// the `path` of the `route` and the widget to render for the route.
///
/// *Parameters:*
///
///   `path`: The path of the route.
///
///   `route`: The widget to render for the route.
GoRoute route(String path, Widget route) {
  return GoRoute(
    path: path,
    builder: (BuildContext context, GoRouterState state) => route,
  );
}

FutureOr appCallback(void value) {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
