import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 备份与恢复页（静态复刻）。
class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '备份与恢复'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 说明卡
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline_rounded,
                                size: 17, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text(
                              '手动备份 · 本地保存',
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
                        Text(
                          '备份包含全部资料、附件、分类、标签与关联关系；备份文件本身不额外加密，保险箱内容保持其自身加密状态。请妥善保管备份文件。',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: AppColors.textSub,
                          ),
                        ),
                        const SizedBox(height: 14),
                        GradientPillButton(
                          label: '创建新备份',
                          icon: Icons.backup_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 备份历史
                  GlassCard(
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.history_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '备份历史',
                          trailing: '',
                        ),
                        const SizedBox(height: 8),
                        const _BackupRow(
                            name: 'shiji_backup_20261119',
                            meta: '今天 09:00 · 386 MB',
                            current: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _BackupRow(
                            name: 'shiji_backup_20261101',
                            meta: '11-01 09:00 · 350 MB',
                            current: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _BackupRow(
                            name: 'shiji_backup_20261015',
                            meta: '10-15 09:00 · 312 MB',
                            current: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 恢复
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.restore_rounded,
                            color: Color(0xFF3DBB7A),
                            background: Color(0xFFE3F6EC),
                          ),
                          title: '从备份恢复',
                          trailing: '',
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '恢复前会校验备份完整性，并提示将覆盖的内容；恢复失败不会破坏现有数据。',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: AppColors.textSub,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F6EC),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Center(
                            child: Text(
                              '选择备份文件并恢复',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2E9E66),
                              ),
                            ),
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

class _BackupRow extends StatelessWidget {
  final String name;
  final String meta;
  final bool current;

  const _BackupRow({
    required this.name,
    required this.meta,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2_rounded,
                size: 16, color: AppColors.primary),
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
                    fontSize: 13,
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
          if (current)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F6EC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '最新',
                style: TextStyle(
                  fontSize: 10,
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2E9E66),
                ),
              ),
            ),
          const SizedBox(width: 6),
          const Text(
            '恢复',
            style: TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
