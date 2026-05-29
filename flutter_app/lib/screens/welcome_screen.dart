import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';
import '../utils/animations.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GradientBackground(
        colors: const [
          AppTheme.primaryColor,
          Color(0xFF5856D6),
          AppTheme.primaryDark,
        ],
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/front.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo
                    AnimatedListItem(
                      index: 0,
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white70],
                          ),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 32,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          LucideIcons.music,
                          size: 64,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // App Name with Animation
                    AnimatedListItem(
                      index: 1,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, Colors.white70],
                        ).createShader(bounds),
                        child: Text(
                          'Melodify',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tagline with Glass Effect
                    AnimatedListItem(
                      index: 2,
                      child: GlassContainer(
                        opacity: 0.15,
                        blur: 20,
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'Your personal music streaming companion.\nDiscover, play, and enjoy unlimited music in stunning quality.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Sign Up Button with Animation
                    AnimatedListItem(
                      index: 3,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: GlassButton(
                          isPrimary: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransitions.slideFromRight(
                                  const SignUpScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get Started',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(LucideIcons.arrowRight,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sign In Button
                    AnimatedListItem(
                      index: 4,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: GlassButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransitions.slideFromRight(
                                  const SignInScreen()),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Continue as Guest
                    AnimatedListItem(
                      index: 5,
                      child: TextButton(
                        onPressed: () {
                          context.read<AuthProvider>().continueAsGuest();
                        },
                        child: Text(
                          'Continue as Guest',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
