import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 资料详情页（静态复刻：身份证详情）。
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '身份证',
              actionIcon: Icons.more_horiz_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PreviewCard(),
                  const SizedBox(height: 12),
                  _ExpiryBanner(),
                  const SizedBox(height: 12),
                  const _FieldsCard(),
                  const SizedBox(height: 12),
                  const _AttachmentsCard(),
                ],
              ),
            ),
          ),
          SubPageBottomBar(
            child: Row(
              children: [
                Expanded(
                  child: GradientPillButton(
                    label: '编辑',
                    icon: Icons.edit_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _GhostButton(
                    label: '分享',
                    icon: Icons.share_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _GhostButton(
                    label: '删除',
                    icon: Icons.delete_outline_rounded,
                    color: AppColors.red,
                    background: const Color(0xFFFFE9E9),
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

/// 证件照片预览卡（占位示意，不使用真实证件内容）。
class _PreviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7FA9F9), Color(0xFF5D8DF7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.badge_outlined, size: 34, color: Colors.white),
            const SizedBox(height: 8),
            const Text(
              '证件照片 · 正面',
              style: TextStyle(
                fontSize: 14,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '点击查看或更换图片',
              style: TextStyle(
                fontSize: 10,
                height: 1.0,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 到期提醒横幅。
class _ExpiryBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3D6), Color(0xFFFFE7B4)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule_rounded, size: 20, color: Color(0xFFE8A23D)),
          const SizedBox(width: 9),
          const Text(
            '距到期还有 ',
            style: TextStyle(fontSize: 13, height: 1.0, color: Color(0xFF9A7B3F)),
          ),
          const Text(
            '268',
            style: TextStyle(
              fontSize: 21,
              height: 1.0,
              fontWeight: FontWeight.w800,
              color: AppColors.red,
            ),
          ),
          const Text(
            ' 天',
            style: TextStyle(fontSize: 13, height: 1.0, color: Color(0xFF9A7B3F)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              '设提醒',
              style: TextStyle(
                fontSize: 12,
                height: 1.0,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 字段信息卡。
class _FieldsCard extends StatelessWidget {
  const _FieldsCard();

  @override
  Widget build(BuildContext context) {
    const rows = [
      (
        icon: Icons.badge_rounded,
        color: Color(0xFF4A87F8),
        bg: Color(0xFFE3EEFF),
        label: '证件类型',
        value: '身份证',
      ),
      (
        icon: Icons.fingerprint_rounded,
        color: Color(0xFF9C6BFF),
        bg: Color(0xFFEFE9FF),
        label: '证件号码',
        value: '3301**********1234',
      ),
      (
        icon: Icons.calendar_today_rounded,
        color: Color(0xFF3DBB7A),
        bg: Color(0xFFE3F6EC),
        label: '签发日期',
        value: '2020-05-12',
      ),
      (
        icon: Icons.hourglass_bottom_rounded,
        color: Color(0xFFFF9D42),
        bg: Color(0xFFFFF0E0),
        label: '有效期至',
        value: '2030-05-12',
      ),
      (
        icon: Icons.folder_rounded,
        color: Color(0xFF4A87F8),
        bg: Color(0xFFE3EEFF),
        label: '所属分类',
        value: '证件',
      ),
    ];
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Container(height: 0.7, color: AppColors.divider),
            SizedBox(
              height: 46,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: rows[i].bg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(rows[i].icon, size: 14, color: rows[i].color),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    rows[i].label,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      rows[i].value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // 标签行
          Container(height: 0.7, color: AppColors.divider),
          SizedBox(
            height: 46,
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFE9FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.sell_outlined,
                      size: 14, color: Color(0xFF9C6BFF)),
                ),
                const SizedBox(width: 10),
                const Text(
                  '标签',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3EEFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '常用',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
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

/// 关联附件卡。
class _AttachmentsCard extends StatelessWidget {
  const _AttachmentsCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          const SectionHeader(
            icon: ChipIcon(
              icon: Icons.attach_file_rounded,
              color: Color(0xFF9C6BFF),
              background: Color(0xFFEFE9FF),
            ),
            title: '关联附件',
            trailing: '全部',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < 3; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 78,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradBlue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.7),
                          width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          i == 2
                              ? Icons.image_outlined
                              : Icons.badge_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          i == 0 ? '正面' : (i == 1 ? '反面' : '国徽面'),
                          style: const TextStyle(
                            fontSize: 10,
                            height: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// 毛玻璃次级按钮。
class _GhostButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;

  const _GhostButton({
    required this.label,
    required this.icon,
    this.color = AppColors.primary,
    this.background = const Color(0xFFE3EEFF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
