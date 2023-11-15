import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_flutter_test/components/post_preview.dart';
import 'package:tada_flutter_test/controllers/home.dart';
import 'package:tada_flutter_test/utils/pixels.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("all_posts".tr), // TODO : i18n
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GestureDetector(
        onTap: FocusManager.instance.primaryFocus
            ?.unfocus, // Closing keyboard if opened when clicked outside
        child: Container(
          margin: getMargin(left: 12, right: 12),
          child: Column(
            children: [
              const SizedBox.shrink(), // TODO: Search area
              Expanded(
                child: Obx(
                  () => controller.posts.value.match(
                    onNone: () => const SizedBox.shrink(),
                    onLoading: () =>
                        const Center(child: CircularProgressIndicator()),
                    onError: (_) => Center(
                      child: Text("error_posts".tr), // TODO : i18n
                    ),
                    onSome: (posts) {
                      return controller.users.value.match(
                        onNone: () => const SizedBox.shrink(),
                        onLoading: () =>
                            const Center(child: CircularProgressIndicator()),
                        onError: (_) => Center(
                          child: Text("error_users".tr), // TODO : i18n
                        ),
                        onSome: (users) {
                          return ListView.builder(
                            itemBuilder: (_, index) {
                              return PostPreview(
                                key: ValueKey(index),
                                onDismissed: controller.deletePost,
                                post: posts[index],
                                user: users.firstWhere(
                                  (user) => user.id == posts[index].userId,
                                ),
                              );
                            },
                            itemCount: posts.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
