import 'package:hisia/entities/field.dart';
import 'package:hisia/entities/info.dart';
import 'package:path_provider/path_provider.dart';

import 'package:isar/isar.dart';

import 'entities/user.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db =  openDB();
  }

  Future<int> saveUser(User user) async {
    final isar = await db;
    return isar.writeTxnSync<int>(() => isar.users.putSync(user));
  }

  Future<User?> findUserByEmail(String? email) async {
    final isar = await db;
    return isar.users.filter()
        .optional(
      email != null, // only apply filter if email != null
          (q) => q.emailEqualTo(email!),
    ).findFirst();
  }

  Future<bool> deleteUser(int id) async {
    final isar = await db;
    return  isar.writeTxn(() => isar.users.delete(id)
    );
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if(Isar.instanceNames.isEmpty) {
      return Isar.open([UserSchema, InfoSchema, FieldSchema], inspector:true, directory: dir.path);
    }
    return await Future.value(Isar.getInstance());
  }
}
