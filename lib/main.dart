import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// Pastel palette
const _teal = Color(0xFF9B8ED6); // pastel lavender-violet (primary accent)
const _ink = Color(0xFF5B5470); // soft plum for headings/text
const _muted = Color(0xFF9C93AD); // muted lavender-grey for secondary text

class StudentSettings {
  StudentSettings({
    this.name = 'Rahul Patel',
    this.enrollmentNo = '24CE001',
    this.department = 'Computer Engineering',
    this.semester = 'Semester V',
    this.language = 'English',
    this.darkMode = false,
    this.assignmentAlerts = true,
    this.examNotifications = true,
    this.placementUpdates = true,
    this.eventAnnouncements = true,
    this.cardScale = 0.5,
    Set<String>? courses,
  }) : courses = courses ?? {
          'Mobile Application Development',
          'Artificial Intelligence',
        };

  String name;
  String enrollmentNo;
  String department;
  String semester;
  String language;
  bool darkMode;
  bool assignmentAlerts;
  bool examNotifications;
  bool placementUpdates;
  bool eventAnnouncements;
  double cardScale;
  Set<String> courses;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _settings = StudentSettings();

  void _updateSettings(void Function(StudentSettings settings) update) {
    setState(() => update(_settings));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campusly',
      debugShowCheckedModeBanner: false,
      themeMode: _settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _teal),
        scaffoldBackgroundColor: const Color(0xFFFAF6FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: _ink,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _ink,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFECE4FB), width: 1),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFE3DBF9),
          elevation: 4,
          labelTextStyle: WidgetStatePropertyAll(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: _teal,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _teal,
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6DDF7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _teal, width: 1.5),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _teal,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF221E30),
        cardTheme: CardThemeData(
          color: const Color(0xFF332C47),
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: SplashScreen(
        settings: _settings,
        onSettingsChanged: _updateSettings,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _teal,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Campusly',
                style: TextStyle(
                  color: _ink,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your campus, organized.',
                style: TextStyle(color: _muted, fontSize: 18),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(
                        settings: settings,
                        onSettingsChanged: onSettingsChanged,
                      ),
                    ),
                  ),
                  child: const Text('Get started'),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'SMART STUDENT COMPANION',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 11,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(
            settings: widget.settings,
            onSettingsChanged: widget.onSettingsChanged,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Sign in to pick up where you left off.',
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            AppField(
              controller: _emailController,
              label: 'University email',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || !value.contains('@')
                  ? 'Enter a valid university email'
                  : null,
            ),
            const SizedBox(height: 14),
            AppField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock_outline_rounded,
              obscureText: true,
              validator: (value) => value == null || value.length < 6
                  ? 'Password must be at least 6 characters'
                  : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _login,
                child: const Text('Sign in'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'OR',
                    style: TextStyle(color: _muted, fontSize: 12),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RegistrationScreen(
                    settings: widget.settings,
                    onSettingsChanged: widget.onSettingsChanged,
                  ),
                ),
              ),
              child: const Text("Don't have an account? Create one"),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(
            settings: widget.settings,
            onSettingsChanged: widget.onSettingsChanged,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create your account',
      subtitle: 'A smarter way to stay on top of campus life.',
      form: Form(
        key: _formKey,
        child: Column(
          children: [
            AppField(
              controller: _name,
              label: 'Full name',
              icon: Icons.person_outline_rounded,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter your full name'
                  : null,
            ),
            const SizedBox(height: 14),
            AppField(
              controller: _email,
              label: 'University email',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || !value.contains('@')
                  ? 'Enter a valid email'
                  : null,
            ),
            const SizedBox(height: 14),
            AppField(
              controller: _password,
              label: 'Create password',
              icon: Icons.lock_outline_rounded,
              obscureText: true,
              validator: (value) => value == null || value.length < 6
                  ? 'Use at least 6 characters'
                  : null,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _register,
                child: const Text('Create account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.form,
  });
  final String title;
  final String subtitle;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const SizedBox(height: 34),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(color: _muted, fontSize: 16),
              ),
              const SizedBox(height: 34),
              form,
            ],
          ),
        ),
      ),
    );
  }
}

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    obscureText: obscureText,
    keyboardType: keyboardType,
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
  );
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  Widget build(BuildContext context) => MainShell(
    settings: settings,
    onSettingsChanged: onSettingsChanged,
  );
}

