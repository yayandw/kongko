import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/widgets/dialog.dart';
import '../../core/widgets/input.dart';
import '../../core/widgets/sliding.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 72, left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              _KongkoTitle(),
              SizedBox(height: 24),
              _AuthCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _KongkoTitle extends StatelessWidget {
  const _KongkoTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Kongko',
      style: TextStyle(fontFamily: 'Matemasie', fontSize: 64),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SlidingSegmentedControl(
          labels: const ['LOGIN', 'REGISTER'],
          children: const [_LoginPage(), Text('REG')],
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      showLoginSuccessDialog(context);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Invalid email format';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            controller: _emailController,
            labelText: 'Email Address',
            hintText: 'Input email here..',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          const SizedBox(height: 24),
          CustomInputField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Input password here..',
            prefixIcon: Icons.lock_outline_rounded,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: _validatePassword,
          ),
          _RememberMeRow(
            rememberMe: _rememberMe,
            onChanged: (value) => setState(() => _rememberMe = value!),
          ),
          const SizedBox(height: 24),
          _LoginButton(onPressed: _handleLogin),
          const SizedBox(height: 36),
          const _OrDivider(),
          const SizedBox(height: 36),
          _SocialLoginRow(),
        ],
      ),
    );
  }
}

class _RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onChanged;

  const _RememberMeRow({
    required this.rememberMe,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const Text(
              'Remember me',
              style: TextStyle(fontSize: 12, color: Color(0xFF263238)),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF3D8BF8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFDDE1E7), thickness: 1)),
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
        Expanded(child: Divider(color: Color(0xFFDDE1E7), thickness: 1)),
      ],
    );
  }
}

class _SocialLoginRow extends StatelessWidget {
  const _SocialLoginRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialLoginButton(
            label: 'Google',
            icon: SvgPicture.asset('assets/icons/google.svg', width: 22, height: 22),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SocialLoginButton(
            label: 'Apple',
            icon: SvgPicture.asset('assets/icons/apple.svg', width: 22, height: 22),
            onPressed: () {},
          ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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