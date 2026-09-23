import 'package:flutter/cupertino.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF5B4FE9),
        scaffoldBackgroundColor: Color(0xFFF8F8FA),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: '.SF Pro Display',
            color: Color(0xFF111113),
          ),
        ),
      ),
      home: WelcomePage(),
    );
  }
}

// ============================================================================
// PAGE
// ============================================================================

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isSubmitting = false;
  bool showSuccess = false;

  String selectedGender = 'Male';

  final Set<String> selectedCourses = {'Machine Learning', 'Full stack'};

  double tuition = 500;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // FORM ACTIONS
  // --------------------------------------------------------------------------

  void toggleCourse(String course) {
    setState(() {
      if (selectedCourses.contains(course)) {
        selectedCourses.remove(course);
      } else {
        selectedCourses.add(course);
      }
    });
  }

  void clearForm() {
    setState(() {
      usernameController.clear();
      passwordController.clear();

      selectedGender = 'Male';

      selectedCourses
        ..clear()
        ..add('Machine Learning')
        ..add('Full stack');

      tuition = 500;
    });
  }

  Future<void> submit() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.length < 10) {
      showToast('Username must be at least 10 characters');
      return;
    }

    if (password.length < 8) {
      showToast('Password must be at least 8 characters');
      return;
    }

    if (selectedCourses.isEmpty) {
      showToast('Select at least one course');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      isSubmitting = false;
      showSuccess = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showSuccess = false;
        });
      }
    });
  }

  void showToast(String message) {
    setState(() {
      showSuccess = false;
    });

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Check your details'),
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(message),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  // --------------------------------------------------------------------------
  // BUILD
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F8FA),

      child: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 34, 24, 50),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ====================================================
                      // HEADER
                      // ====================================================

                      const Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.8,
                          height: 1.05,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Let’s get you set up.',
                        style: TextStyle(
                          fontSize: 17,
                          color: const Color(0xFF77777F),
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.2,
                        ),
                      ),

                      const SizedBox(height: 46),

                      // ====================================================
                      // ACCOUNT
                      // ====================================================
                      const SectionTitle(title: 'ACCOUNT'),

                      const SizedBox(height: 16),

                      const FieldTitle(title: 'Username'),

                      const SizedBox(height: 8),

                      CupertinoTextField(
                        controller: usernameController,
                        placeholder: 'Enter your username',
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 16,
                        ),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        placeholderStyle: const TextStyle(
                          color: Color(0xFFA4A4AB),
                          fontSize: 16,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      const SizedBox(height: 22),

                      const FieldTitle(title: 'Password'),

                      const SizedBox(height: 8),

                      CupertinoTextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        placeholder: 'Enter your password',
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 16,
                        ),
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        placeholderStyle: const TextStyle(
                          color: Color(0xFFA4A4AB),
                          fontSize: 16,
                        ),
                        suffix: CupertinoButton(
                          padding: const EdgeInsets.only(right: 14),
                          minSize: 0,
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(
                            obscurePassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            size: 19,
                            color: const Color(0xFF77777F),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      const SizedBox(height: 46),

                      // ====================================================
                      // GENDER
                      // ====================================================
                      const SectionTitle(title: 'GENDER'),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            child: SelectionTile(
                              title: 'Male',
                              icon: CupertinoIcons.person,
                              selected: selectedGender == 'Male',
                              onTap: () {
                                setState(() {
                                  selectedGender = 'Male';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SelectionTile(
                              title: 'Female',
                              icon: CupertinoIcons.person,
                              selected: selectedGender == 'Female',
                              onTap: () {
                                setState(() {
                                  selectedGender = 'Female';
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 46),

                      // ====================================================
                      // COURSES
                      // ====================================================
                      const SectionTitle(title: 'COURSES'),

                      const SizedBox(height: 7),

                      Text(
                        'Choose the courses you’re interested in.',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF8A8A92),
                        ),
                      ),

                      const SizedBox(height: 15),

                      CourseTile(
                        title: 'Machine Learning',
                        subtitle: 'AI, data & intelligent systems',
                        selected: selectedCourses.contains('Machine Learning'),
                        onTap: () {
                          toggleCourse('Machine Learning');
                        },
                      ),

                      const SizedBox(height: 10),

                      CourseTile(
                        title: 'Full stack',
                        subtitle: 'Frontend, backend & databases',
                        selected: selectedCourses.contains('Full stack'),
                        onTap: () {
                          toggleCourse('Full stack');
                        },
                      ),

                      const SizedBox(height: 10),

                      CourseTile(
                        title: 'Mobile application',
                        subtitle: 'Build iOS & Android applications',
                        selected: selectedCourses.contains(
                          'Mobile application',
                        ),
                        onTap: () {
                          toggleCourse('Mobile application');
                        },
                      ),

                      const SizedBox(height: 46),

                      // ====================================================
                      // TUITION
                      // ====================================================
                      const SectionTitle(title: 'TUITION'),

                      const SizedBox(height: 13),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${tuition.round()}',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              'per course',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFF888890),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 3),

                      CupertinoSlider(
                        value: tuition,
                        min: 100,
                        max: 1000,
                        divisions: 18,
                        activeColor: const Color(0xFF5B4FE9),
                        thumbColor: const Color(0xFF5B4FE9),
                        onChanged: (value) {
                          setState(() {
                            tuition = value;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$100',
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xFF9999A1),
                              ),
                            ),
                            Text(
                              '\$1,000',
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xFF9999A1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),

                      // ====================================================
                      // ACTIONS
                      // ====================================================
                      SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(17),
                          color: const Color(0xFF5B4FE9),
                          disabledColor: const Color(0xFFAAA5E8),
                          onPressed: isSubmitting ? null : submit,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: isSubmitting
                                ? const CupertinoActivityIndicator(
                                    key: ValueKey('loading'),
                                    color: CupertinoColors.white,
                                  )
                                : const Text(
                                    'Continue',
                                    key: ValueKey('continue'),
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 13),

                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: clearForm,
                          child: const Text(
                            'Clear form',
                            style: TextStyle(
                              color: Color(0xFF77777F),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Text(
                          'Your information stays private.',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFFAAAAAF),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          // ================================================================
          // SUCCESS TOAST
          // ================================================================
          IgnorePointer(
            child: AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              left: 20,
              right: 20,
              bottom: showSuccess ? 24 : -100,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF202024),
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withOpacity(0.16),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Color(0xFF72D572),
                        size: 23,
                      ),
                      SizedBox(width: 11),
                      Text(
                        'Submitted successfully',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        color: Color(0xFF7C7C84),
      ),
    );
  }
}

// ============================================================================
// FIELD TITLE
// ============================================================================

class FieldTitle extends StatelessWidget {
  final String title;

  const FieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
      ),
    );
  }
}

// ============================================================================
// GENDER SELECTION
// ============================================================================

class SelectionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const SelectionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEDEAFC) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFF5B4FE9) : const Color(0xFFE5E5E9),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected
                  ? const Color(0xFF5B4FE9)
                  : const Color(0xFF888890),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? const Color(0xFF4035C4)
                      : const Color(0xFF333338),
                ),
              ),
            ),
            AnimatedScale(
              scale: selected ? 1 : 0,
              duration: const Duration(milliseconds: 180),
              child: const Icon(
                CupertinoIcons.check_mark,
                size: 17,
                color: Color(0xFF5B4FE9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// COURSE TILE
// ============================================================================

class CourseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const CourseTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF0EEFF) : CupertinoColors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected ? const Color(0xFFD8D3FF) : const Color(0xFFE7E7EB),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF5B4FE9)
                    : CupertinoColors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF5B4FE9)
                      : const Color(0xFFC8C8CE),
                  width: 1.5,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: selected
                    ? const Icon(
                        CupertinoIcons.check_mark,
                        key: ValueKey('check'),
                        color: CupertinoColors.white,
                        size: 14,
                      )
                    : const SizedBox(key: ValueKey('empty')),
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF92929A),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              CupertinoIcons.chevron_right,
              size: 14,
              color: Color(0xFFB2B2B8),
            ),
          ],
        ),
      ),
    );
  }
}
