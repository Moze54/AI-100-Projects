import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 隐私政策与数据说明页（静态复刻）。
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_vault.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '隐私政策与数据说明',
              actionIcon: Icons.verified_user_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 版本信息
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.policy_rounded,
                                size: 17, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text(
                              '隐私政策 · V1.2',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.0,
                                fontWeight: FontWeight.w800,
                                color: AppColors.navy,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '生效日期：2026-06-01',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: AppColors.textSub,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '拾记非常重视你的隐私。我们仅收集为提供服务所必需的最少数据，资料内容默认保存在本地，云端同步内容均经过端到端加密。',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: AppColors.textSub.withValues(alpha: 0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 我们如何处理数据
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.folder_shared_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '数据如何处理',
                          trailing: '',
                        ),
                        const _DataRow(
                            icon: Icons.badge_rounded,
                            color: Color(0xFF4A87F8),
                            label: '账号信息',
                            desc: '手机号、设备标识，用于登录与多设备同步'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DataRow(
                            icon: Icons.lock_rounded,
                            color: Color(0xFF9C6BFF),
                            label: '资料内容',
                            desc: '本地保存；云端副本端到端加密，后台无法读取'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DataRow(
                            icon: Icons.phone_android_rounded,
                            color: Color(0xFFFF9D42),
                            label: '设备信息',
                            desc: '机型与系统版本，用于同步状态与安全提醒'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DataRow(
                            icon: Icons.query_stats_rounded,
                            color: Color(0xFF3DBB7A),
                            label: '使用统计',
                            desc: '匿名化的功能使用情况，仅用于产品改进'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 你的权利
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.how_to_reg_rounded,
                            color: Color(0xFF2FB8A8),
                            background: Color(0xFFE0F5F1),
                          ),
                          title: '你的权利',
                          trailing: '',
                        ),
                        const _ActionRow(
                            icon: Icons.file_download_rounded,
                            label: '导出全部数据',
                            trailing: ''),
                        Container(height: 0.7, color: AppColors.divider),
                        const _ActionRow(
                            icon: Icons.delete_sweep_rounded,
                            label: '删除云端数据',
                            trailing: '本地不受影响'),
                        Container(height: 0.7, color: AppColors.divider),
                        _ActionRow(
                          icon: Icons.person_remove_rounded,
                          label: '注销账号',
                          trailing: '7 天后生效',
                          danger: true,
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
                      '注销账号将删除服务器上的账号信息与云端加密数据，且不可恢复；设备上的本地资料需自行手动删除。政策更新后会在应用内提前 30 天通知你。',
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

class _DataRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String desc;

  const _DataRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  desc,
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
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailing;
  final bool danger;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.trailing,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final mainColor = danger ? const Color(0xFFE8607C) : AppColors.primary;
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: danger
                  ? const Color(0xFFE8607C).withValues(alpha: 0.12)
                  : const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: mainColor),
          ),
          const SizedBox(width: 11),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: danger ? const Color(0xFFE8607C) : AppColors.navy,
            ),
          ),
          const Spacer(),
          if (trailing.isNotEmpty)
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 11,
                height: 1.0,
                color: AppColors.textLight,
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
