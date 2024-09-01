import 'package:flutter/material.dart';

import 'bataDase.dart';

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
        title: Text("Data base",style: TextStyle(
            fontFamily: "font1",
            fontSize: 50,
            color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white54,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30,20,30,10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "name",
                  style: TextStyle(
                      fontFamily: "font1",
                      fontSize: 20,
                      color: Colors.black),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: t1Controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(height: 20,),

                Text(
                  "email",
                  style: TextStyle(
                      fontFamily: "font1",
                      fontSize: 20,
                      color: Colors.black),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: t2Controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(height: 20,),

                Text(
                  "password",
                  style: TextStyle(
                      fontFamily: "font1",
                      fontSize: 20,
                      color: Colors.black),
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
                SizedBox(height: 20,),

                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                          minWidth: 300,
                          child: Text(
                            "insert",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          color: Colors.lightGreen,
                          onPressed: () {
                            u.insetuser(
                                name: t1Controller.text,
                                email: t2Controller.text,
                                pass: t3Controller.text);
                          }), //insert
                      MaterialButton(
                          minWidth: 300,
                          child: Text(
                            "delet",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          color: Colors.redAccent,
                          onPressed: () {
                            u.deleteUser(id: 1);
                          }), //delete
                      MaterialButton(
                          minWidth: 300,
                          child: Text(
                            "update",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          color: Colors.teal,
                          onPressed: () {
                            u.updateUser(
                                name: t1Controller.text,
                                email: t2Controller.text,
                                pass: t3Controller.text,
                                id: 1);
                          }), //update
                      MaterialButton(
                          minWidth: 300,
                          child: Text(
                            "show",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          color: Colors.orangeAccent,
                          onPressed: () async {
                            print(await u.showUsers());
                          }), //show
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
