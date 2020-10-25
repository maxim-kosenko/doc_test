import 'package:doc_test/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'doc_schedule/doc_schedule..dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: RaisedButton(
          child: Text(S.of(context).press),
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (_, controller) => DocScheduleScreen(),
            );
          },
        ),
      ),
    );
  }
}
