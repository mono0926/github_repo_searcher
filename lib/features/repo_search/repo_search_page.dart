import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repo_searcher/features/pagination/model/paging.dart';
import 'package:github_repo_searcher/features/repo_search/model/repo.dart';
import 'package:github_repo_searcher/features/repo_search/repo_search_repository.dart';

class RepoSearchPage extends ConsumerWidget {
  const RepoSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueBuilder<Paging<Repo>>(
      value: ref.watch(RepoSearchRepository.search),
      builder: (paging) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('totalCount: ${paging.totalCount}'),
            Text('itemsLength: ${paging.items.length}'),
          ],
        ),
      ),
    );
  }
}

class AsyncValueBuilder<T> extends StatelessWidget {
  const AsyncValueBuilder({
    super.key,
    required this.value,
    required this.builder,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      data: builder,
    );
  }
}