class ModuleCard extends StatelessWidget {
  const ModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: _teal, size: 22),
            ),
            Text(
              title,
              style: const TextStyle(
                color: _ink,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ],
        ),
      ),
    ),
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Student profile'),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const CircleAvatar(
          radius: 44,
          backgroundColor: Color(0xFFE3DBF9),
          child: Text(
            'RP',
            style: TextStyle(
              fontSize: 28,
              color: _teal,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Rahul Patel',
            style: TextStyle(
              color: _ink,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            'Computer Engineering  •  Semester V',
            style: TextStyle(color: _muted),
          ),
        ),
        const SizedBox(height: 30),
        const ProfileInfo(
          label: 'University email',
          value: 'rahul.patel@university.edu',
          icon: Icons.mail_outline_rounded,
        ),
        const ProfileInfo(
          label: 'Student ID',
          value: '24CE001',
          icon: Icons.badge_outlined,
        ),
        const ProfileInfo(
          label: 'Campus',
          value: 'Main Campus',
          icon: Icons.location_on_outlined,
        ),
      ],
    ),
  );
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 6),
    leading: Icon(icon, color: _teal),
    title: Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
    subtitle: Text(
      value,
      style: const TextStyle(
        color: _ink,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    ),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          OverviewTab(settings: widget.settings),
          const AttendanceTab(),
          const TimetableTab(),
          const AssignmentsTab(),
          MoreTab(
            settings: widget.settings,
            onSettingsChanged: widget.onSettingsChanged,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fact_check_outlined),
            selectedIcon: Icon(Icons.fact_check_rounded),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: 'Plan',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment_rounded),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz_rounded),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.settings});
  final StudentSettings settings;

  static const _modules = [
    ('Attendance', '91% overall', Icons.fact_check_outlined, Color(0xFFDDF3EC)),
    ('Timetable', 'Next: MAD at 10:00', Icons.calendar_month_outlined, Color(0xFFFFEBD1)),
    ('Assignments', '3 due this week', Icons.assignment_outlined, Color(0xFFE8E3FA)),
    ('Notifications', '2 unread updates', Icons.notifications_none_rounded, Color(0xFFFFE0E2)),
    ('Faculty', 'Connect with mentors', Icons.people_outline_rounded, Color(0xFFDCECF5)),
    ('Event Gallery', '6 campus events', Icons.photo_library_outlined, Color(0xFFE1F0D9)),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 700;
          final horizontalPadding = wide ? 40.0 : 20.0;
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  24,
                  horizontalPadding,
                  32,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Good morning', style: TextStyle(color: _muted)),
                              SizedBox(height: 4),
                              Text(
                                settings.name,
                                style: TextStyle(
                                  color: _ink,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Open notifications',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          ),
                          icon: const Badge(
                            label: Text('2'),
                            child: Icon(Icons.notifications_none_rounded),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Open student profile',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ProfileScreen()),
                          ),
                          icon: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFE3DBF9),
                            child: Text('RP', style: TextStyle(color: _teal, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: _teal,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Your semester at a glance', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
                                    SizedBox(height: 10),
                                    Text('Semester V  •  24CE001', style: TextStyle(color: Color(0xFFE9E1FA))),
                                  ],
                                ),
                              ),
                              Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFD47A), size: 42),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text('Your modules', style: TextStyle(color: _ink, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _modules.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: wide ? 3 : 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: wide
                          ? 1.25 + settings.cardScale * 0.6
                          : 0.9 + settings.cardScale * 0.35,
                      ),
                      itemBuilder: (context, index) {
                        final module = _modules[index];
                        return ModuleCard(
                          title: module.$1,
                          subtitle: module.$2,
                          icon: module.$3,
                          color: module.$4,
                        );
                      },
                    ),
                    const SizedBox(height: 26),
                    const Text('Today', style: TextStyle(color: _ink, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const SchedulePreview(),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SchedulePreview extends StatelessWidget {
  const SchedulePreview({super.key});

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFFFEBD1),
        child: Icon(Icons.code_rounded, color: _teal),
      ),
      title: const Text('Mobile Application Development', style: TextStyle(fontWeight: FontWeight.w700)),
      subtitle: const Text('10:00 - 11:30  •  Lab 204'),
      trailing: const Icon(Icons.chevron_right_rounded),
    ),
  );
}

