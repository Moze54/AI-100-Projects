import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'about_page.dart';
import 'categories_page.dart';
import 'feedback_page.dart';
import 'help_page.dart';
import 'notify_settings_page.dart';
import 'privacy_page.dart';
import 'tags_page.dart';

/// 偏好设置页（静态复刻）。
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_profile.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '设置'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 外观与显示
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.palette_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '外观与显示',
                          trailing: '',
                        ),
                        const _SetRow(label: '主题', trailing: '跟随系统'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '字体大小', trailing: '标准'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '日期格式', trailing: '2026-04-29'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '一周起始日', trailing: '周一'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 提醒与通知
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.notifications_rounded,
                            color: Color(0xFFFF9D42),
                            background: Color(0xFFFFF0E0),
                          ),
                          title: '提醒与通知',
                          trailing: '',
                        ),
                        _SetRow(
                            label: '通知偏好',
                            trailing: '',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const NotifySettingsPage()),
                            ),
                          ),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '默认提前提醒', trailing: '30 分钟'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 资料与分类
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.category_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '资料与分类',
                          trailing: '',
                        ),
                        _SetRow(
                            label: '分类管理',
                            trailing: '6 个分类',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const CategoriesPage()),
                            ),
                          ),
                        Container(height: 0.7, color: AppColors.divider),
                        _SetRow(
                            label: '标签管理',
                            trailing: '3 个标签',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const TagsPage()),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 通用
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.tune_rounded,
                            color: Color(0xFF3DBB7A),
                            background: Color(0xFFE3F6EC),
                          ),
                          title: '通用',
                          trailing: '',
                        ),
                        const _SetRow(label: '语言', trailing: '简体中文'),
                        Container(height: 0.7, color: AppColors.divider),
                        _SetRow(
                            label: '意见反馈',
                            trailing: '',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const FeedbackPage()),
                            ),
                          ),
                        Container(height: 0.7, color: AppColors.divider),
                        _SetRow(
                            label: '帮助与常见问题',
                            trailing: '',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const HelpPage()),
                            ),
                          ),
                        Container(height: 0.7, color: AppColors.divider),
                        _SetRow(
                            label: '隐私政策',
                            trailing: '',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const PrivacyPage()),
                            ),
                          ),
                        Container(height: 0.7, color: AppColors.divider),
                        _SetRow(
                            label: '关于拾记',
                            trailing: 'V1.0.0',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const AboutPage()),
                            ),
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
    );
  }
}

class _SetRow extends StatelessWidget {
  final String label;
  final String trailing;
  final bool push;
  final VoidCallback? onTap;

  const _SetRow({
    required this.label,
    required this.trailing,
    this.push = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
            const Spacer(),
            if (trailing.isNotEmpty)
              Text(
                trailing,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: AppColors.textSub,
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              push
                  ? Icons.chevron_right_rounded
                  : Icons.keyboard_arrow_right_rounded,
              size: push ? 18 : 20,
              color: push ? AppColors.chevron : AppColors.chevron,
            ),
          ],
        ),
      ),
    );
  }
}
