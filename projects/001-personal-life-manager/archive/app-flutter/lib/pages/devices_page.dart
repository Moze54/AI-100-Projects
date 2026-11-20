import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 设备管理页（静态复刻）。
class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_profile.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '设备管理'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 当前设备
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                gradient: AppColors.gradBlue,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Icon(Icons.phone_android_rounded,
                                  size: 20, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'HUAWEI EBG-AN00',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            height: 1.0,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.navy,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      _DeviceBadge(
                                          label: '本机',
                                          color: AppColors.primary),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'HarmonyOS 4.2 · 最近活跃 今天 10:04',
                                    style: TextStyle(
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
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F6EC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sync_rounded,
                                  size: 13, color: Color(0xFF3DBB7A)),
                              SizedBox(width: 6),
                              Text(
                                '云同步已开启 · 128 MB / 10 GB',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2E9E66),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 其他设备
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3EEFF),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Icon(Icons.computer_rounded,
                                  size: 20, color: AppColors.primary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Windows 桌面端',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            height: 1.0,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.navy,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      _DeviceBadge(
                                          label: '已授权',
                                          color: Color(0xFF3DBB7A)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Windows 11 · 最近活跃 昨天 21:40',
                                    style: TextStyle(
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
                        const SizedBox(height: 12),
                        Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE9E9),
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded,
                                  size: 14, color: AppColors.red),
                              SizedBox(width: 6),
                              Text(
                                '撤销此设备授权',
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
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
                          color: Colors.white.withValues(alpha: 0.85),
                          width: 1),
                    ),
                    child: const Text(
                      '同一账号最多支持多台设备同时登录；撤销设备后，该设备将无法继续同步与解密云端数据，本机数据不受影响。',
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

class _DeviceBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _DeviceBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          height: 1.0,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