class PageFrame extends StatelessWidget {
  const PageFrame({super.key, required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth > 700 ? 40.0 : 20.0;
        return ListView(
          padding: EdgeInsets.fromLTRB(padding, 24, padding, 32),
          children: [
            Text(title, style: const TextStyle(color: _ink, fontSize: 27, fontWeight: FontWeight.w800)),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(color: _muted)),
            const SizedBox(height: 24),
            child,
          ],
        );
      },
    ),
  );
}

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({super.key});
  static const _subjects = [('DBMS', '92%', 0.92), ('MAD', '88%', 0.88), ('AI', '95%', 0.95), ('CN', '90%', 0.90)];

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Attendance summary',
    subtitle: 'Keep track of your semester participation.',
    child: Column(
      children: [
        const AttendanceTotal(),
        const SizedBox(height: 18),
        ..._subjects.map((subject) => AttendanceTile(name: subject.$1, percentage: subject.$2, value: subject.$3)),
      ],
    ),
  );
}

class AttendanceTotal extends StatelessWidget {
  const AttendanceTotal({super.key});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(value: 0.91, strokeWidth: 9, backgroundColor: const Color(0xFFDDF3EC), color: _teal),
                const Text('91%', style: TextStyle(color: _ink, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(child: Text('Great consistency! You are above the 75% attendance requirement.', style: TextStyle(color: _ink, fontWeight: FontWeight.w600))),
        ],
      ),
    ),
  );
}

class AttendanceTile extends StatelessWidget {
  const AttendanceTile({super.key, required this.name, required this.percentage, required this.value});
  final String name;
  final String percentage;
  final double value;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(children: [Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))), Text(percentage, style: const TextStyle(color: _teal, fontWeight: FontWeight.w800))]),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: value, minHeight: 8, borderRadius: BorderRadius.circular(8), color: _teal, backgroundColor: const Color(0xFFDDF3EC)),
        ],
      ),
    ),
  );
}

class TimetableTab extends StatelessWidget {
  const TimetableTab({super.key});
  static const _classes = [
    ('09:00', 'Database Management Systems', 'Room 301', 'Dr. Mehta'),
    ('10:00', 'Mobile Application Development', 'Lab 204', 'Prof. Shah'),
    ('13:30', 'Artificial Intelligence', 'Room 208', 'Dr. Iyer'),
    ('15:00', 'Computer Networks', 'Room 112', 'Prof. Desai'),
  ];

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Timetable',
    subtitle: 'Tuesday, 14 October  •  Week 7',
    child: Column(children: _classes.map((item) => Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: SizedBox(width: 52, child: Text(item.$1, style: const TextStyle(color: _teal, fontWeight: FontWeight.w800))),
        title: Text(item.$2, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('${item.$3}  •  ${item.$4}'),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    )).toList()),
  );
}

class AssignmentsTab extends StatelessWidget {
  const AssignmentsTab({super.key});
  static const _assignments = [
    ('Flutter UI Design', 'Due 18 Oct', 'In progress', Color(0xFFFFEBD1)),
    ('Database CRUD', 'Due 21 Oct', 'Not started', Color(0xFFE8E3FA)),
    ('REST API Integration', 'Due 25 Oct', 'Not started', Color(0xFFDCECF5)),
  ];

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Assignments',
    subtitle: 'Three tasks need your attention this week.',
    child: Column(children: _assignments.map((item) => Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(backgroundColor: item.$4, child: const Icon(Icons.assignment_outlined, color: _teal)),
        title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(item.$2),
        trailing: Text(item.$3, style: const TextStyle(color: _muted, fontSize: 12)),
      ),
    )).toList()),
  );
}

