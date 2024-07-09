// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables, unused_element, deprecated_member_use, non_constant_identifier_names
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
