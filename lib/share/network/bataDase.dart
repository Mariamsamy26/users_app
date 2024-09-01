import 'package:sqflite/sqflite.dart';

class UserDataBase {
  late Database db;
  List<Map> users = [];

  CreateDBTable() async {
    db = await openDatabase(
      "u.db",
      version: 1,
      onCreate: (d, i) async {
        await d.execute("create table user (id integer primary key,"
            "name text , password text , email text)");
      },
      onOpen: (b) {
        print("open");
      },
    );
    users = await showUsers();
    print(users);
  }

  insetuser({
    required String name,
    required String email,
    required String pass,
  }) {
    db.transaction((txn) async {
      await txn
          .rawInsert("INSERT INTO user(name, email, password) "
              "values('$name', '$email', '$pass')")
          .then((V) {
        return print("insetuser row $V");
      });
    });
  }

  deleteUser({required int id}) {
    db.rawDelete('DELETE FROM user WHERE id = $id').then((V) {
      return print("delete row ");
    });
  }

  updateUser({
    required int id,
    required String name,
    required String email,
    required String pass,
  }) {
    db.rawUpdate(
        'UPDATE user SET name = ? , email = ?, password = ?  WHERE id = ?',
        [name, email, pass, id] //هدخله القيم على طول بدل ما ادي القيم كل مره
        ).then((V) {
      return print("update user row $V");
    });
  }

  Future<List<Map>> showUsers() async {
    return await db.rawQuery('SELECT * FROM user');
  }
}
