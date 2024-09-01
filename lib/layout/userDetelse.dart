import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../share/components/CustomTextFieldEdit.dart';
import '../share/network/bataDase.dart';

class UserDetelse extends StatefulWidget {
  final Map user;

  UserDetelse(this.user, {Key? key}) : super(key: key);

  @override
  State<UserDetelse> createState() => _UserDetelseState();
}

class _UserDetelseState extends State<UserDetelse> {
  final UserDataBase u = UserDataBase();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool read = false;

  @override
  void initState() {
    super.initState();
    u.CreateDBTable();
    nameController.text = widget.user['name'];
    emailController.text = widget.user['email'];
    passController.text = widget.user['password'];
  }

  @override
  Widget build(BuildContext context) {
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
                numericFilterFormatter: FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9@.]')),
                validator: (value) {},
                enabled: false, // Set to false to make the field read-only and text bold
              ), //id
              const SizedBox(height: 20),

              CustomTextFieldEdit(
                keyboardType: TextInputType.name,
                labelText: "name",
                initialValue: widget.user['name'],
                onPressed: (newData) => widget.user['name'] = newData,
                lengthLimitFormatter: LengthLimitingTextInputFormatter(10),
                numericFilterFormatter:
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                validator: (newData) {
                  if (newData?.isEmpty ?? false) {
                    return "Please Enter Your Name";
                  }
                  return null;
                },
              ),//name
              const SizedBox(height: 20),

              CustomTextFieldEdit(
                keyboardType: TextInputType.name,
                labelText: "email",
                initialValue: widget.user['email'],
                onPressed: (newData) => widget.user['email'] = newData,
                lengthLimitFormatter: LengthLimitingTextInputFormatter(10),
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

              const Text(
                "password",
                style: TextStyle(
                    fontFamily: "font1", fontSize: 30, color: Colors.blueGrey),
              ),
              TextFormField(
                obscureText: read ? false : true,
                keyboardType: TextInputType.name,
                controller: passController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          read = !read;
                        });
                      },
                      icon: Icon(
                        read ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),

              SizedBox(height: 70,),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 300,
                      child: Text(
                        "UPDATE",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      color: Colors.orangeAccent,
                      onPressed: () async {
                        await u.updateUser(
                            id: widget.user['id'],
                            name: nameController.text,
                            email: emailController.text,
                            pass: passController.text);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User updated successfully'),
                          ),
                        );
                      },

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
