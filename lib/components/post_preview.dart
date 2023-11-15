import 'package:flutter/material.dart';
import 'package:tada_flutter_test/models/posts.dart';
import 'package:tada_flutter_test/models/users.dart';
import 'package:tada_flutter_test/utils/pixels.dart';

class PostPreview extends StatelessWidget {
  final Post post;
  final User user;
  final Future<void> Function(int) onDismissed;

  const PostPreview({
    required this.post,
    required this.user,
    required super.key,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      onDismissed: (_) => onDismissed(post.id),
      child: Card(
        borderOnForeground: true,
        color: Theme.of(context).colorScheme.surface,
        margin: getMargin(all: 8),
        elevation: 1.0,
        child: Container(
          padding: getMargin(all: 4),
          height: getSize(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                user.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
