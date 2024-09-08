import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqllitte/bloc/userLogic.dart';
import 'package:sqllitte/layout/usertable.dart';
import '../bloc/userState.dart';
import '../share/components/CustomTextFieldEdit.dart';

class UserDetelse extends StatelessWidget {
  static const String routeName = 'User Detelse Screen';
  final Map user;

  UserDetelse({required this.user});

  @override
  Widget build(BuildContext context) {
    String nameU = user['name'];
    String emailU = user['email'];
    String passU = user['password'];

    return BlocProvider(
      create: (context) => UserLogic()..CreateDBTable(),
      child: BlocConsumer<UserLogic, UserState>(
        listener: (context, state) {
          if (state is UpdateUser) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update user')),
            );
          }
        },
        builder: (context, state) {
          final obj = BlocProvider.of<UserLogic>(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Edit Data",
                style: TextStyle(
                  fontFamily: "font1",
                  fontSize: 50,
                  color: Colors.white,
                ),
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
                      initialValue: user['id'].toString(),
                      onPressed: (newData) => user['id'] = newData,
                      lengthLimitFormatter: LengthLimitingTextInputFormatter(60),
                      numericFilterFormatter: FilteringTextInputFormatter.allow(RegExp("")),
                      validator: (value) {},
                      enabled: false,
                    ),
                    const SizedBox(height: 20),

                    CustomTextFieldEdit(
                      keyboardType: TextInputType.name,
                      labelText: "Name",
                      initialValue: user['name'],
                      onPressed: (newData) => nameU = newData,
                      lengthLimitFormatter: LengthLimitingTextInputFormatter(10),
                      numericFilterFormatter: FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      validator: (newData) {
                        if (newData?.isEmpty ?? false) {
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomTextFieldEdit(
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email",
                      initialValue: user['email'],
                      onPressed: (newData) => emailU = newData,
                      lengthLimitFormatter: LengthLimitingTextInputFormatter(80),
                      numericFilterFormatter: FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@.]')),
                      validator: (newData) {
                        if (newData?.isEmpty ?? false) {
                          return "Please Enter Your Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      obscureText: !obj.read,
                      keyboardType: TextInputType.visiblePassword,
                      controller: obj.passController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontFamily: "font1",
                          fontSize: 30,
                          color: Colors.blueGrey,
                        ),
                        contentPadding: EdgeInsets.only(left: 12),
                        suffixIcon: IconButton(
                          onPressed: () {
                            obj.togglePasswordVisibility();
                          },
                          icon: Icon(
                            obj.read
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (newData) {
                        passU = newData;
                      },
                    ),

                    SizedBox(height: 70),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.deepPurpleAccent,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      User(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: MaterialButton(
                            child: Text(
                              "UPDATE",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              try {
                                await obj.updateUser(
                                  id: user['id'],
                                  name: nameU,
                                  email: emailU,
                                  pass: passU,
                                );
                                Navigator.of(context)
                                    .pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        User(),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
