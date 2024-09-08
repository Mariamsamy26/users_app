import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/userLogic.dart';
import 'layout/usertable.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserLogic>(
          create: (_) => UserLogic(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: User.routeName, // Make sure this is correctly named
        routes: {
          User.routeName: (context) => User(),
        },
      ),
    ),
  );
}
