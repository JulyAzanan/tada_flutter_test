import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tada_flutter_test/models/comments.dart';
import 'package:tada_flutter_test/utils/pixels.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: getMargin(all: 4),
      child: Padding(
        padding: getMargin(all: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.name,
              style: Get.theme.textTheme.titleMedium,
            ),
            Text(
              comment.email,
              style: Get.theme.textTheme.labelSmall!.copyWith(
                color: Colors.grey,
              ),
            ),
            Text(
              comment.body,
              style: Get.theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
