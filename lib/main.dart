import 'package:flutter/material.dart';

import 'layout/usertable.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: user.routeName,
    routes: {
      user.routeName: (c) => user(),
    },
  )
  );
}
