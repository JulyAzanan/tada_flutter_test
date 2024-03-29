import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_flutter_test/components/post_preview.dart';
import 'package:tada_flutter_test/controllers/home.dart';
import 'package:tada_flutter_test/routes/router.dart';
import 'package:tada_flutter_test/utils/pixels.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("all_posts".tr),
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Get.updateLocale(controller.locale.languageCode == "fr"
                  ? const Locale("en", "US")
                  : const Locale("fr", "FR"));
              controller.locale = controller.locale.languageCode == "fr"
                  ? const Locale("en", "US")
                  : const Locale("fr", "FR");
            },
            icon: const Icon(Icons.flag),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await controller.addPost(),
        child: const Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: FocusManager.instance.primaryFocus
            ?.unfocus, // Closing keyboard if opened when clicked outside
        child: Container(
          margin: getMargin(left: 12, right: 12),
          child: Column(
            children: [
              Container(
                padding: getMargin(
                  left: 8,
                  right: 8,
                ),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(getSize(20))),
                child: TextFormField(
                  controller: controller.textController,
                  onChanged: (text) {
                    controller.searchText.value = text;
                    controller.searchText.refresh();
                  },
                  decoration: InputDecoration(
                    hintText: "search".tr,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => controller.posts.value.match(
                    onNone: () => const SizedBox.shrink(),
                    onLoading: () =>
                        const Center(child: CircularProgressIndicator()),
                    onError: (_) => Center(
                      child: Text("error_posts".tr),
                    ),
                    onSome: (posts) {
                      return controller.users.value.match(
                        onNone: () => const SizedBox.shrink(),
                        onLoading: () =>
                            const Center(child: CircularProgressIndicator()),
                        onError: (_) => Center(
                          child: Text("error_users".tr),
                        ),
                        onSome: (users) {
                          final filteredPosts = controller.filterPost(
                              posts, users, controller.searchText.value);

                          return ListView.builder(
                            itemBuilder: (_, index) {
                              return PostPreview(
                                key: ValueKey(filteredPosts[index].id),
                                onDismissed: controller.deletePost,
                                post: filteredPosts[index],
                                onTap: (post, user) {
                                  Get.toNamed(
                                    AppRoutes.post,
                                    arguments: {"post": post, "user": user},
                                  );
                                },
                                user: users.firstWhere(
                                  (user) =>
                                      user.id == filteredPosts[index].userId,
                                ),
                              );
                            },
                            itemCount: filteredPosts.length,
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
