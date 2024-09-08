import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqllitte/bloc/userState.dart';
import 'package:sqllitte/layout/userDetelse.dart';

import '../bloc/userLogic.dart';

class User extends StatelessWidget {
  static const String routeName = 'User taber Screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserLogic()..CreateDBTable(),
        child: BlocConsumer<UserLogic, UserState>(
          listener: (context, state) {
            if (state is IsertUser) {
              print("State Insert ");
            }
            if (state is CreatetUser) {
              print("State Create ");
            }
            if (state is ShowUser) {
              print("State Show ");
            }
          },
          builder: (context, state) {
            UserLogic obj = BlocProvider.of(context);

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "users Data ",
                  style: TextStyle(
                      fontFamily: "font1", fontSize: 50, color: Colors.white),
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
                      obj.users.isEmpty
                          ? const Card(
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
                                    for (int i = 0; i < obj.users.length; i++)
                                      Card(
                                        child: ListTile(
                                          title: Text(
                                            obj.users[i]["name"],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          leading: CircleAvatar(
                                            child: Text(
                                                obj.users[i]["id"].toString()),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserDetelse(user: obj.users[i]),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.teal,
                                                  size: 30,
                                                ),
                                              ), //edit
                                              IconButton(
                                                onPressed: () async {
                                                  if (obj.db != null) {
                                                    int userId =
                                                        obj.users[i]["id"];
                                                    print(userId);
                                                    await obj.deleteUser(
                                                        id: userId);
                                                    obj.users =
                                                        await obj.showUsers();
                                                  } else {
                                                    print(
                                                        "Database not initialized yet.");
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),//delet
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

                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: obj.nameController,
                        decoration: InputDecoration(
                            label: const Text(
                              "name",
                              style: TextStyle(
                                  fontFamily: "font1",
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ), //name
                      const SizedBox(height: 20), //email

                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: obj.emailController,
                        decoration: InputDecoration(
                            label: const Text(
                              "email",
                              style: TextStyle(
                                  fontFamily: "font1",
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ), //email
                      const SizedBox(height: 20), //pass

                      TextFormField(
                        obscureText: obj.read ? false : true,
                        keyboardType: TextInputType.name,
                        controller: obj.passController,
                        decoration: InputDecoration(
                            label: const Text(
                              "password",
                              style: TextStyle(
                                  fontFamily: "font1",
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.only(left: 12),
                            suffix: IconButton(
                              onPressed: () {
                                obj.togglePasswordVisibility();
                              },
                              icon: Icon(
                                obj.read
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ), //pass
                      const SizedBox(height: 20),

                      Center(
                        child: MaterialButton(
                            minWidth: 300,
                            child: Text(
                              "insert",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            color: Colors.lightGreen,
                            onPressed: () async {
                              if (obj.db != null) {
                                await obj.insetuser(
                                  name: obj.nameController.text,
                                  email: obj.emailController.text,
                                  pass: obj.passController.text,
                                );
                                print("donee");
                                obj.clearFields();
                                obj.CreateDBTable();
                              } else {
                                print("Database not initialized yet.");
                              }
                            }), //insert
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
