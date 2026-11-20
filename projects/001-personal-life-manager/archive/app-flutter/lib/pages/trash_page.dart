import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 回收站页（静态复刻）。
class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_vault.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: SubPageHeader(
              title: '回收站',
              actionIcon: Icons.delete_sweep_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 提示条
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.85),
                          width: 1),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline_rounded,
                            size: 16, color: AppColors.textSub),
                        SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            '回收站内容保留 30 天，到期自动清除',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.2,
                              color: AppColors.textSub,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _TrashTile(
                    name: '旧版简历.pdf',
                    type: '文件 · 2.1 MB',
                    deleted: '3 天前删除',
                  ),
                  const SizedBox(height: 10),
                  const _TrashTile(
                    name: '水电费收据.png',
                    type: '图片 · 1.8 MB',
                    deleted: '8 天前删除',
                  ),
                  const SizedBox(height: 10),
                  const _TrashTile(
                    name: '健身卡备注',
                    type: '生活记录 · 文字',
                    deleted: '15 天前删除',
                  ),
                  const SizedBox(height: 10),
                  const _TrashTile(
                    name: '过期优惠券',
                    type: '证件附件 · 0.4 MB',
                    deleted: '28 天前删除',
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

class _TrashTile extends StatelessWidget {
  final String name;
  final String type;
  final String deleted;

  const _TrashTile({
    required this.name,
    required this.type,
    required this.deleted,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: 16,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF1FA),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.insert_drive_file_outlined,
                size: 18, color: AppColors.textSub),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 4),
                Text(
                  '$type · $deleted',
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.restore_rounded,
                size: 15, color: AppColors.primary),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete_forever_rounded,
                size: 15, color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
