import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';

/// Login page – email + password form wired to [AuthNotifier].
///
/// GoRouter's `refreshListenable` automatically navigates away once login
/// succeeds; this page only needs to trigger [AuthNotifier.login].
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "hucelsoft@gmail.com");
  final _passwordController = TextEditingController(text: "Halil123");
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<AuthNotifier>().login(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    final isLoading = auth.isLoading;
    final error = auth.errorMessage;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Brand ──────────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.apartment,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'ApartmanYönet',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Sign in to your account',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              ),
              const SizedBox(height: 32),

              // ── Card ───────────────────────────────────────────────────────
              Container(
                width: 400,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 24,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email
                      _FieldLabel(label: 'Email address'),
                      const SizedBox(height: 6),
                      TextFormField(
                        key: const Key('login_email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        enabled: !isLoading,
                        decoration: _inputDecoration(
                          hint: 'you@example.com',
                          icon: Icons.email_outlined,
                        ),
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 20),

                      // Password
                      _FieldLabel(label: 'Password'),
                      const SizedBox(height: 6),
                      TextFormField(
                        key: const Key('login_password'),
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        enabled: !isLoading,
                        onFieldSubmitted: (_) => _submit(),
                        decoration:
                            _inputDecoration(
                              hint: '••••••••',
                              icon: Icons.lock_outline,
                            ).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF94A3B8),
                                  size: 18,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ),
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Enter your password.'
                            : null,
                      ),
                      const SizedBox(height: 8),

                      // Error banner
                      if (error != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.error.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  error,
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: context.read<AuthNotifier>().clearError,
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.error,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Submit button
                      FilledButton(
                        key: const Key('login_submit'),
                        onPressed: isLoading ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
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
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) => InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon, size: 18, color: const Color(0xFF94A3B8)),
    filled: true,
    fillColor: const Color(0xFFF8FAFC),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.error),
    ),
  );

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter your email address.';
    final emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRe.hasMatch(v.trim())) return 'Enter a valid email address.';
    return null;
  }
}

// ── Small helper widgets ──────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xFF374151),
    ),
  );
}
