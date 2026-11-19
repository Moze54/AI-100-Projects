import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'about_page.dart' as about_mod;
import 'assets_page.dart' as assets_mod;
import 'calendar_page.dart' as cal_mod;
import 'devices_page.dart' as devices_mod;
import 'favorites_page.dart' as fav_mod;
import 'feedback_page.dart' as feedback_mod;
import 'health_page.dart' as health_mod;
import 'login_page.dart' as login_mod;
import 'notifications_page.dart' as notify_mod;
import 'security_page.dart' as security_mod;
import 'settings_page.dart' as settings_mod;
import 'storage_page.dart' as storage_mod;
import 'sync_page.dart' as sync_mod;
import 'trash_page.dart' as trash_mod;
import 'vault_page.dart' as vault_mod;

/// 我的页：用户信息 + 会员 + 云空间 + 功能宫格 + 设置列表 + 退出登录。
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 340),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Spacer(),
                RoundGlassButton(
                  icon: Icons.notifications_rounded,
                  showRedDot: true,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const notify_mod.NotificationsPage()),
                  ),
                ),
                SizedBox(width: 10),
                RoundGlassButton(
                  icon: Icons.settings_rounded,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const settings_mod.SettingsPage()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const _ProfileRow(),
            const SizedBox(height: 16),
            const _VipBanner(),
            const SizedBox(height: 12),
            const _CloudCard(),
            const SizedBox(height: 12),
            const _MenuGrid(),
            const SizedBox(height: 12),
            const _SettingsList(),
            const SizedBox(height: 12),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const login_mod.LoginPage()),
              ),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, size: 19, color: AppColors.red),
                    SizedBox(width: 8),
                    Text(
                      '退出登录',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 3),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22406BAE),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    '拾记用户',
                    style: TextStyle(
                      fontSize: 23,
                      height: 1.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navy,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.chevron_right_rounded,
                      size: 22, color: AppColors.navy),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                '记录生活，收藏美好',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF7A86A8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 高级会员横幅。
class _VipBanner extends StatelessWidget {
  const _VipBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE9D4), Color(0xFFFFD9B4)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22F5A65B),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium_rounded,
              size: 30, color: Color(0xFFE8A23D)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '高级会员',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB26B1F),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '尊享更多专属功能',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: Color(0xFFD69A5C),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: const Row(
              children: [
                Text(
                  '立即开通',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFC87F2B),
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.chevron_right_rounded,
                    size: 16, color: Color(0xFFC87F2B)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 云空间使用情况卡片。
class _CloudCard extends StatelessWidget {
  const _CloudCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          const Icon(Icons.cloud_rounded, size: 38, color: Color(0xFF6BA4FF)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '云空间使用情况',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '128 MB / 10 GB',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: SizedBox(
                    height: 5,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.0128,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.gradBlue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const storage_mod.StoragePage()),
            ),
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: const Row(
              children: [
                Text(
                  '管理空间',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.chevron_right_rounded,
                    size: 16, color: AppColors.primary),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}

/// 3x2 功能宫格。
class _MenuGrid extends StatelessWidget {
  const _MenuGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      (label: '保险箱', icon: Icons.lock_rounded, color: Color(0xFF4A87F8)),
      (label: '健康记录', icon: Icons.monitor_heart_rounded, color: Color(0xFFF5484E)),
      (label: '生活资产', icon: Icons.cottage_rounded, color: Color(0xFFFFA94D)),
      (label: '我的日程', icon: Icons.calendar_month_rounded, color: Color(0xFF9C6BFF)),
      (label: '我的收藏', icon: Icons.star_rounded, color: Color(0xFF3DBB7A)),
      (label: '回收站', icon: Icons.delete_outline_rounded, color: Color(0xFF99A3B9)),
    ];
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Column(
        children: [
          for (var row = 0; row < 2; row++) ...[
            if (row > 0)
              Container(height: 0.7, margin: EdgeInsets.zero, color: AppColors.divider),
            Row(
              children: [
                for (var col = 0; col < 3; col++) ...[
                  if (col > 0)
                    Container(
                      width: 1,
                      height: 52,
                      color: AppColors.divider,
                    ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: switch ((row, col)) {
                        (0, 0) => () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const vault_mod.VaultPage()),
                            ),
                        (0, 1) => () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const health_mod.HealthPage()),
                            ),
                        (0, 2) => () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const assets_mod.AssetsPage()),
                            ),
                        (1, 0) => () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const cal_mod.CalendarPage()),
                            ),
                        (1, 1) => () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const fav_mod.FavoritesPage()),
                            ),
                        (1, 2) => () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const trash_mod.TrashPage()),
                            ),
                        _ => null,
                      },
                      child: Column(
                        children: [
                          Icon(items[row * 3 + col].icon,
                              size: 28, color: items[row * 3 + col].color),
                          const SizedBox(height: 8),
                          Text(
                            items[row * 3 + col].label,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF44507A),
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
        ],
      ),
    );
  }
}

/// 设置列表。
class _SettingsList extends StatelessWidget {
  const _SettingsList();

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        icon: Icons.computer_rounded,
        label: '设备管理',
        trailing: '2 台设备',
      ),
      (icon: Icons.verified_user_rounded, label: '数据安全', trailing: null),
      (icon: Icons.cloud_sync_rounded, label: '同步管理', trailing: '已开启'),
      (icon: Icons.question_answer_rounded, label: '意见反馈', trailing: null),
      (icon: Icons.info_rounded, label: '关于拾记', trailing: 'v1.0.0'),
    ];
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const login_mod.LoginPage()),
            ),
            child: const SizedBox(
              height: 50,
              child: Row(
                children: [
                  SizedBox(width: 2),
                  Icon(Icons.logout_rounded, size: 16, color: AppColors.red),
                  SizedBox(width: 12),
                  Text(
                    '退出登录',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 0.7, color: AppColors.divider),
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              Container(
                height: 0.7,
                margin: const EdgeInsets.only(left: 44),
                color: AppColors.divider,
              ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: switch (i) {
                0 => () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const devices_mod.DevicesPage()),
                    ),
                1 => () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const security_mod.SecurityPage()),
                    ),
                2 => () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const sync_mod.SyncPage()),
                    ),
                3 => () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const feedback_mod.FeedbackPage()),
                    ),
                4 => () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const about_mod.AboutPage()),
                    ),
                _ => null,
              },
              child: SizedBox(
              height: 54,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3EEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(items[i].icon, size: 18, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    items[i].label,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy,
                    ),
                  ),
                  const Spacer(),
                  if (items[i].trailing != null)
                    Text(
                      items[i].trailing!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSub,
                      ),
                    ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right_rounded,
                      size: 20, color: AppColors.chevron),
                ],
              ),
            ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 退出登录卡片。
class _LogoutCard extends StatelessWidget {
  const _LogoutCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const login_mod.LoginPage()),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout_rounded, size: 20, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              '退出登录',
              style: TextStyle(
                fontSize: 15,
                height: 1.0,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
