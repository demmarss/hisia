
import 'package:hisia/entities/user.dart';
import 'package:isar/isar.dart';

part 'info.g.dart';

@collection
class Info {
  Id id = Isar.autoIncrement;
  late String? title;
  late DateTime? createdAt;
  int? createdBy;
  late DateTime? updatedAt;
  int? updatedBy;

  final users = IsarLinks<User>();

}
