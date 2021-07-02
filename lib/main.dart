import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/usersProvider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user-form.dart';
import 'package:provider/provider.dart';

import 'views/user_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UsersProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            AppRoutes.HOME: (_) => UserList(),
            AppRoutes.USERFORM: (_) => UserForm()
          }),
    );
  }
}
