import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 同步管理页（静态复刻）。
class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '同步管理',
              actionIcon: Icons.sync_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 同步状态
                  GlassCard(
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE3F6EC),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.cloud_done_rounded,
                              size: 22, color: Color(0xFF2E9E66)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '已开启 · 全部已同步',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.navy,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '今天 09:00 · 华为 P60 与 iPad 同步完成',
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 1.0,
                                  color: AppColors.textSub,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3EEFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '立即同步',
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 同步范围
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.tune_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '同步范围',
                          trailing: '',
                        ),
                        const _SwitchRow(label: '资料与文件', on: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SwitchRow(label: '待办与日程', on: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SwitchRow(label: '健康记录', on: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SwitchRow(label: '生活资产', on: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SwitchRow(label: '仅 Wi-Fi 下同步', on: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 冲突与版本
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.merge_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '冲突与版本',
                          trailing: '',
                        ),
                        const _SetRow(label: '冲突处理', trailing: '手动选择'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '版本历史保留', trailing: '30 天'),
                        Container(height: 0.7, color: AppColors.divider),
                        _SetRow(
                            label: '查看同步记录',
                            trailing: '本周 12 次',
                            push: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 到期处理
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.event_busy_rounded,
                            color: Color(0xFFFF9D42),
                            background: Color(0xFFFFF0E0),
                          ),
                          title: '到期处理',
                          trailing: '',
                        ),
                        const _SetRow(label: '云空间到期后', trailing: '只读 30 天'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SetRow(label: '超期数据处理', trailing: '下载后清理'),
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
                      '云端数据均经端到端加密后同步，服务器无法读取内容；同一账号最多 5 台设备同时在线，保险箱内容仅在开启保险箱的设备间同步。',
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
  final bool push;

  const _SetRow({
    required this.label,
    required this.trailing,
    this.push = false,
  });

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
          Icon(
            push ? Icons.chevron_right_rounded : Icons.keyboard_arrow_right_rounded,
            size: push ? 18 : 20,
            color: AppColors.chevron,
          ),
        ],
      ),
    );
  }
}
