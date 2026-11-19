import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 登录 / 注册页（静态复刻）。
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_home.png',
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: RoundGlassButton(
                icon: Icons.close_rounded,
                onTap: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo 区
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        '拾记',
                        style: TextStyle(
                          fontSize: 28,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '收藏生活 · 记录美好',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.0,
                          color: Color(0xFF6E7BA8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  // 登录 / 注册 Tab
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              '登录',
                              style: TextStyle(
                                fontSize: 17,
                                height: 1.0,
                                fontWeight: FontWeight.w800,
                                color: AppColors.navy,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Container(
                              width: 22,
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          '注册',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSub,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // 手机号输入
                  _InputField(
                    icon: Icons.phone_iphone_rounded,
                    hint: '请输入手机号',
                    suffix: '获取验证码',
                  ),
                  const SizedBox(height: 12),
                  const _InputField(
                    icon: Icons.lock_outline_rounded,
                    hint: '请输入验证码',
                  ),
                  const SizedBox(height: 10),
                  // 协议
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.gradBlue,
                        ),
                        child: const Icon(Icons.check_rounded,
                            size: 12, color: Colors.white),
                      ),
                      const SizedBox(width: 6),
                      const Flexible(
                        child: Text(
                          '已阅读并同意《用户协议》和《隐私政策》',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.0,
                            color: AppColors.textSub,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const GradientPillButton(
                    label: '登录',
                    icon: Icons.login_rounded,
                    height: 50,
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: Text(
                      '登录即建立账号身份，资料默认保存在本机',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.0,
                        color: AppColors.textLight,
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

class _InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String? suffix;

  const _InputField({
    required this.icon,
    required this.hint,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.9), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSub),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              hint,
              style: const TextStyle(
                fontSize: 14,
                height: 1.0,
                color: AppColors.textLight,
              ),
            ),
          ),
          if (suffix != null)
            Text(
              suffix!,
              style: const TextStyle(
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