class MoreTab extends StatelessWidget {
  const MoreTab({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Campus life',
    subtitle: 'People, updates, and moments from campus.',
    child: Column(
      children: [
        MoreAction(
          title: 'Profile & preferences',
          subtitle: '${settings.semester}  •  ${settings.language}',
          icon: Icons.tune_rounded,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SettingsScreen(
                settings: settings,
                onSettingsChanged: onSettingsChanged,
              ),
            ),
          ),
        ),
        MoreAction(title: 'Notifications', subtitle: 'Internal exam and deadline updates', icon: Icons.notifications_none_rounded, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
        MoreAction(title: 'Faculty information', subtitle: 'Find office hours and contact details', icon: Icons.people_outline_rounded, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FacultyScreen()))),
        MoreAction(title: 'Event gallery', subtitle: 'Explore upcoming campus experiences', icon: Icons.photo_library_outlined, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GalleryScreen()))),
      ],
    ),
  );
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });
  final StudentSettings settings;
  final void Function(void Function(StudentSettings settings))
      onSettingsChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _nameController;
  late String _semester;
  late String _language;
  late bool _darkMode;
  late bool _assignmentAlerts;
  late bool _examNotifications;
  late bool _placementUpdates;
  late bool _eventAnnouncements;
  late double _cardScale;
  late Set<String> _courses;

  static const _semesters = [
    'Semester I',
    'Semester II',
    'Semester III',
    'Semester IV',
    'Semester V',
    'Semester VI',
    'Semester VII',
    'Semester VIII',
  ];
  static const _languages = ['English', 'Hindi', 'Gujarati'];
  static const _courseOptions = [
    'Mobile Application Development',
    'Artificial Intelligence',
    'Database Management System',
    'Computer Networks',
  ];

  @override
  void initState() {
    super.initState();
    final settings = widget.settings;
    _nameController = TextEditingController(text: settings.name);
    _semester = settings.semester;
    _language = settings.language;
    _darkMode = settings.darkMode;
    _assignmentAlerts = settings.assignmentAlerts;
    _examNotifications = settings.examNotifications;
    _placementUpdates = settings.placementUpdates;
    _eventAnnouncements = settings.eventAnnouncements;
    _cardScale = settings.cardScale;
    _courses = {...settings.courses};
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    widget.onSettingsChanged((settings) {
      settings.name = _nameController.text.trim().isEmpty
          ? 'Rahul Patel'
          : _nameController.text.trim();
      settings.semester = _semester;
      settings.language = _language;
      settings.darkMode = _darkMode;
      settings.assignmentAlerts = _assignmentAlerts;
      settings.examNotifications = _examNotifications;
      settings.placementUpdates = _placementUpdates;
      settings.eventAnnouncements = _eventAnnouncements;
      settings.cardScale = _cardScale;
      settings.courses = {..._courses};
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved for this session')),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Profile & preferences'),
      actions: [
        IconButton(
          tooltip: 'Save preferences',
          onPressed: _saveSettings,
          icon: const Icon(Icons.save_outlined),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        const Text('Student profile', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person_outline_rounded)),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.badge_outlined, color: _teal),
            title: Text(widget.settings.enrollmentNo),
            subtitle: Text(widget.settings.department),
            trailing: const Text('Enrollment', style: TextStyle(color: _muted, fontSize: 12)),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Academic preferences', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _semester,
          decoration: const InputDecoration(labelText: 'Semester', prefixIcon: Icon(Icons.school_outlined)),
          items: _semesters.map((semester) => DropdownMenuItem(value: semester, child: Text(semester))).toList(),
          onChanged: (value) => setState(() => _semester = value ?? _semester),
        ),
        const SizedBox(height: 16),
        const Text('Language', style: TextStyle(fontWeight: FontWeight.w700)),
        RadioGroup<String>(
          groupValue: _language,
          onChanged: (value) => setState(() => _language = value ?? _language),
          child: Column(
            children: _languages
                .map((language) => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(language),
                      value: language,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Theme', style: TextStyle(fontWeight: FontWeight.w700)),
        RadioGroup<bool>(
          groupValue: _darkMode,
          onChanged: (value) => setState(() => _darkMode = value ?? false),
          child: Column(
            children: const [
              RadioListTile<bool>(
                contentPadding: EdgeInsets.zero,
                title: Text('Light theme'),
                value: false,
              ),
              RadioListTile<bool>(
                contentPadding: EdgeInsets.zero,
                title: Text('Dark theme'),
                value: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text('Notification preferences', style: TextStyle(fontWeight: FontWeight.w700)),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Assignment alerts'),
          value: _assignmentAlerts,
          onChanged: (value) => setState(() => _assignmentAlerts = value ?? false),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Examination notifications'),
          value: _examNotifications,
          onChanged: (value) => setState(() => _examNotifications = value ?? false),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Placement updates'),
          value: _placementUpdates,
          onChanged: (value) => setState(() => _placementUpdates = value ?? false),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Event announcements'),
          value: _eventAnnouncements,
          onChanged: (value) => setState(() => _eventAnnouncements = value ?? false),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Dark mode preview'),
          subtitle: const Text('Apply the selected theme when saved'),
          value: _darkMode,
          onChanged: (value) => setState(() => _darkMode = value),
        ),
        const SizedBox(height: 12),
        Text('Dashboard card size: ${(_cardScale * 100).round()}%'),
        Slider(
          value: _cardScale,
          min: 0,
          max: 1,
          divisions: 4,
          label: '${(_cardScale * 100).round()}%',
          onChanged: (value) => setState(() => _cardScale = value),
        ),
        const SizedBox(height: 12),
        const Text('Course preferences', style: TextStyle(fontWeight: FontWeight.w700)),
        ..._courseOptions.map((course) => CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(course),
          value: _courses.contains(course),
          onChanged: (selected) => setState(() {
            if (selected ?? false) {
              _courses.add(course);
            } else {
              _courses.remove(course);
            }
          }),
        )),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _saveSettings,
          icon: const Icon(Icons.check_rounded),
          label: const Text('Save preferences'),
        ),
      ],
    ),
  );
}

class MoreAction extends StatelessWidget {
  const MoreAction({super.key, required this.title, required this.subtitle, required this.icon, required this.onTap});
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(backgroundColor: const Color(0xFFDDF3EC), child: Icon(icon, color: _teal)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    ),
  );
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static const _items = [
    ('Internal Exam Schedule', 'Your internal exams begin on 4 November.', Icons.event_note_rounded),
    ('Assignment Deadline', 'Flutter UI Design is due this Friday.', Icons.assignment_late_outlined),
    ('Technical Event Registration', 'Registrations are open for TechSprint 2025.', Icons.campaign_outlined),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notifications')),
    body: ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(elevation: 0, child: ListTile(leading: Icon(item.$3, color: _teal), title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(item.$2)));
      },
    ),
  );
}

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});
  static const _faculty = [('Dr. R. Mehta', 'Database Management Systems', 'r.mehta@campus.edu'), ('Prof. N. Shah', 'Mobile Application Development', 'n.shah@campus.edu'), ('Dr. P. Iyer', 'Artificial Intelligence', 'p.iyer@campus.edu')];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Faculty information')),
    body: ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _faculty.length,
      itemBuilder: (context, index) {
        final member = _faculty[index];
        return Card(elevation: 0, margin: const EdgeInsets.only(bottom: 12), child: ListTile(leading: const CircleAvatar(backgroundColor: Color(0xFFDCECF5), child: Icon(Icons.person_outline_rounded, color: _teal)), title: Text(member.$1, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text('${member.$2}\n${member.$3}')));
      },
    ),
  );
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});
  static const _events = [('TechSprint', Icons.code_rounded, Color(0xFFDDF3EC)), ('Sports Meet', Icons.sports_basketball_outlined, Color(0xFFFFEBD1)), ('Cultural Night', Icons.music_note_rounded, Color(0xFFE8E3FA)), ('Alumni Talk', Icons.groups_outlined, Color(0xFFDCECF5)), ('Hackathon', Icons.lightbulb_outline_rounded, Color(0xFFFFE0E2)), ('Science Expo', Icons.science_outlined, Color(0xFFE1F0D9))];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Event gallery')),
    body: LayoutBuilder(
      builder: (context, constraints) => GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _events.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: constraints.maxWidth > 700 ? 3 : 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: .95),
        itemBuilder: (context, index) {
          final event = _events[index];
          return Card(elevation: 0, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Container(width: double.infinity, decoration: BoxDecoration(color: event.$3, borderRadius: const BorderRadius.vertical(top: Radius.circular(12))), child: Icon(event.$2, color: _teal, size: 42))), Padding(padding: const EdgeInsets.all(12), child: Text(event.$1, style: const TextStyle(fontWeight: FontWeight.w700)))]));
        },
      ),
    ),
  );
}
