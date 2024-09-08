import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllitte/bloc/userState.dart';


class UserLogic extends Cubit<UserState> {
  UserLogic() : super(InitUser());

  late Database db;
  List<Map> users = [];
  bool read = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  // String nameU = user['name'];
  // String emailU = user['email'];
  // String passU = user['password'];

  CreateDBTable() async {
    await openDatabase(
      "u.db",
      version: 1,
      onCreate: (d, i) async {
        await d.execute(
            "CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, password TEXT, email TEXT)");
      },
      onOpen: (db) {
        print("Database opened");
      },
    ).then((database) {
      db = database;
      emit(CreatetUser());
      return showUsers();
    }).then((value) {
      users = value;
      print("Users: $users");
      emit(ShowUser());
    }).catchError((error) {
      print("Error in CreateDBTable: $error");
    });
  }


  insetuser({
    required String name,
    required String email,
    required String pass,
  }) async {
  await db.transaction((txn) async {
       txn.rawInsert("INSERT INTO user(name, email, password) "
          "values('$name', '$email', '$pass')")
          .then((V) {
        print("insetuser row $V");
        emit(IsertUser());
        showUsers().then((value) {
          users=value;
          print(users);
          emit(ShowUser());
        });
      });
    });
  }

  deleteUser({required int id})async
  {
    await db.rawDelete("delete from user where id = $id").then((value){
      print("User Deleted $value");
      emit(DeletUser());
      showUsers().then((value){
        users=value;
        emit(ShowUser());
      });
    });

  }

  updateUser({
    required int id,
    required String name,
    required String email,
    required String pass,
  }) async {
    await db.rawUpdate(
        'UPDATE user SET name = ? , email = ?, password = ?  WHERE id = ?',
        [name, email, pass, id]
    ).then((V) {
      print("update user row $V");
      emit(UpdateUser());
      showUsers().then((value) {
        users=value;
        print(users);
        emit(ShowUser());
      });
    });
  }

  Future<List<Map>> showUsers() async {
    return await db.rawQuery('SELECT * FROM user');
  }

  void togglePasswordVisibility() {
    read = !read;
    emit(TogglePasswordVisibility());
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    emit(CreatetUser());
  }
}
