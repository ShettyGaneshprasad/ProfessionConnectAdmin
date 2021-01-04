import 'package:ProfessionConnect/models/user.dart';
import 'package:ProfessionConnect/screens/wrapper.dart';

import 'package:ProfessionConnect/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:load_toast/load_toast.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: LoadToast(
        child: MaterialApp(
          theme: ThemeData(
              // primaryColor: Color(0xff2FD159),
              ),
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}
