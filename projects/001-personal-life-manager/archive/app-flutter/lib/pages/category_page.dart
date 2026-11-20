import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'detail_page.dart' as detail_mod;
import 'search_page.dart' as search_mod;

/// 分类页：资料统计 + 搜索 + 分类入口 + 最近浏览。
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 175),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              subtitle: '收藏生活 · 记录美好',
              onSearchTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const search_mod.SearchPage()),
              ),
            ),
            const SizedBox(height: 129),
            const _StatsCard(),
            const SizedBox(height: 12),
            const _SearchBar(),
            const SizedBox(height: 12),
            const _CategoryGrid(),
            const SizedBox(height: 12),
            const _RecentCard(),
          ],
        ),
      ),
    );
  }
}

/// 顶部资料统计卡片。
class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      (icon: Icons.description_rounded, value: '286', label: '全部资料'),
      (icon: Icons.image_rounded, value: '128', label: '图片'),
      (icon: Icons.folder_shared_rounded, value: '64', label: '文件'),
      (icon: Icons.verified_user_rounded, value: '3', label: '重要资料'),
    ];
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              Container(
                width: 1,
                height: 44,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(items[i].icon, size: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    items[i].value,
                    style: const TextStyle(
                      fontSize: 19,
                      height: 1.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items[i].label,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 搜索框。
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 26,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 20, color: AppColors.textSub),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              '搜索我的资料...',
              style: TextStyle(fontSize: 14, color: AppColors.textLight),
            ),
          ),
          const Icon(Icons.tune_rounded, size: 20, color: AppColors.navy),
        ],
      ),
    );
  }
}

/// 分类入口 2x3 网格。
class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        title: '图片',
        subtitle: '共 128 张',
        icon: Icons.image_rounded,
        gradient: AppColors.gradBlue,
      ),
      (
        title: '文件',
        subtitle: '共 64 个',
        icon: Icons.description_rounded,
        gradient: AppColors.gradPurple,
      ),
      (
        title: '证件',
        subtitle: '共 42 项',
        icon: Icons.badge_rounded,
        gradient: AppColors.gradGreen,
      ),
      (
        title: '重要资料',
        subtitle: '共 18 项',
        icon: Icons.star_rounded,
        gradient: AppColors.gradOrange,
      ),
      (
        title: '其他资料',
        subtitle: '共 34 项',
        icon: Icons.category_rounded,
        gradient: AppColors.gradTeal,
      ),
      (
        title: '回收站',
        subtitle: '保留 30 天',
        icon: Icons.delete_rounded,
        gradient: AppColors.gradGrey,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.0,
      padding: EdgeInsets.zero,
      children: [
        for (final item in items)
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                GradientIconBox(
                    icon: item.icon,
                    gradient: item.gradient,
                    size: 38,
                    iconSize: 19),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          height: 1.0,
                          color: AppColors.textSub,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    size: 18, color: AppColors.chevron),
              ],
            ),
          ),
      ],
    );
  }
}

/// "最近浏览"卡片。
class _RecentCard extends StatelessWidget {
  const _RecentCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          const SectionHeader(
            icon: ChipIcon(
              icon: Icons.schedule_rounded,
              color: AppColors.primary,
              background: Color(0xFFE3EEFF),
            ),
            title: '最近浏览',
            trailing: '查看更多',
          ),
          const SizedBox(height: 4),
          RecordTile(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const detail_mod.DetailPage()),
              ),
            thumbAsset: 'assets/images/thumb_sea.png',
            title: '旅行照片',
            subtitle: '今天 09:12 · 图片',
          ),
          _TileDivider(),
          const RecordTile(
            thumbAsset: 'assets/images/thumb_doc.png',
            title: '租房合同',
            subtitle: '昨天 21:30 · 文件',
          ),
          _TileDivider(),
          const RecordTile(
            thumbAsset: 'assets/images/thumb_cat.png',
            title: '小猫的疫苗记录',
            subtitle: '4月27日 · 生活',
          ),
        ],
      ),
    );
  }
}

class _TileDivider extends StatelessWidget {
  const _TileDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7,
      margin: const EdgeInsets.only(left: 82, right: 4),
      color: AppColors.divider,
    );
  }
}
