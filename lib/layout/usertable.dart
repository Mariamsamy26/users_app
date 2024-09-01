import 'package:flutter/material.dart';
import 'package:sqllitte/layout/userDetelse.dart';

import '../network/bataDase.dart';

class user extends StatefulWidget {
  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  UserDataBase u = UserDataBase();
  var t1Controller = TextEditingController();
  var t2Controller = TextEditingController();
  var t3Controller = TextEditingController();
  bool read = false;

  @override
  void initState() {
    super.initState();
    u.CreateDBTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "users Data ",
          style:
          TextStyle(fontFamily: "font1", fontSize: 50, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white54,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: ListView(
            children: [
              u.users.isEmpty
                  ? Card(
                child: ListTile(
                  title: Text("no users now"),
                  leading: CircleAvatar(
                    child: Text("?"),
                  ),
                ),
              )
                  : Container(
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < u.users.length; i++)
                        Card(
                          child: ListTile(
                            title: Text(u.users[i]["name"]),
                            leading: CircleAvatar(
                              child: Text(u.users[i]["id"].toString()),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetelse(u.users[i]),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.teal,
                                    size: 30,
                                  ),
                                ), //edit
                                IconButton(
                                  onPressed: () async {
                                    if (u.db != null) {
                                      int userId = u.users[i]["id"];
                                      print(userId);
                                      await u.deleteUser(id: userId);
                                      u.users = await u.showUsers();
                                      setState(() {});
                                    } else {
                                      print(
                                          "Database not initialized yet.");
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 5,
                color: Colors.blueGrey,
                height: 50,
              ),

              //name
              Text(
                "name",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 20, color: Colors.black),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: t1Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),

              //email
              Text(
                "email",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 20, color: Colors.black),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: t2Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),

              //pass
              Text(
                "password",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 20, color: Colors.black),
              ),
              TextFormField(
                obscureText: read ? false : true,
                keyboardType: TextInputType.name,
                controller: t3Controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          read = !read;
                        });
                      },
                      icon: Icon(
                        read
                            ? Icons.hide_source_outlined
                            : Icons.remove_red_eye_outlined,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),

              Center(
                child: MaterialButton(
                    minWidth: 300,
                    child: Text(
                      "insert",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    color: Colors.lightGreen,
                    onPressed: () async {
                      u.insetuser(
                          name: t1Controller.text,
                          email: t2Controller.text,
                          pass: t3Controller.text);
                      t1Controller.clear();
                      t2Controller.clear();
                      t3Controller.clear();
                      await u.showUsers().then((value) {
                        u.users = value;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(
                              'insert successfully',
                              style: TextStyle(
                                  fontSize: 24, color: Colors.blueGrey),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      });
                    }), //insert
                /*
                    // MaterialButton(
                    //     minWidth: 300,
                    //     child: Text(
                    //       "update",
                    //       style: TextStyle(fontSize: 30, color: Colors.white),
                    //     ),
                    //     color: Colors.teal,
                    //     onPressed: () {
                    //       u.updateUser(
                    //           name: t1Controller.text,
                    //           email: t2Controller.text,
                    //           pass: t3Controller.text,
                    //           id: 1);
                    //     }),
                    //update
                    */
              ),
            ],
          ),
        ),
      ),
    );
  }
}