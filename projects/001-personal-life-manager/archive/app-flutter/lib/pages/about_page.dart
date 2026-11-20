import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 关于拾记页（静态复刻）。
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_profile.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '关于拾记'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 品牌卡
                  GlassCard(
                    child: Column(
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x334A87F8),
                                blurRadius: 16,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '拾记',
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.0,
                            fontWeight: FontWeight.w900,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '记录生活的每一刻',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: AppColors.textSub,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '版本 V1.0.0 (Build 100)',
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSub,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 功能与协议
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const _Row(
                            icon: Icons.system_update_rounded,
                            label: '检查更新',
                            trailing: '已是最新版本'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _Row(
                            icon: Icons.star_outline_rounded,
                            label: '功能介绍',
                            trailing: ''),
                        Container(height: 0.7, color: AppColors.divider),
                        const _Row(
                            icon: Icons.description_outlined,
                            label: '用户协议',
                            trailing: ''),
                        Container(height: 0.7, color: AppColors.divider),
                        const _Row(
                            icon: Icons.source_outlined,
                            label: '开源许可',
                            trailing: ''),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 联系
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const _Row(
                            icon: Icons.language_rounded,
                            label: '官方网站',
                            trailing: 'www.shiji.app'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _Row(
                            icon: Icons.alternate_email_rounded,
                            label: '联系我们',
                            trailing: 'support@shiji.app'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      '© 2026 拾记团队 · 用心记录生活',
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

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailing;

  const _Row({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 11),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          if (trailing.isNotEmpty)
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 12,
                height: 1.0,
                color: AppColors.textSub,
              ),
            ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded,
              size: 18, color: AppColors.chevron),
        ],
      ),
    );
  }
}
