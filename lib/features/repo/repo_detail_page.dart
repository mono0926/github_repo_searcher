import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:github_repo_searcher/common/common.dart';
import 'package:github_repo_searcher/features/repo/widget/circular_icon_tag.dart';
import 'package:github_repo_searcher/theme/themes.dart';
import 'package:intersperse/intersperse.dart';

import 'model/repo.dart';
import 'widget/repo_not_found.dart';

final selectedRepo = StateProvider<Repo?>((ref) => null);

class RepoDetailPage extends ConsumerWidget {
  const RepoDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final repo = ref.watch(selectedRepo);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.repoDetailTitle,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: repo == null
          ? const RepoNotFound()
          : SafeArea(
              child: _Body(repo: repo),
            ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.repo});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.appColors;
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _OwnerInfo(
          avatarUrl: repo.owner.avatarUrl,
          name: repo.owner.login,
        ),
        const Gap(4),
        Text(
          repo.name,
          style: theme.textTheme.titleMedium,
        ),
        Text(
          repo.description,
          style: theme.textTheme.bodySmall,
        ),
        const Gap(16),
        const Divider(),
        const Gap(16),
        ...<Widget>[
          _Row(
            iconData: Icons.language_outlined,
            iconBackgroundColor: appColors.languageIconSurface,
            title: context.l10n.language,
            value: repo.language ?? '---',
          ),
          _Row(
            iconData: Icons.star_outline,
            iconBackgroundColor: appColors.starIconSurface,
            title: context.l10n.star,
            value: l10n.compactCount(repo.stargazersCount),
          ),
          _Row(
            iconData: Icons.visibility_outlined,
            iconBackgroundColor: appColors.watcherIconSurface,
            title: context.l10n.watcher,
            value: l10n.compactCount(repo.watchersCount),
          ),
          _Row(
            iconData: Icons.fork_right_outlined,
            iconBackgroundColor: appColors.forkIconSurface,
            title: context.l10n.fork,
            value: l10n.compactCount(repo.forksCount),
          ),
          _Row(
            iconData: Icons.info_outline,
            iconBackgroundColor: appColors.infoIconSurface,
            title: context.l10n.issue,
            value: l10n.compactCount(repo.openIssuesCount),
          ),
        ].intersperse(const Gap(16)),
      ],
    );
  }
}

class _OwnerInfo extends StatelessWidget {
  const _OwnerInfo({
    required this.avatarUrl,
    required this.name,
  });

  final String avatarUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: Image.network(avatarUrl).image,
            ),
          ),
        ),
        const Gap(6),
        Text(name),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.iconData,
    required this.iconBackgroundColor,
    required this.title,
    required this.value,
  });

  final IconData iconData;
  final Color iconBackgroundColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularIconTag(
          iconBackgroundColor: iconBackgroundColor,
          iconData: iconData,
        ),
        const Gap(8),
        Text(title),
        const Spacer(),
        Text(value),
      ],
    );
  }
}
