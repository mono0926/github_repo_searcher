import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repo_searcher/features/api/api_client.dart';
import 'package:github_repo_searcher/features/pagination/model/paging.dart';
import 'package:github_repo_searcher/features/repo/model/repo.dart';

import '../api/query_param.dart';
import 'repo_search_bar/repo_search_bar.dart';

final searchRepoProvider = FutureProvider((ref) {
  final query = ref.watch(repoSearchBarController);
  return ref.watch(apiClient).get<Paging<Repo>>(
        path: '/search/repositories',
        queryParam: QueryParam(
          q: query,
        ),
        decoder: (json) => Paging.fromJson(json, Repo.fromJson),
      );
});
