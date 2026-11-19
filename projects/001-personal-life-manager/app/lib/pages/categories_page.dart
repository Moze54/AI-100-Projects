import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 分类 / 标签管理页（静态复刻）。
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_category.png',
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: const SubPageHeader(title: '分类与标签管理'),
            ),
            // Tab 切换
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Expanded(child: _TabItem(label: '系统分类', count: 4, selected: true)),
                  const SizedBox(width: 10),
                  const Expanded(child: _TabItem(label: '自定义分类', count: 2)),
                  const SizedBox(width: 10),
                  const Expanded(child: _TabItem(label: '标签', count: 3)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _CategoryRow(
                        icon: Icons.badge_rounded,
                        color: Color(0xFF4A87F8),
                        name: '证件',
                        count: 42,
                        hidden: false),
                    const _CategoryRow(
                        icon: Icons.image_rounded,
                        color: Color(0xFF4A87F8),
                        name: '图片',
                        count: 128,
                        hidden: false),
                    const _CategoryRow(
                        icon: Icons.description_rounded,
                        color: Color(0xFF9C6BFF),
                        name: '文件',
                        count: 64,
                        hidden: false),
                    const _CategoryRow(
                        icon: Icons.star_rounded,
                        color: Color(0xFFFF9D42),
                        name: '重要资料',
                        count: 18,
                        hidden: false),
                    const _CategoryRow(
                        icon: Icons.category_rounded,
                        color: Color(0xFF2FB8A8),
                        name: '其他资料',
                        count: 34,
                        hidden: true),
                    const SizedBox(height: 12),
                    // 添加自定义分类
                    GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.add_circle_outline_rounded,
                                  size: 17, color: AppColors.primary),
                              SizedBox(width: 8),
                              Text(
                                '新建自定义分类',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.navy,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '自定义名称、图标、颜色',
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
                              _TagChip(label: '工作文件', color: AppColors.primary, bg: Color(0xFFE3EEFF)),
                              SizedBox(width: 8),
                              _TagChip(label: '家庭资料', color: Color(0xFFFF9D42), bg: Color(0xFFFFF0E0)),
                              SizedBox(width: 8),
                              _TagChip(label: '学习笔记', color: Color(0xFF3DBB7A), bg: Color(0xFFE3F6EC)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  const _TabItem({required this.label, required this.count, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: selected
            ? Colors.white.withValues(alpha: 0.88)
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.white.withValues(alpha: 0.8),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? AppColors.primary : AppColors.textSub,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count 项',
            style: TextStyle(
              fontSize: 10,
              height: 1.0,
              color: selected ? AppColors.primary : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;
  final int count;
  final bool hidden;

  const _CategoryRow({
    required this.icon,
    required this.color,
    required this.name,
    required this.count,
    required this.hidden,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      radius: 16,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Row(
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
                if (hidden) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      '已隐藏',
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.0,
                        color: AppColors.textSub,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '$count 项',
            style: const TextStyle(
              fontSize: 12,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.drag_indicator_rounded,
              size: 18, color: AppColors.chevron),
          const Icon(Icons.edit_rounded, size: 16, color: AppColors.primary),
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
