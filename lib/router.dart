import 'package:github_repo_searcher/features/base/base_page.dart';
import 'package:github_repo_searcher/features/repo/repo_detail_page.dart';
import 'package:github_repo_searcher/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences_debugger/shared_preferences_debugger.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const BasePage(),
      routes: [
        GoRoute(
          name: 'repo_detail',
          path: 'repos/:repoId',
          builder: (context, state) {
            final repoId = state.params['repoId'];
            logger.fine('repoId: $repoId');
            return const RepoDetailPage();
          },
        ),
        GoRoute(
          name: 'shared_preferences_debug',
          path: 'debug/shared_preferences',
          builder: (context, state) => const SharedPreferencesDebugPage(),
        )
      ],
    ),
  ],
);
