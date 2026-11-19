import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 私密保险箱页（静态复刻：已解锁状态）。
class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_vault.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '保险箱',
              actionIcon: Icons.settings_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SecurityBanner(),
                  const SizedBox(height: 12),
                  const _VaultSearch(),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        _VaultChip(label: '全部', selected: true),
                        SizedBox(width: 8),
                        _VaultChip(label: '账号'),
                        SizedBox(width: 8),
                        _VaultChip(label: '密码'),
                        SizedBox(width: 8),
                        _VaultChip(label: 'Wi-Fi'),
                        SizedBox(width: 8),
                        _VaultChip(label: '授权码'),
                        SizedBox(width: 8),
                        _VaultChip(label: '安全笔记'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _EntryRow(
                    name: 'GitHub',
                    account: 'user_zhangsan@mail.com',
                    icon: Icons.code_rounded,
                    iconBg: Color(0xFF24292E),
                    action: '复制',
                  ),
                  const SizedBox(height: 10),
                  const _EntryRow(
                    name: '邮箱账户',
                    account: 'zhang***@163.com',
                    icon: Icons.mail_rounded,
                    iconBg: Color(0xFF4A87F8),
                    action: '复制',
                  ),
                  const SizedBox(height: 10),
                  const _EntryRow(
                    name: '家庭 Wi-Fi',
                    account: 'Home_5G',
                    icon: Icons.wifi_rounded,
                    iconBg: Color(0xFF2FB8A8),
                    action: '复制',
                  ),
                  const SizedBox(height: 10),
                  const _EntryRow(
                    name: '公司服务器',
                    account: '192.168.*.*',
                    icon: Icons.dns_rounded,
                    iconBg: Color(0xFFFF9D42),
                    action: '查看',
                  ),
                  const SizedBox(height: 10),
                  const _EntryRow(
                    name: '备用恢复码',
                    account: '安全笔记',
                    icon: Icons.key_rounded,
                    iconBg: Color(0xFF9C6BFF),
                    action: '查看',
                  ),
                ],
              ),
            ),
          ),
          SubPageBottomBar(
            child: GradientPillButton(
              label: '添加条目',
              icon: Icons.add_rounded,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}

/// 安全状态横幅。
class _SecurityBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDDF6EC), Color(0xFFB9EFD9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user_rounded,
              size: 20, color: Color(0xFF3DBB7A)),
          const SizedBox(width: 9),
          const Text(
            '已解锁 · 端到端加密保护中',
            style: TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E9E66),
            ),
          ),
          const Spacer(),
          Text(
            '上次解锁 今天 09:30',
            style: TextStyle(
              fontSize: 10,
              height: 1.0,
              color: Colors.black.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}

/// 保险箱搜索条。
class _VaultSearch extends StatelessWidget {
  const _VaultSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 1),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 19, color: AppColors.textSub),
          SizedBox(width: 10),
          Text(
            '搜索保险箱条目...',
            style: TextStyle(fontSize: 13, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
}

/// 分类胶囊。
class _VaultChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _VaultChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white.withValues(alpha: 0.92)
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.white.withValues(alpha: 0.8),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          height: 1.0,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primary : AppColors.textSub,
        ),
      ),
    );
  }
}

/// 保险箱条目行。
class _EntryRow extends StatelessWidget {
  final String name;
  final String account;
  final IconData icon;
  final Color iconBg;
  final String action;

  const _EntryRow({
    required this.name,
    required this.account,
    required this.icon,
    required this.iconBg,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: 16,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  account,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.9), width: 1),
            ),
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 12,
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
