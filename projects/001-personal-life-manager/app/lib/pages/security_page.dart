import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'backup_page.dart' as backup_mod;
import 'trash_page.dart' as trash_mod;

/// 数据安全页（静态复刻）。
class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_vault.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '数据安全'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 加密状态卡
                  GlassCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                gradient: AppColors.gradBlue,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.lock_rounded,
                                  size: 22, color: Colors.white),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '端到端加密',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.0,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.navy,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '已开启 · 服务端仅保存密文，无法解密你的资料',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.2,
                                      color: AppColors.textSub,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 密码与锁定
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        _Row(
                            icon: Icons.password_rounded,
                            label: '修改登录密码',
                            trailing: '90 天前'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _Row(
                            icon: Icons.lock_clock_rounded,
                            label: '保险箱自动锁定',
                            trailing: '5 分钟'),
                        Container(height: 0.7, color: AppColors.divider),
                        _Row(
                            icon: Icons.fingerprint_rounded,
                            label: '生物识别解锁',
                            trailing: '已开启',
                            on: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 数据与备份
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        _Row(
                            icon: Icons.backup_rounded,
                            label: '备份与恢复',
                            trailing: '',
                            push: true,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const backup_mod.BackupPage()),
                            ),),
                        Container(height: 0.7, color: AppColors.divider),
                        _Row(
                            icon: Icons.delete_sweep_rounded,
                            label: '回收站',
                            trailing: '',
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const trash_mod.TrashPage()),
                            ),),
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
                      '你的资料在设备端加密后才会同步，密钥仅保存在你的授权设备上。忘记登录密码不影响本机数据，但可能影响云端密文的恢复，请妥善保管。',
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

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailing;
  final bool on;
  final bool danger;
  final bool push;
  final VoidCallback? onTap;

  const _Row({
    required this.icon,
    required this.label,
    required this.trailing,
    this.on = false,
    this.danger = false,
    this.push = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = danger ? AppColors.red : AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: danger
                  ? const Color(0xFFFFE9E9)
                  : const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 16, color: c),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: danger ? AppColors.red : AppColors.navy,
              ),
            ),
          ),
          if (trailing.isNotEmpty)
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 13,
                height: 1.0,
                color: AppColors.textSub,
              ),
            ),
          if (on) ...[
            const SizedBox(width: 6),
            const Icon(Icons.check_circle_rounded,
                size: 16, color: Color(0xFF3DBB7A)),
          ],
          if (push) ...[
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded,
                size: 18, color: AppColors.chevron),
          ],
        ],
      ),
      ),
    );
  }
}
