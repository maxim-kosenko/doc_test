import 'package:doc_test/feature/screens/home.dart';
import 'package:doc_test/injection/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'generated/l10n.dart';

final env = Environment.dev;

final logger = Logger(
  filter: env == Environment.dev ? ProductionFilter() : DevelopmentFilter(),
);

final dioLogger = Logger(
  filter: env == Environment.dev ? ProductionFilter() : DevelopmentFilter(),
  printer: SimplePrinter(),
);


void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final Future<void> _injectionFuture;

  App({Key key})
      : _injectionFuture = configureInjection(env),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _injectionFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        } else {
          return DocTestApp();
        }
      },
    );
  }
}

class DocTestApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return CupertinoApp(
     home: HomeScreen(),
     localizationsDelegates: [
       S.delegate,
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
     ],
     supportedLocales: S.delegate.supportedLocales,
   );
  }

}

