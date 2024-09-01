import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sqllitte/layout/usertable.dart';

import '../share/components/CustomTextFieldEdit.dart';
import '../share/network/bataDase.dart';

class UserDetelse extends StatefulWidget {
  static const String routeName = 'User Detelse Screen';
  final Map user;

  UserDetelse(this.user, {Key? key}) : super(key: key);

  @override
  State<UserDetelse> createState() => _UserDetelseState();
}

class _UserDetelseState extends State<UserDetelse> {
  final UserDataBase u = UserDataBase();
  var passController = TextEditingController();
  bool read = false;

  @override
  void initState() {
    super.initState();
    u.CreateDBTable();
    passController.text = widget.user['password'];
  }

  @override
  Widget build(BuildContext context) {
    String nameU = widget.user['name'];
    String emailU = widget.user['email'];
    String passU = widget.user['password'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "edit Data ",
          style:
              TextStyle(fontFamily: "font1", fontSize: 50, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldEdit(
                keyboardType: TextInputType.number,
                labelText: 'ID',
                initialValue: widget.user['id'].toString(),
                onPressed: (newData) => widget.user['id'],
                lengthLimitFormatter: LengthLimitingTextInputFormatter(60),
                numericFilterFormatter:
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@.]')),
                validator: (value) {},
                enabled: false,
              ), //id
              const SizedBox(height: 20),

              CustomTextFieldEdit(
                keyboardType: TextInputType.name,
                labelText: "name",
                initialValue: widget.user['name'],
                onPressed: (newData) => {nameU = newData},
                lengthLimitFormatter: LengthLimitingTextInputFormatter(10),
                numericFilterFormatter:
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                validator: (newData) {
                  if (newData?.isEmpty ?? false) {
                    return "Please Enter Your Name";
                  }
                  return null;
                },
              ), //name
              const SizedBox(height: 20),

              CustomTextFieldEdit(
                keyboardType: TextInputType.name,
                labelText: "email",
                initialValue: widget.user['email'],
                onPressed: (newData) => emailU = newData,
                lengthLimitFormatter: LengthLimitingTextInputFormatter(80),
                numericFilterFormatter:
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                validator: (newData) {
                  if (newData?.isEmpty ?? false) {
                    return "Please Enter Your Name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                obscureText: read ? false : true,
                keyboardType: TextInputType.name,
                controller: passController,
                decoration: InputDecoration(

                  label: Text(
                    "password",
                    style: TextStyle(
                        fontFamily: "font1", fontSize: 30, color: Colors.blueGrey),
                  ),
                    contentPadding: EdgeInsets.only(left: 12),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          read = !read;
                        });
                      },
                      icon: Icon(
                        read
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onChanged: (newData) {
                  passU = newData;
                },
              ),

              SizedBox(
                height: 70,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      child: Text(
                        "cancel",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      color: Colors.deepPurpleAccent,
                      onPressed: ()  {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                user(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      child: Text(
                        "UPDATE",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      color: Colors.orangeAccent,
                      onPressed: () async {
                        try {
                          await u.updateUser(
                            id: widget.user['id'],
                            name: nameU,
                            email: emailU,
                            pass: passU,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  user(),
                            ),
                          );

                        } catch (e) {
                          print('Error updating user: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update user'),
                            ),
                          );
                        }
                      },
                    ),
                  ), /////
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
