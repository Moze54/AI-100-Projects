import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 新增记录页（静态复刻：类型选择 + 上传 + 自动识别确认 + 补充信息）。
class AddRecordPage extends StatelessWidget {
  const AddRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_add.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '新增记录',
              actionIcon: Icons.help_outline_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _TypeSelector(),
                  const SizedBox(height: 12),
                  const _UploadZone(),
                  const SizedBox(height: 12),
                  const _RecognizeCard(),
                  const SizedBox(height: 12),
                  const _ExtraInfoCard(),
                ],
              ),
            ),
          ),
          SubPageBottomBar(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GradientPillButton(
                    label: '保存到资料',
                    icon: Icons.save_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.66),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notes_rounded,
                            size: 17, color: AppColors.textSub),
                        SizedBox(width: 6),
                        Text(
                          '存为草稿',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSub,
                          ),
                        ),
                      ],
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

/// 类型选择横排。
class _TypeSelector extends StatelessWidget {
  const _TypeSelector();

  @override
  Widget build(BuildContext context) {
    const items = [
      (label: '证件', icon: Icons.photo_camera_rounded),
      (label: '文件', icon: Icons.description_rounded),
      (label: '照片', icon: Icons.image_rounded),
      (label: '生活记录', icon: Icons.edit_note_rounded),
    ];
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 62,
                  decoration: BoxDecoration(
                    color: i == 0
                        ? Colors.white.withValues(alpha: 0.85)
                        : Colors.white.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: i == 0
                          ? AppColors.primary
                          : Colors.white.withValues(alpha: 0.8),
                      width: i == 0 ? 1.5 : 1,
                    ),
                    boxShadow: i == 0
                        ? const [
                            BoxShadow(
                              color: Color(0x22406BAE),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 22,
                        color: i == 0
                            ? AppColors.primary
                            : AppColors.navInactive,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.0,
                          fontWeight:
                              i == 0 ? FontWeight.w700 : FontWeight.w500,
                          color: i == 0
                              ? AppColors.primary
                              : AppColors.navInactive,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == 0 ? AppColors.primary : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// 上传区。
class _UploadZone extends StatelessWidget {
  const _UploadZone();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF9DC0F7),
          width: 1.6,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.gradBlue,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x553D7BF5),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.add_rounded, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            '拍摄或从相册上传',
            style: TextStyle(
              fontSize: 14,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            '支持 JPG / PNG / PDF',
            style: TextStyle(
              fontSize: 11,
              height: 1.0,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

/// 自动识别结果卡。
class _RecognizeCard extends StatelessWidget {
  const _RecognizeCard();

  @override
  Widget build(BuildContext context) {
    const rows = [
      (
        icon: Icons.person_rounded,
        color: Color(0xFF4A87F8),
        label: '姓名',
        value: '张三',
      ),
      (
        icon: Icons.badge_rounded,
        color: Color(0xFF9C6BFF),
        label: '证件号码',
        value: '3301**********1234',
      ),
      (
        icon: Icons.calendar_today_rounded,
        color: Color(0xFF3DBB7A),
        label: '有效期至',
        value: '2030-05-12',
      ),
    ];
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        children: [
          Row(
            children: [
              const ChipIcon(
                icon: Icons.center_focus_strong_rounded,
                color: AppColors.primary,
                background: Color(0xFFE3EEFF),
              ),
              const SizedBox(width: 8),
              const Text(
                '识别结果',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navy,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F6EC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        size: 12, color: Color(0xFF3DBB7A)),
                    SizedBox(width: 4),
                    Text(
                      '98%',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3DBB7A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          for (var i = 0; i < rows.length; i++) ...[
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Icon(rows[i].icon, size: 15, color: rows[i].color),
                  const SizedBox(width: 9),
                  Text(
                    rows[i].label,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    rows[i].value,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.edit_rounded,
                      size: 14, color: AppColors.primary),
                ],
              ),
            ),
            if (i < rows.length - 1) Container(height: 0.7, color: AppColors.divider),
          ],
          const SizedBox(height: 4),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded,
                size: 15, color: AppColors.primary),
            label: const Text(
              '重新识别',
              style: TextStyle(
                fontSize: 13,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 补充信息卡。
class _ExtraInfoCard extends StatelessWidget {
  const _ExtraInfoCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: ChipIcon(
              icon: Icons.edit_note_rounded,
              color: Color(0xFF9C6BFF),
              background: Color(0xFFEFE9FF),
            ),
            title: '补充信息',
            trailing: '',
          ),
          const SizedBox(height: 12),
          // 备注输入框
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(21),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.9), width: 1),
            ),
            child: const Row(
              children: [
                Icon(Icons.edit_rounded, size: 15, color: AppColors.textLight),
                SizedBox(width: 9),
                Text(
                  '添加备注...',
                  style: TextStyle(fontSize: 13, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 标签
          Row(
            children: [
              const Icon(Icons.sell_outlined,
                  size: 15, color: Color(0xFF9C6BFF)),
              const SizedBox(width: 9),
              const Text(
                '标签',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: AppColors.textSub,
                ),
              ),
              const SizedBox(width: 12),
              const _TagChip(label: '常用', color: AppColors.primary, bg: Color(0xFFE3EEFF)),
              const SizedBox(width: 8),
              const _TagChip(label: '重要', color: Color(0xFF9C6BFF), bg: Color(0xFFEFE9FF)),
              const SizedBox(width: 8),
              const _TagChip(label: '工作', color: Color(0xFF3DBB7A), bg: Color(0xFFE3F6EC)),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded,
                  size: 16, color: AppColors.chevron),
            ],
          ),
          const SizedBox(height: 12),
          // 所属分类
          Row(
            children: [
              const Icon(Icons.folder_rounded,
                  size: 15, color: Color(0xFFFF9D42)),
              const SizedBox(width: 9),
              const Text(
                '所属分类',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: AppColors.textSub,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EEFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '证件',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded,
                  size: 16, color: AppColors.chevron),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;

  const _TagChip({required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
