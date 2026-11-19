import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'notify_settings_page.dart' as nset_mod;

/// 通知中心（静态复刻）。
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_vault.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: SubPageHeader(
              title: '通知中心',
              actionIcon: Icons.settings_rounded,
              onActionTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const nset_mod.NotifySettingsPage()),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 今天
                  const _DateLabel(label: '今天'),
                  const _NoticeRow(
                    icon: Icons.event_available_rounded,
                    color: Color(0xFF4A87F8),
                    title: '证件到期提醒',
                    body: '身份证将于 2030-05-12 到期，还有 268 天',
                    time: '09:30',
                    unread: true,
                  ),
                  const _NoticeRow(
                    icon: Icons.cake_rounded,
                    color: Color(0xFFFF8FB0),
                    title: '纪念日提醒',
                    body: '小猫的生日还有 26 天，记得准备礼物哦',
                    time: '08:00',
                    unread: true,
                  ),
                  const _NoticeRow(
                    icon: Icons.medication_rounded,
                    color: Color(0xFF3DBB7A),
                    title: '用药提醒',
                    body: '维生素 C 服用时间到了',
                    time: '08:00',
                    unread: false,
                  ),
                  const SizedBox(height: 14),
                  // 昨天
                  const _DateLabel(label: '昨天'),
                  const _NoticeRow(
                    icon: Icons.autorenew_rounded,
                    color: Color(0xFF9C6BFF),
                    title: '订阅续费提醒',
                    body: '视频会员将于 11-22 到期，费用 ¥25/月',
                    time: '昨天 20:00',
                    unread: false,
                  ),
                  const _NoticeRow(
                    icon: Icons.directions_car_rounded,
                    color: Color(0xFFFF9D42),
                    title: '车辆年检提醒',
                    body: '小轿车年检截止日期为 12-15',
                    time: '昨天 09:00',
                    unread: false,
                  ),
                  const SizedBox(height: 14),
                  // 更早
                  const _DateLabel(label: '更早'),
                  const _NoticeRow(
                    icon: Icons.cloud_sync_rounded,
                    color: Color(0xFF2FB8A8),
                    title: '同步完成',
                    body: '128 项资料已同步至云端',
                    time: '11-17 22:10',
                    unread: false,
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

class _DateLabel extends StatelessWidget {
  final String label;
  const _DateLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          height: 1.0,
          fontWeight: FontWeight.w700,
          color: AppColors.textSub,
        ),
      ),
    );
  }
}

class _NoticeRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final bool unread;

  const _NoticeRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unread
            ? Colors.white.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.85), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.0,
                          fontWeight:
                              unread ? FontWeight.w800 : FontWeight.w600,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (unread)
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.red,
                        ),
                      ),
                    const Spacer(),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.0,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
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
