import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quit_smart_app/features/auth/ui/bloc/auth/auth_bloc.dart';
import 'package:quit_smart_app/ui/theme/color_palette.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
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
                      FaIcon(
                        FontAwesomeIcons.lungs,
                        size: 40,
                        color: ColorPalette.neutral700, // text-neutral-700
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'QuitSmart',
                        style: textTheme.headlineMedium?.copyWith(
                          color: ColorPalette.neutral900,
                          fontWeight: FontWeight.w600,
                        ), // text-neutral-900
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Your journey to a smoke-free life starts here',
                        style: textTheme.titleSmall?.copyWith(
                          color: ColorPalette.neutral600,
                        ), // text-neutral-600
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 48.0), // mb-12
                  // Auth Container
                  // Email Field
                  _buildTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    borderColor: ColorPalette.neutral300, // border-neutral-300
                    focusBorderColor:
                        ColorPalette.neutral500, // focus:border-neutral-500
                    labelColor: ColorPalette.neutral700, // text-neutral-700
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 16.0),

                  // Password Field
                  _buildTextField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    borderColor: ColorPalette.neutral300, // border-neutral-300
                    focusBorderColor:
                        ColorPalette.neutral500, // focus:border-neutral-500
                    labelColor: ColorPalette.neutral700, // text-neutral-700
                    textTheme: textTheme,
                  ),
                  const SizedBox(height: 8.0),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: 'Forgot Password?',
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorPalette.neutral700,
                        ), // text-neutral-700
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: Implement forgot password
                                print('Forgot Password Tapped');
                              },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Sign In Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ColorPalette.neutral800, // bg-neutral-800
                      foregroundColor: ColorPalette.baseWhite, // text-white
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                    ).copyWith(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>((
                            Set<MaterialState> states,
                          ) {
                            if (states.contains(MaterialState.hovered))
                              return ColorPalette
                                  .neutral700; // hover:bg-neutral-700
                            return ColorPalette.neutral800;
                          }),
                    ),
                    onPressed: () {
                      // TODO: Implement sign in
                      print('Sign In Tapped');
                    },
                    child: Text(
                      'Sign In',
                      style: textTheme.labelLarge?.copyWith(
                        color: ColorPalette.baseWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0), // py-5 equivalent for spacing
                  // Or continue with
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: ColorPalette.neutral300,
                          thickness: 1,
                        ),
                      ), // border-neutral-300
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or continue with',
                          style: textTheme.bodySmall?.copyWith(
                            color: ColorPalette.neutral600,
                          ), // text-neutral-600
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: ColorPalette.neutral300,
                          thickness: 1,
                        ),
                      ), // border-neutral-300
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Social Buttons
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _SocialButton(
                          icon: FontAwesomeIcons.google,
                          text: 'Google',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthGoogleSignInRequested(),
                            );
                          },
                          borderColor:
                              ColorPalette.neutral200, // border-neutral-200
                          textColor:
                              ColorPalette.neutral800, // text-neutral-800
                          hoverBgColor:
                              ColorPalette.neutral50, // hover:bg-neutral-50
                          iconColor: ColorPalette.error, // Google Red
                          textTheme: textTheme,
                        ),
                      ),
                      const SizedBox(width: 16.0), // gap-4
                      Expanded(
                        child: _SocialButton(
                          icon: FontAwesomeIcons.apple,
                          text: 'Apple',
                          onPressed: () {
                            // TODO: Implement Apple sign in
                            print('Apple Sign In Tapped');
                          },
                          borderColor:
                              ColorPalette.neutral200, // border-neutral-200
                          textColor:
                              ColorPalette.neutral800, // text-neutral-800
                          hoverBgColor:
                              ColorPalette.neutral50, // hover:bg-neutral-50
                          iconColor:
                              ColorPalette.neutral800, // Apple icon color
                          textTheme: textTheme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0), // mt-8
                  // Sign Up Link
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.bodyMedium?.copyWith(
                        color: ColorPalette.neutral600,
                      ), // text-neutral-600
                      children: <TextSpan>[
                        const TextSpan(text: 'New to QuitSmart? '),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: ColorPalette.neutral900,
                            decoration: TextDecoration.underline,
                          ), // text-neutral-900
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // GoRouter.of(
                                  //   context,
                                  // ).replace(AppRoutes.createAccount);
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
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorPalette.neutral500,
                        ), // text-neutral-500
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textTheme.bodySmall?.copyWith(
                            color: ColorPalette.neutral500,
                          ), // text-neutral-500
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // TODO: Navigate to Terms of Service
                                      print('Terms Tapped');
                                    },
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // TODO: Navigate to Privacy Policy
                                      print('Privacy Tapped');
                                    },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          ), // text-sm, using bodySmall as an equivalent
        ),
        const SizedBox(height: 8.0), // space-y-2
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: borderColor,
            ), // Assuming placeholder has same color as border initially
            filled: true,
            fillColor: ColorPalette.baseWhite,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ), // px-4 py-3
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: focusBorderColor,
                width: 1.5,
              ), // focus:ring-1 focus:ring-neutral-500
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final Color hoverBgColor;
  final Color iconColor;
  final TextTheme textTheme;

  const _SocialButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.borderColor,
    required this.textColor,
    required this.hoverBgColor,
    required this.iconColor,
    required this.textTheme,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton.icon(
        icon: FaIcon(widget.icon, size: 20, color: widget.iconColor), // text-xl
        label: Text(
          widget.text,
          style: widget.textTheme.bodyMedium?.copyWith(
            color: widget.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              _isHovered
                  ? widget.hoverBgColor
                  : ColorPalette.baseWhite, // bg-white or hover:bg-neutral-50
          side: BorderSide(color: widget.borderColor),
          padding: const EdgeInsets.symmetric(vertical: 12.0), // py-3
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: _isHovered ? 1 : 0, // Simulate shadow-sm on hover
        ).copyWith(
          foregroundColor: MaterialStateProperty.all(widget.textColor),
        ),
      ),
    );
  }
}
