import 'package:get/get.dart';
import 'package:tada_flutter_test/models/users.dart';
import 'package:tada_flutter_test/utils/constants.dart';

class Api extends GetConnect {
  Future<Response<List<User>>> getUsers() async {
    return await get(
      "$apiBaseUrl/users",
      decoder: User.listDecoder,
    );
  }
}