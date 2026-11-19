import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 通知偏好设置页（静态复刻）。
class NotifySettingsPage extends StatelessWidget {
  const NotifySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_vault.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '通知偏好',
              actionIcon: Icons.done_all_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 系统通知
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.notifications_active_rounded,
                            color: Color(0xFFFF9D42),
                            background: Color(0xFFFFF0E0),
                          ),
                          title: '系统通知',
                          trailing: '',
                        ),
                        const _SwitchRow(label: '本地通知', on: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SwitchRow(label: '云端推送（多设备补充）', on: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SwitchRow(label: '通知去重', on: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 提醒时间
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.alarm_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '提醒时间',
                          trailing: '',
                        ),
                        const _SetRow(label: '日程类', trailing: '提前 30 分钟'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '生日 / 纪念日', trailing: '提前 1 天'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '资料到期', trailing: '提前 30 天'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '订阅续费', trailing: '提前 3 天'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 免打扰
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.do_not_disturb_on_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '免打扰时段',
                          trailing: '',
                        ),
                        const _SwitchRow(label: '夜间免打扰 22:00 - 08:00', on: true),
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
                      '提醒受设备通知权限、省电策略和后台限制影响，可能存在延迟；本地提醒优先，云端推送仅作多设备补充并自动去重。',
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

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool on;
  const _SwitchRow({required this.label, required this.on});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                height: 1.0,
                color: AppColors.navy,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 22,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: on ? const Color(0xFF6FA3FE) : const Color(0xFFC9D4EA),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Align(
              alignment: on ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
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
  const _SetRow({required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              height: 1.0,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          Text(
            trailing,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w600,
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
