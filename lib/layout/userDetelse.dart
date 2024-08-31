import 'package:flutter/material.dart';
import '../network/bataDase.dart';

class UserDetelse extends StatefulWidget {
  final Map user;

  UserDetelse(this.user, {Key? key}) : super(key: key);

  @override
  State<UserDetelse> createState() => _UserDetelseState();
}

class _UserDetelseState extends State<UserDetelse> {
  final UserDataBase u = UserDataBase();

  @override
  void initState() {
    super.initState();
    u.CreateDBTable();
  }

  // Text(
  // "ID: ${widget.user['id']}",
  // style: TextStyle(fontSize: 30),
  // ),
  // Text(
  // "NAME: ${widget.user['name']}",
  // style: TextStyle(fontSize: 30),
  // ),
  // Text(
  // "EMAIL: ${widget.user['email']}",
  // style: TextStyle(fontSize: 30),
  // ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.user['name']}",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.black12,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: ${widget.user['id']}",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "NAME: ${widget.user['name']}",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "EMAIL: ${widget.user['email']}",
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        minWidth: 300,
                        child: Text(
                          "Delete",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        color: Colors.redAccent,
                        onPressed: () async {
                          if (u.db != null) {
                            print(widget.user['id']);
                            await u.deleteUser(id: widget.user['id']);
                            Navigator.of(context).pop();
                          } else {
                            print("Database not initialized yet.");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
