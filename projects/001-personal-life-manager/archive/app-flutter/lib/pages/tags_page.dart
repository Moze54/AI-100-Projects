import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 标签管理页（静态复刻）。
class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_category.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '标签管理',
              actionIcon: Icons.add_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 我的标签
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.sell_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '我的标签',
                          trailing: '3 个',
                        ),
                        const _TagRow(
                            name: '工作文件',
                            color: Color(0xFF4A87F8),
                            bg: Color(0xFFE3EEFF),
                            count: 23),
                        Container(height: 0.7, color: AppColors.divider),
                        const _TagRow(
                            name: '家庭资料',
                            color: Color(0xFFFF9D42),
                            bg: Color(0xFFFFF0E0),
                            count: 41),
                        Container(height: 0.7, color: AppColors.divider),
                        const _TagRow(
                            name: '学习笔记',
                            color: Color(0xFF3DBB7A),
                            bg: Color(0xFFE3F6EC),
                            count: 17),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 新建标签
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.new_label_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '新建标签',
                          trailing: '',
                        ),
                        const SizedBox(height: 12),
                        // 名称输入
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.9),
                                width: 1),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.edit_rounded,
                                  size: 16, color: AppColors.textLight),
                              SizedBox(width: 8),
                              Text(
                                '标签名称（最多 6 个字）',
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.0,
                                  color: AppColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 颜色选择
                        const Text(
                          '标签颜色',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: AppColors.textSub,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            for (var i = 0; i < 6; i++) ...[
                              if (i > 0) const SizedBox(width: 10),
                              _ColorSwatch(
                                color: const [
                                  Color(0xFF4A87F8),
                                  Color(0xFF3DBB7A),
                                  Color(0xFFFF9D42),
                                  Color(0xFF9C6BFF),
                                  Color(0xFF2FB8A8),
                                  Color(0xFFE8607C),
                                ][i],
                                selected: i == 0,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 14),
                        // 预览
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                '预览',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.0,
                                  color: AppColors.textLight,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3EEFF),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.sell_rounded,
                                        size: 13, color: AppColors.primary),
                                    SizedBox(width: 5),
                                    Text(
                                      '工作文件',
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        const GradientPillButton(
                          label: '创建标签',
                          icon: Icons.check_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 说明
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.85), width: 1),
                    ),
                    child: const Text(
                      '标签可与任意资料、待办、日程相互关联，用于跨模块聚合查看；删除标签不会删除已关联的内容，仅解除关联关系。',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: AppColors.textSub,
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

class _TagRow extends StatelessWidget {
  final String name;
  final Color color;
  final Color bg;
  final int count;

  const _TagRow({
    required this.name,
    required this.color,
    required this.bg,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.sell_rounded, size: 16, color: color),
          ),
          const SizedBox(width: 11),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          Text(
            '$count 项关联',
            style: const TextStyle(
              fontSize: 12,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.drag_indicator_rounded,
              size: 18, color: AppColors.chevron),
          const SizedBox(width: 8),
          const Icon(Icons.edit_rounded, size: 16, color: AppColors.primary),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final Color color;
  final bool selected;

  const _ColorSwatch({required this.color, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.navy : Colors.transparent,
          width: selected ? 2.4 : 0,
        ),
      ),
      child: selected
          ? const Icon(Icons.check_rounded, size: 15, color: Colors.white)
          : null,
    );
  }
}
