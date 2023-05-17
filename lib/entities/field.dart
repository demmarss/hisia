
import 'package:hisia/entities/user.dart';
import 'package:isar/isar.dart';

part 'field.g.dart';

@collection
class Field {
  Id id = Isar.autoIncrement;
  late String? name;
  late String? value;
  late String? type;
  late DateTime? createdAt;
  int? createdBy;
  late DateTime? updatedAt;
  int? updatedBy;

  final users = IsarLinks<User>();
}
