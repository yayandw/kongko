import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/widgets/input.dart';
import '../../core/widgets/sliding.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 72, left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              Text(
                'Kongko',
                style: TextStyle(fontFamily: 'Matemasie', fontSize: 64),
              ),
              const SizedBox(height: 24),
              const _AuthCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthCard extends StatefulWidget {
  const _AuthCard();

  @override
  State<_AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<_AuthCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SlidingSegmentedControl(
          labels: ['LOGIN', 'REGISTER'],
          children: [const _LoginPage(), const Text('REG')],
        ),
      ),
    );
  }
}

class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          labelText: 'Email Address',
          prefixIcon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        CustomInputField(
          labelText: 'Password',
          prefixIcon: Icons.lock_outline_rounded,
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() => _rememberMe = value!);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                const Text(
                  'Remember me',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3D8BF8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3D8BF8),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 2,
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: const [
            Expanded(
              child: Divider(color: Color(0xFFDDE1E7), thickness: 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Or login with',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9AA5B4),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: Color(0xFFDDE1E7), thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _SocialLoginButton(
                label: 'Google',
                icon: SvgPicture.asset(
                  'assets/icons/google.svg',
                  width: 22,
                  height: 22,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SocialLoginButton(
                label: 'Apple',
                icon: SvgPicture.asset(
                  'assets/icons/apple.svg',
                  width: 22,
                  height: 22,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}