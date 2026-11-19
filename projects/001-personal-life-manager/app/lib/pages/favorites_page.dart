import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 我的收藏页（静态复刻）。
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_profile.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '我的收藏',
              actionIcon: Icons.manage_search_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 统计
                  GlassCard(
                    child: Row(
                      children: [
                        Expanded(
                            child: _StatItem(label: '资料', value: '6', color: AppColors.primary)),
                        Container(width: 1, height: 38, color: AppColors.divider),
                        Expanded(
                            child: _StatItem(label: '记录', value: '9', color: const Color(0xFF9C6BFF))),
                        Container(width: 1, height: 38, color: AppColors.divider),
                        Expanded(
                            child: _StatItem(label: '日期', value: '3', color: const Color(0xFFFF8FB0))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 收藏的资料
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.bookmark_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '收藏的资料',
                          trailing: '',
                        ),
                        const _FavFileRow(
                            name: '身份证复印件',
                            meta: '证件 · 2.1 MB',
                            icon: Icons.badge_rounded),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FavFileRow(
                            name: '购房合同.pdf',
                            meta: '文件 · 8.6 MB',
                            icon: Icons.description_rounded),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FavFileRow(
                            name: '疫苗接种记录',
                            meta: '证件 · 1.4 MB',
                            icon: Icons.health_and_safety_rounded),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 收藏的记录
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.favorite_rounded,
                            color: Color(0xFFFF8FB0),
                            background: Color(0xFFFFEAF2),
                          ),
                          title: '收藏的记录',
                          trailing: '',
                        ),
                        const _FavRecordRow(
                            title: '海边的日落',
                            meta: '4月12日 · 图片',
                            image: 'assets/images/thumb_sea.png'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FavRecordRow(
                            title: '小猫的一岁生日',
                            meta: '4月18日 · 日记',
                            image: 'assets/images/thumb_cat.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 收藏的标签
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.sell_rounded,
                                size: 17, color: Color(0xFF3DBB7A)),
                            SizedBox(width: 8),
                            Text(
                              '收藏的标签',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '点按查看全部内容',
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.0,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            _TagChip(label: '家庭资料', color: Color(0xFFFF9D42), bg: Color(0xFFFFF0E0)),
                            SizedBox(width: 8),
                            _TagChip(label: '学习笔记', color: Color(0xFF3DBB7A), bg: Color(0xFFE3F6EC)),
                            SizedBox(width: 8),
                            _TagChip(label: '工作文件', color: AppColors.primary, bg: Color(0xFFE3EEFF)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '长按任意资料或记录即可收藏 / 取消收藏',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.0,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            height: 1.0,
            color: AppColors.textSub,
          ),
        ),
      ],
    );
  }
}

class _FavFileRow extends StatelessWidget {
  final String name;
  final String meta;
  final IconData icon;

  const _FavFileRow({
    required this.name,
    required this.meta,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: AppColors.primary),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  meta,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFFC46B)),
        ],
      ),
    );
  }
}

class _FavRecordRow extends StatelessWidget {
  final String title;
  final String meta;
  final String image;

  const _FavRecordRow({
    required this.title,
    required this.meta,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Image.asset(image, width: 44, height: 44, fit: BoxFit.cover),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  meta,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFFC46B)),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;

  const _TagChip({required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
