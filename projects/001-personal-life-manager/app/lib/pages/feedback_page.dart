import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 意见反馈页（静态复刻）。
class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '意见反馈',
              actionIcon: Icons.help_outline_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 反馈类型
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.category_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '反馈类型',
                          trailing: '',
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: const [
                            _TypeChip(label: '功能建议', selected: true),
                            _TypeChip(label: '问题反馈', selected: false),
                            _TypeChip(label: '使用咨询', selected: false),
                            _TypeChip(label: '其他', selected: false),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 内容输入
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.edit_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '详细描述',
                          trailing: '',
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '希望资料详情页可以支持自定义字段排序，方便把常用的信息放到最前面……',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: AppColors.navy.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '128 / 500',
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.0,
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 截图附件
                        Row(
                          children: [
                            for (var i = 0; i < 2; i++) ...[
                              if (i > 0) const SizedBox(width: 8),
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3EEFF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      width: 1),
                                ),
                                child: const Icon(Icons.image_rounded,
                                    size: 20, color: AppColors.primary),
                              ),
                            ],
                            const SizedBox(width: 8),
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF9DC0F7),
                                  width: 1.4,
                                ),
                              ),
                              child: const Icon(Icons.add_rounded,
                                  size: 20, color: AppColors.primary),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '添加截图（可选）',
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.0,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 联系方式
                  GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: const _ContactRow(label: '联系方式', value: 'zhang***@163.com'),
                  ),
                  const SizedBox(height: 12),
                  GradientPillButton(
                    label: '提交反馈',
                    icon: Icons.send_rounded,
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '反馈内容仅用于产品改进，我们不会公开你的个人信息',
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

class _TypeChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _TypeChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.white.withValues(alpha: 0.8),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          height: 1.0,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
          color: selected ? AppColors.primary : AppColors.textSub,
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String label;
  final String value;
  const _ContactRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}
