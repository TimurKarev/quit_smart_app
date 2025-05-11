import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quit_smart_app/routing/app_router.dart';
import 'package:quit_smart_app/ui/theme/color_palette.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Account')),
        backgroundColor: ColorPalette.neutral50, // bg-neutral-50
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 32.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400), // max-w-md
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Logo Section
                  Column(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.lungs,
                        size: 40,
                        color: ColorPalette.neutral700, // text-neutral-700
                      ),
                      const SizedBox(height: 16.0), // mb-4 equivalent
                      Text(
                        'QuitSmart',
                        style: textTheme.headlineMedium?.copyWith(
                          color: ColorPalette.neutral900,
                          fontWeight: FontWeight.w600, // Tailwind text-3xl is often bold
                        ), // text-neutral-900
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0), // mt-2
                      Text(
                        'Create your account',
                        style: textTheme.titleSmall?.copyWith(
                          color: ColorPalette.neutral600,
                        ), // text-neutral-600
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 48.0), // mb-12

                  // Social Sign Up Buttons
                  _SocialAuthButton(
                    icon: FontAwesomeIcons.google,
                    text: 'Sign up with Google',
                    onPressed: () {
                      // TODO: Implement Google sign up
                      print('Google Sign Up Tapped');
                    },
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 16.0), // space-y-4 implies spacing between items
                  _SocialAuthButton(
                    icon: FontAwesomeIcons.apple,
                    text: 'Sign up with Apple',
                    onPressed: () {
                      // TODO: Implement Apple sign up
                      print('Apple Sign Up Tapped');
                    },
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 20.0), // py-5 equivalent for spacing

                  // Or Divider
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider(color: ColorPalette.neutral300, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or',
                          style: textTheme.bodySmall?.copyWith(color: ColorPalette.neutral600),
                        ),
                      ),
                      Expanded(child: Divider(color: ColorPalette.neutral300, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 20.0), // py-5 equivalent for spacing

                  // Email Sign Up Form
                  _buildTextField(
                    labelText: 'Your Name',
                    hintText: 'Enter your name',
                    borderColor: ColorPalette.neutral300,
                    focusBorderColor: ColorPalette.neutral500,
                    labelColor: ColorPalette.neutral700,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 16.0), // space-y-4 implies spacing between items
                  _buildTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    borderColor: ColorPalette.neutral300,
                    focusBorderColor: ColorPalette.neutral500,
                    labelColor: ColorPalette.neutral700,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                    labelText: 'Password',
                    hintText: 'Create a password',
                    obscureText: true,
                    borderColor: ColorPalette.neutral300,
                    focusBorderColor: ColorPalette.neutral500,
                    labelColor: ColorPalette.neutral700,
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 16.0),

                  // Create Account Button
                  ElevatedButton.icon(
                    icon: const FaIcon(FontAwesomeIcons.envelope, size: 20),
                    label: Text('Create Account', style: textTheme.labelLarge?.copyWith(color: ColorPalette.baseWhite, fontWeight: FontWeight.w500)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.neutral800, // bg-neutral-800
                      foregroundColor: ColorPalette.baseWhite, // text-white
                      padding: const EdgeInsets.symmetric(vertical: 16.0), // py-3
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // rounded-lg
                      ),
                      elevation: 0,
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return ColorPalette.neutral700; // hover:bg-neutral-700
                          return ColorPalette.neutral800;
                        },
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement create account
                      print('Create Account Tapped');
                    },
                  ),
                  const SizedBox(height: 32.0), // mt-8

                  // Sign In Link
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.bodyMedium?.copyWith(color: ColorPalette.neutral600),
                      children: <TextSpan>[
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: ColorPalette.neutral900, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            GoRouter.of(context).replace(AppRoutes.signIn); // Navigate to Sign In Page
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32.0), // mt-8

                  // Terms
                  Column(
                    children: [
                      Text(
                        'By continuing, you agree to our',
                        style: textTheme.bodySmall?.copyWith(color: ColorPalette.neutral500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textTheme.bodySmall?.copyWith(color: ColorPalette.neutral500),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // TODO: Navigate to Terms of Service
                                print('Terms Tapped');
                              },
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // TODO: Navigate to Privacy Policy
                                print('Privacy Tapped');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0), // Ensure some padding at the bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
    required Color borderColor,
    required Color focusBorderColor,
    required Color labelColor,
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: textTheme.bodySmall?.copyWith(
            color: labelColor,
          ), // text-sm
        ),
        const SizedBox(height: 8.0), // space-y-2
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: borderColor, // Placeholder color often matches border
            ),
            filled: true,
            fillColor: ColorPalette.baseWhite, // bg-white
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0, // px-4
              vertical: 12.0,   // py-3
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // rounded-lg
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: focusBorderColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// Re-using a similar structure to _SocialButton from SignInPage
class _SocialAuthButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final TextTheme textTheme;

  const _SocialAuthButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.textTheme,
  });

  @override
  State<_SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<_SocialAuthButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton.icon(
        icon: FaIcon(widget.icon, size: 20, color: ColorPalette.neutral800), // text-xl, text-neutral-800 for icon
        label: Text(
          widget.text,
          style: widget.textTheme.bodyMedium?.copyWith(
            color: ColorPalette.neutral800, // text-neutral-800
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: _isHovered ? ColorPalette.neutral50 : ColorPalette.baseWhite, // hover:bg-neutral-50
          side: const BorderSide(color: ColorPalette.neutral200), // border-neutral-200
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), // px-6 py-3
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // rounded-lg
          ),
          elevation: _isHovered ? 1 : 0, // shadow-sm equivalent on hover
        ).copyWith(
          foregroundColor: MaterialStateProperty.all(ColorPalette.neutral800),
        ),
      ),
    );
  }
}