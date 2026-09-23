import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF5B4BDB),
        scaffoldBackgroundColor: Color(0xFFF6F6FA),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: '.SF Pro Display',
            color: Color(0xFF17171B),
          ),
        ),
      ),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  String selectedSex = 'Male';

  final Set<String> selectedCourses = {'Machine Learning', 'Full stack'};

  double tuition = 500;

  bool isSubmitting = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleCourse(String course) {
    setState(() {
      if (selectedCourses.contains(course)) {
        selectedCourses.remove(course);
      } else {
        selectedCourses.add(course);
      }
    });
  }

  Future<void> submit() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.length < 10) {
      showMessage('Username must be at least 10 characters');
      return;
    }

    if (password.length < 8) {
      showMessage('Password must be at least 8 characters');
      return;
    }

    if (selectedCourses.isEmpty) {
      showMessage('Please select at least one course');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      isSubmitting = false;
    });

    showMessage('Submitted successfully 🎉', success: true);
  }

  void clearForm() {
    setState(() {
      usernameController.clear();
      passwordController.clear();

      selectedSex = 'Male';

      selectedCourses.clear();

      tuition = 500;
    });
  }

  void showMessage(String message, {bool success = false}) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });

        return SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF24242C),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 25,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: success
                              ? const Color(0xFF65C466)
                              : const Color(0xFFFF6B6B),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          success
                              ? CupertinoIcons.check_mark
                              : CupertinoIcons.exclamationmark,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----------------------------------------------------------
                // HEADER
                // ----------------------------------------------------------

                const Text(
                  'Welcome back.',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.2,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Complete your details to continue.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 30),

                // ----------------------------------------------------------
                // FORM CARD
                // ----------------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.045),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ----------------------------------------------------
                      // USERNAME
                      // ----------------------------------------------------

                      const FormLabel(
                        title: 'Username',
                        subtitle: 'Enter your username',
                      ),

                      const SizedBox(height: 10),

                      CupertinoTextField(
                        controller: usernameController,
                        placeholder: 'Username',
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ----------------------------------------------------
                      // PASSWORD
                      // ----------------------------------------------------
                      const FormLabel(
                        title: 'Password',
                        subtitle: 'Use at least 8 characters',
                      ),

                      const SizedBox(height: 10),

                      CupertinoTextField(
                        controller: passwordController,
                        placeholder: 'Password',
                        obscureText: obscurePassword,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        suffix: CupertinoButton(
                          padding: const EdgeInsets.only(right: 14),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(
                            obscurePassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ----------------------------------------------------
                      // SEX
                      // ----------------------------------------------------
                      const FormLabel(title: 'Sex', subtitle: 'Choose one'),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          GenderOption(
                            title: 'Male',
                            value: 'Male',
                            selected: selectedSex == 'Male',
                            onTap: () {
                              setState(() {
                                selectedSex = 'Male';
                              });
                            },
                          ),
                          const SizedBox(width: 28),
                          GenderOption(
                            title: 'Female',
                            value: 'Female',
                            selected: selectedSex == 'Female',
                            onTap: () {
                              setState(() {
                                selectedSex = 'Female';
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // ----------------------------------------------------
                      // COURSES
                      // ----------------------------------------------------
                      const FormLabel(
                        title: 'Courses',
                        subtitle: 'Select everything you are interested in',
                      ),

                      const SizedBox(height: 12),

                      CourseOption(
                        title: 'Machine Learning',
                        selected: selectedCourses.contains('Machine Learning'),
                        onTap: () {
                          toggleCourse('Machine Learning');
                        },
                      ),

                      CourseOption(
                        title: 'Full stack',
                        selected: selectedCourses.contains('Full stack'),
                        onTap: () {
                          toggleCourse('Full stack');
                        },
                      ),

                      CourseOption(
                        title: 'Mobile application',
                        selected: selectedCourses.contains(
                          'Mobile application',
                        ),
                        onTap: () {
                          toggleCourse('Mobile application');
                        },
                      ),

                      const SizedBox(height: 26),

                      // ----------------------------------------------------
                      // TUITION
                      // ----------------------------------------------------
                      const FormLabel(
                        title: 'Tuition',
                        subtitle: 'How much are you comfortable paying?',
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${tuition.round()}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.8,
                            ),
                          ),
                          Text(
                            '\$1000',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      CupertinoSlider(
                        value: tuition,
                        min: 100,
                        max: 1000,
                        divisions: 18,
                        activeColor: const Color(0xFF5B4BDB),
                        onChanged: (value) {
                          setState(() {
                            tuition = value;
                          });
                        },
                      ),

                      const SizedBox(height: 22),

                      // ----------------------------------------------------
                      // BUTTONS
                      // ----------------------------------------------------
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: CupertinoButton.filled(
                          borderRadius: BorderRadius.circular(16),
                          onPressed: isSubmitting ? null : submit,
                          child: isSubmitting
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFFF1F1F4),
                          onPressed: clearForm,
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: Color(0xFF55555E),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    'Your information is kept private.',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FORM LABEL
// ============================================================================

class FormLabel extends StatelessWidget {
  final String title;
  final String subtitle;

  const FormLabel({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

// ============================================================================
// GENDER OPTION
// ============================================================================

class GenderOption extends StatelessWidget {
  final String title;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const GenderOption({
    super.key,
    required this.title,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: selected
                    ? const Color(0xFF5B4BDB)
                    : const Color(0xFFD0D0D5),
              ),
            ),
            child: AnimatedScale(
              scale: selected ? 1 : 0,
              duration: const Duration(milliseconds: 180),
              child: Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5B4BDB),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// COURSE OPTION
// ============================================================================

class CourseOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CourseOption({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF5B4BDB) : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  width: 1.8,
                  color: selected
                      ? const Color(0xFF5B4BDB)
                      : const Color(0xFFD0D0D5),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: selected
                    ? const Icon(
                        CupertinoIcons.check_mark,
                        key: ValueKey('checked'),
                        color: Colors.white,
                        size: 15,
                      )
                    : const SizedBox(key: ValueKey('unchecked')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
