import 'package:get/get.dart';
import 'package:tada_flutter_test/api/api.dart';
import 'package:tada_flutter_test/models/comments.dart';
import 'package:tada_flutter_test/utils/handler.dart';
import 'package:tada_flutter_test/utils/options.dart';

class PostService {
  static Future<bool> getCommentsOf(
      int id, Rx<Options<List<Comment>>> Function()? accessor) async {
    Api api = Get.find();

    return await Handler.apiCallHandler(
      apiMethod: () async => api.getAllCommentsOf(id),
      accessor: accessor,
    );
  }
}
