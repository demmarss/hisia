
import 'package:hisia/entities/field.dart';
import 'package:hisia/entities/info.dart';
import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  String? email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;

  @Backlink(to: "users")
  final infos = IsarLinks<Info>();

  @Backlink(to: "users")
  final fields = IsarLinks<Field>();
}
