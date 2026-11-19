import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 全局搜索页（静态复刻）。
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_search.png',
      child: Column(
        children: [
          // 搜索区
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(23),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.9),
                          width: 1),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search_rounded,
                            size: 20, color: AppColors.textSub),
                        SizedBox(width: 10),
                        Text(
                          '租房',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '|',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primary,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.cancel_rounded,
                            size: 18, color: AppColors.chevron),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 筛选胶囊
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: const [
                _FilterChip(label: '全部', icon: Icons.grid_view_rounded, selected: true),
                SizedBox(width: 8),
                _FilterChip(label: '图片', icon: Icons.image_rounded),
                SizedBox(width: 8),
                _FilterChip(label: '文件', icon: Icons.folder_rounded),
                SizedBox(width: 8),
                _FilterChip(label: '证件', icon: Icons.badge_rounded),
                SizedBox(width: 8),
                _FilterChip(label: '重要资料', icon: Icons.star_rounded),
                SizedBox(width: 8),
                _FilterChip(label: '生活记录', icon: Icons.edit_note_rounded),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 结果统计
                  Row(
                    children: const [
                      Text(
                        '找到 ',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.textSub),
                      ),
                      Text(
                        '12',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        ' 条相关结果',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.textSub),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 图片组
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.image_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '图片',
                          trailing: '3 张',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (final asset in [
                              'assets/images/thumb_sea.png',
                              'assets/images/thumb_doc.png',
                              'assets/images/thumb_cat.png',
                            ]) ...[
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    asset,
                                    height: 86,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (asset != 'assets/images/thumb_cat.png')
                                const SizedBox(width: 8),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 文件组
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.folder_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '文件',
                          trailing: '2 项',
                        ),
                        const SizedBox(height: 10),
                        _FileRow(
                          icon: Icons.picture_as_pdf_rounded,
                          iconBg: const Color(0xFFFFE3E0),
                          iconColor: const Color(0xFFF5484E),
                          name: '租房合同',
                          meta: '2025-08-12 · 2.3 MB',
                        ),
                        Container(height: 0.7, color: AppColors.divider),
                        _FileRow(
                          icon: Icons.description_rounded,
                          iconBg: const Color(0xFFE3EEFF),
                          iconColor: const Color(0xFF4A87F8),
                          name: '保险单据',
                          meta: '2025-07-28 · 1.1 MB',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 证件组
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.badge_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '证件',
                          trailing: '2 张',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _IdMiniCard(
                                title: '身份证',
                                colors: const [Color(0xFF7FA9F9), Color(0xFF5D8DF7)],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _IdMiniCard(
                                title: '驾驶证',
                                colors: const [Color(0xFF9BD8B4), Color(0xFF6FC296)],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  // 底部空态提示
                  const Center(
                    child: Text(
                      '——  没找到？试试其他关键词  ——',
                      style: TextStyle(
                        fontSize: 12,
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

/// 筛选胶囊。
class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;

  const _FilterChip({
    required this.label,
    required this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.white.withValues(alpha: 0.8),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: selected ? AppColors.primary : AppColors.textSub,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppColors.primary : AppColors.textSub,
            ),
          ),
        ],
      ),
    );
  }
}

/// 文件结果行。
class _FileRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final String meta;

  const _FileRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.name,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
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
                const SizedBox(height: 4),
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
          const Icon(Icons.chevron_right_rounded,
              size: 18, color: AppColors.chevron),
        ],
      ),
    );
  }
}

/// 证件小卡（示意占位）。
class _IdMiniCard extends StatelessWidget {
  final String title;
  final List<Color> colors;

  const _IdMiniCard({required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.badge_outlined, size: 16, color: Colors.white),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '3301**********1234',
            style: TextStyle(
              fontSize: 9,
              height: 1.0,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}
