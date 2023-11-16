import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_flutter_test/components/comment.dart';
import 'package:tada_flutter_test/controllers/post.dart';
import 'package:tada_flutter_test/utils/pixels.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("post_detail".tr), // TODO : i18n
        backgroundColor: Get.theme.colorScheme.inversePrimary,
      ),
      body: Container(
        padding: getMargin(all: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.post.title,
              style: Get.theme.textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(),
                  ),
                  child: Image.asset(
                    "resources/mfdls.png",
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(controller.user.name),
              ],
            ),
            Card(
              elevation: 1,
              margin: getMargin(all: 12),
              child: Text(controller.post.body),
            ),
            Image.asset("resources/july.png"),
            Text(
              "comment_section".tr,
              style: Get.theme.textTheme.titleLarge,
            ),
            Expanded(
              child: Obx(
                () => controller.comments.value.match(
                  onNone: () => const SizedBox.shrink(),
                  onLoading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onError: (e) {
                    print(e);
                    return Text("error_comments".tr);
                  },
                  onSome: (comments) {
                    return ListView.builder(
                      itemBuilder: (_, index) {
                        return CommentWidget(
                          comment: comments[index],
                        );
                      },
                      itemCount: comments.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
