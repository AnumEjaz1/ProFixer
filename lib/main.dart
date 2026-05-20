import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() {
  runApp(const ProFixerApp());
}

enum AppLanguage { english, urdu, romanUrdu }

// ── Design Tokens ──────────────────────────────────────────
class AppColors {
  static const primary       = Color(0xFF00C9A7);
  static const primaryLight  = Color(0xFF43E8D8);
  static const primaryDark   = Color(0xFF007A65);
  static const accent        = Color(0xFFFFD166);
  static const accentPink    = Color(0xFFFF6B9D);
  static const accentPurple  = Color(0xFF9B5DE5);
  static const danger        = Color(0xFFEF4444);
  static const bg            = Color(0xFF0D1B2A);
  static const bgCard        = Color(0xFF1A2940);
  static const bgCardLight   = Color(0xFF1E3250);
  static const surface       = Color(0xFF1A2940);
  static const surfaceLight  = Color(0xFF243550);
  static const textDark      = Color(0xFFEEF2FF);
  static const textMid       = Color(0xFF94A3C8);
  static const textLight     = Color(0xFF546A8A);
  static const border        = Color(0xFF2A3F5F);
  static const cardShadow    = Color(0x4000C9A7);
  static const glowCyan      = Color(0x3000C9A7);
  static const glowPurple    = Color(0x309B5DE5);
  static const glowPink      = Color(0x30FF6B9D);
}

class AppGradients {
  static const primary = LinearGradient(
    colors: [Color(0xFF007A65), Color(0xFF00C9A7), Color(0xFF43E8D8)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const hero = LinearGradient(
    colors: [Color(0xFF060D1A), Color(0xFF0A1628), Color(0xFF0F2347)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const heroAccent = LinearGradient(
    colors: [Color(0xFF0A1628), Color(0xFF0D2040), Color(0xFF112952)],
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
  );
  static const card = LinearGradient(
    colors: [Color(0xFF1A2940), Color(0xFF1E3250)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const accentBtn = LinearGradient(
    colors: [Color(0xFF00C9A7), Color(0xFF43E8D8)],
    begin: Alignment.centerLeft, end: Alignment.centerRight,
  );
  static const pinkPurple = LinearGradient(
    colors: [Color(0xFF9B5DE5), Color(0xFFFF6B9D)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const goldenGlow = LinearGradient(
    colors: [Color(0xFFFFD166), Color(0xFFFF9F1C)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
}

// ══════════════════════════════════════════════════════════
// FLOATING ANIMATED BACKGROUND — VIVID NEON ICONS
// ══════════════════════════════════════════════════════════
class _FloatingIcon {
  final IconData icon;
  final double x, y, size, speed, rotationSpeed, opacity;
  final Color color;
  double angle;
  double rotAngle;

  _FloatingIcon({
    required this.icon, required this.x, required this.y,
    required this.size, required this.speed, required this.rotationSpeed,
    required this.opacity, required this.color,
    required this.angle, required this.rotAngle,
  });
}

class AnimatedBackgroundIcons extends StatefulWidget {
  final Widget child;
  final bool darkMode;
  const AnimatedBackgroundIcons({super.key, required this.child, this.darkMode = false});

  @override
  State<AnimatedBackgroundIcons> createState() => _AnimatedBackgroundIconsState();
}

class _AnimatedBackgroundIconsState extends State<AnimatedBackgroundIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_FloatingIcon> _icons;
  final _rand = math.Random(42);

  final List<IconData> _pool = [
    Icons.handyman_rounded, Icons.ac_unit_rounded, Icons.plumbing_rounded,
    Icons.electrical_services_rounded, Icons.build_rounded,
    Icons.home_repair_service_rounded, Icons.settings_rounded,
    Icons.bolt_rounded, Icons.water_drop_rounded, Icons.hvac_rounded,
  ];

  final List<Color> _neonColors = [
    const Color(0xFF00C9A7), const Color(0xFF43E8D8), const Color(0xFF9B5DE5),
    const Color(0xFFFF6B9D), const Color(0xFFFFD166), const Color(0xFF00B4D8),
    const Color(0xFF06D6A0), const Color(0xFFEF476F),
  ];

  @override
  void initState() {
    super.initState();
    _icons = List.generate(22, (i) => _FloatingIcon(
      icon: _pool[i % _pool.length],
      x: _rand.nextDouble(),
      y: _rand.nextDouble(),
      size: 16 + _rand.nextDouble() * 30,
      speed: 0.003 + _rand.nextDouble() * 0.007,
      rotationSpeed: (0.002 + _rand.nextDouble() * 0.005) * (_rand.nextBool() ? 1 : -1),
      opacity: 0.06 + _rand.nextDouble() * 0.14,
      color: _neonColors[i % _neonColors.length],
      angle: _rand.nextDouble() * math.pi * 2,
      rotAngle: _rand.nextDouble() * math.pi * 2,
    ));

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    _controller.addListener(() {
      setState(() {
        for (final ic in _icons) {
          ic.angle    += ic.speed;
          ic.rotAngle += ic.rotationSpeed;
        }
      });
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Deep space gradient base
      Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF060D1A), Color(0xFF0A1628), Color(0xFF0D1F3C), Color(0xFF060D1A)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              stops: [0.0, 0.35, 0.65, 1.0],
            ),
          ),
        ),
      ),
      // Glowing orbs
      Positioned(top: -60, right: -60, child: _glowOrb(200, AppColors.glowCyan)),
      Positioned(bottom: -80, left: -80, child: _glowOrb(240, AppColors.glowPurple)),
      Positioned(top: 200, left: -40, child: _glowOrb(120, AppColors.glowPink)),
      // Animated icons
      Positioned.fill(
        child: ClipRect(
          child: LayoutBuilder(builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;
            return Stack(
              children: _icons.map((ic) {
                final cx = math.cos(ic.angle) * 0.18 * w;
                final cy = math.sin(ic.angle * 0.7) * 0.14 * h;
                final px = (ic.x * w) + cx;
                final py = (ic.y * h) + cy;
                return Positioned(
                  left: px - ic.size / 2,
                  top:  py - ic.size / 2,
                  child: Transform.rotate(
                    angle: ic.rotAngle,
                    child: Icon(ic.icon, size: ic.size, color: ic.color.withOpacity(ic.opacity)),
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ),
      widget.child,
    ]);
  }

  Widget _glowOrb(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color,
        boxShadow: [BoxShadow(color: color, blurRadius: size * 0.8, spreadRadius: size * 0.2)]),
    );
  }
}

// ══════════════════════════════════════════════════════════
// LANGUAGE + LOCALIZATION
// ══════════════════════════════════════════════════════════
class ProFixerApp extends StatefulWidget {
  const ProFixerApp({super.key});
  @override State<ProFixerApp> createState() => _ProFixerAppState();
}

class _ProFixerAppState extends State<ProFixerApp> {
  AppLanguage _currentLang = AppLanguage.romanUrdu;
  void _changeLanguage(AppLanguage lang) => setState(() => _currentLang = lang);

  @override
  Widget build(BuildContext context) {
    return LanguageConfiguration(
      currentLanguage: _currentLang,
      onLanguageChanged: _changeLanguage,
      child: MaterialApp(
        title: 'Asan Khidmat Hub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.bg,
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.dark(primary: AppColors.primary, secondary: AppColors.primaryLight),
          fontFamily: 'sans-serif',
        ),
        home: const AppNavigationWrapper(),
      ),
    );
  }
}

class LanguageConfiguration extends InheritedWidget {
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;
  const LanguageConfiguration({super.key, required this.currentLanguage, required this.onLanguageChanged, required super.child});
  static LanguageConfiguration? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<LanguageConfiguration>();
  @override
  bool updateShouldNotify(LanguageConfiguration old) => old.currentLanguage != currentLanguage;
}

class LocalizedStrings {
  static String get(BuildContext context, String key) {
    final lang = LanguageConfiguration.of(context)?.currentLanguage ?? AppLanguage.romanUrdu;
    final Map<String, Map<AppLanguage, String>> v = {
      'appName':             { AppLanguage.english: 'Asan Khidmat Hub', AppLanguage.urdu: 'آسان خدمت ہب', AppLanguage.romanUrdu: 'Asan Khidmat Hub' },
      'tagline':             { AppLanguage.english: 'Convenience at home, in just one click', AppLanguage.urdu: 'گھر بیٹھے سہولت، ایک کلک پر', AppLanguage.romanUrdu: 'Ghar bethe sahulat, aik click par' },
      'signUpTitle':         { AppLanguage.english: 'Create Account ✨', AppLanguage.urdu: 'نیا اکاؤنٹ بنائیں ✨', AppLanguage.romanUrdu: 'Naya Account Banayein ✨' },
      'signUpSub':           { AppLanguage.english: 'Register now to access premium informal services.', AppLanguage.urdu: 'آسان سہولیات کا فائدہ اٹھانے کے لیے ابھی رجسٹر کریں۔', AppLanguage.romanUrdu: 'Asan sahulat ka faida uthane ke liye register karein.' },
      'fullNameLabel':       { AppLanguage.english: 'Full Name', AppLanguage.urdu: 'آپ کا نام (پورا نام)', AppLanguage.romanUrdu: 'Aap ka Naam (Full Name)' },
      'emailLabel':          { AppLanguage.english: 'Email Address', AppLanguage.urdu: 'ای میل ایڈریس', AppLanguage.romanUrdu: 'Email Address' },
      'mobileLabel':         { AppLanguage.english: 'Mobile Number', AppLanguage.urdu: 'موبائل نمبر', AppLanguage.romanUrdu: 'Mobile Number' },
      'passwordLabel':       { AppLanguage.english: 'Password', AppLanguage.urdu: 'پاس ورڈ', AppLanguage.romanUrdu: 'Password' },
      'btnSignUp':           { AppLanguage.english: 'Create Account (Sign Up)', AppLanguage.urdu: 'اکاؤنٹ بنائیں', AppLanguage.romanUrdu: 'Account Banayein (Sign Up)' },
      'alreadyAccount':      { AppLanguage.english: 'Already have an account? Log In', AppLanguage.urdu: 'پہلے سے اکاؤنٹ ہے؟ لاگ ان کریں', AppLanguage.romanUrdu: 'Pehle se account hai? Log In karein' },
      'searchHint':          { AppLanguage.english: 'How can I help you today?', AppLanguage.urdu: 'میں آپ کی کیا مدد کر سکتا ہوں؟', AppLanguage.romanUrdu: 'Main kya madad karoon aap ki?' },
      'chatPrompt':          { AppLanguage.english: 'Tap below to chat with our AI Agent 💬', AppLanguage.urdu: 'اے آئی بوٹ سے بات کرنے کے لیے نیچے دبائیں 💬', AppLanguage.romanUrdu: 'Chatbot se baat karne ke liye niche 💬 dabayein' },
      'locationTitle':       { AppLanguage.english: 'Select Location', AppLanguage.urdu: 'لوکیشن منتخب کریں', AppLanguage.romanUrdu: 'Location Chunye' },
      'locationSub':         { AppLanguage.english: 'Select your city and operating area:', AppLanguage.urdu: 'اپنا شہر اور علاقہ منتخب کریں:', AppLanguage.romanUrdu: 'Apna Sheher aur Ilaqa muntakhif karein:' },
      'cityLabel':           { AppLanguage.english: 'City', AppLanguage.urdu: 'شہر', AppLanguage.romanUrdu: 'Sheher (City)' },
      'areaLabel':           { AppLanguage.english: 'Area', AppLanguage.urdu: 'علاقہ', AppLanguage.romanUrdu: 'Ilaqa (Area)' },
      'btnNext':             { AppLanguage.english: 'Proceed Forward', AppLanguage.urdu: 'آگے چلیں', AppLanguage.romanUrdu: 'Aagay Chalein' },
      'viewOnMap':           { AppLanguage.english: 'View on Map', AppLanguage.urdu: 'نقشے پر دیکھیں', AppLanguage.romanUrdu: 'Map par Dekhein' },
      'selectServiceTitle':  { AppLanguage.english: 'Select Required Service:', AppLanguage.urdu: 'سروس منتخب کریں:', AppLanguage.romanUrdu: 'Service Muntakhif Karein:' },
      'availableNowTitle':   { AppLanguage.english: 'Available Now:', AppLanguage.urdu: 'ابھی دستیاب ہے:', AppLanguage.romanUrdu: 'Available Now (Abhi Maujood Hai):' },
      'busyTitle':           { AppLanguage.english: 'Currently Busy Providers:', AppLanguage.urdu: 'مصروف فراہم کنندگان:', AppLanguage.romanUrdu: 'Filhal Busy Providers:' },
      'selectServicePrompt': { AppLanguage.english: 'Please select a service from above categories.', AppLanguage.urdu: 'اوپر سے کوئی بھی ایک سروس منتخب کریں۔', AppLanguage.romanUrdu: 'Upar se koi bhi aik service select karein.' },
      'mapTitle':            { AppLanguage.english: 'Provider Location Map', AppLanguage.urdu: 'فراہم کنندہ کا نقشہ', AppLanguage.romanUrdu: 'Provider Location Map' },
      'mapSub':              { AppLanguage.english: 'Google Maps API will be connected by your backend developer.', AppLanguage.urdu: 'گوگل میپس API آپ کے بیک اینڈ ڈویلپر سے جڑے گا۔', AppLanguage.romanUrdu: 'Google Maps API backend developer connect karega.' },
      'nearbyProviders':     { AppLanguage.english: 'Nearby Providers', AppLanguage.urdu: 'قریبی فراہم کنندگان', AppLanguage.romanUrdu: 'Nearby Providers' },
      'getDirections':       { AppLanguage.english: 'Get Directions', AppLanguage.urdu: 'راستہ دیکھیں', AppLanguage.romanUrdu: 'Directions Dekhein' },
      'Karachi':        { AppLanguage.english: 'Karachi',        AppLanguage.urdu: 'کراچی',          AppLanguage.romanUrdu: 'Karachi' },
      'Lahore':         { AppLanguage.english: 'Lahore',         AppLanguage.urdu: 'لاہور',           AppLanguage.romanUrdu: 'Lahore' },
      'Islamabad':      { AppLanguage.english: 'Islamabad',      AppLanguage.urdu: 'اسلام آباد',      AppLanguage.romanUrdu: 'Islamabad' },
      'Saddar':         { AppLanguage.english: 'Saddar',         AppLanguage.urdu: 'صدر',             AppLanguage.romanUrdu: 'Saddar' },
      'Gulshan-e-Iqbal':{ AppLanguage.english: 'Gulshan-e-Iqbal',AppLanguage.urdu: 'گلشنِ اقبال',   AppLanguage.romanUrdu: 'Gulshan-e-Iqbal' },
      'Clifton':        { AppLanguage.english: 'Clifton',        AppLanguage.urdu: 'کلفٹن',           AppLanguage.romanUrdu: 'Clifton' },
      'Gulberg':        { AppLanguage.english: 'Gulberg',        AppLanguage.urdu: 'گلبرگ',           AppLanguage.romanUrdu: 'Gulberg' },
      'DHA Phase 5':    { AppLanguage.english: 'DHA Phase 5',    AppLanguage.urdu: 'ڈی ایچ اے فیز 5', AppLanguage.romanUrdu: 'DHA Phase 5' },
      'Johar Town':     { AppLanguage.english: 'Johar Town',     AppLanguage.urdu: 'جوہر ٹاؤن',       AppLanguage.romanUrdu: 'Johar Town' },
      'G-11':           { AppLanguage.english: 'G-11',           AppLanguage.urdu: 'جی الیون',        AppLanguage.romanUrdu: 'G-11' },
      'F-6':            { AppLanguage.english: 'F-6',            AppLanguage.urdu: 'ایف سکس',         AppLanguage.romanUrdu: 'F-6' },
      'I-9':            { AppLanguage.english: 'I-9',            AppLanguage.urdu: 'آئی نائن',        AppLanguage.romanUrdu: 'I-9' },
      'AC Repair':      { AppLanguage.english: 'AC Repair',      AppLanguage.urdu: 'اے سی کی مرمت',  AppLanguage.romanUrdu: 'AC Repair' },
      'Plumber':        { AppLanguage.english: 'Plumber',        AppLanguage.urdu: 'پلمبر (نل ساز)', AppLanguage.romanUrdu: 'Plumber' },
      'Electrician':    { AppLanguage.english: 'Electrician',    AppLanguage.urdu: 'الیکٹریشن',       AppLanguage.romanUrdu: 'Electrician' },
    };
    return v[key]?[lang] ?? key;
  }
}

// ══════════════════════════════════════════════════════════
// SHARED WIDGETS
// ══════════════════════════════════════════════════════════
class LanguageSwitcherRow extends StatelessWidget {
  const LanguageSwitcherRow({super.key});

  @override
  Widget build(BuildContext context) {
    final config  = LanguageConfiguration.of(context);
    final current = config?.currentLanguage ?? AppLanguage.romanUrdu;
    final isUrdu  = current == AppLanguage.urdu;
    final chips = Row(mainAxisSize: MainAxisSize.min, children: [
      _chip(context, 'EN',    AppLanguage.english,   current == AppLanguage.english),
      const SizedBox(width: 5),
      _chip(context, 'اردو', AppLanguage.urdu,       current == AppLanguage.urdu),
      const SizedBox(width: 5),
      _chip(context, 'Roman', AppLanguage.romanUrdu, current == AppLanguage.romanUrdu),
    ]);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: AppColors.glowCyan, blurRadius: 12)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: isUrdu ? [_logoutBtn(context), chips] : [chips, _logoutBtn(context)],
      ),
    );
  }

  Widget _chip(BuildContext context, String label, AppLanguage lang, bool selected) {
    return GestureDetector(
      onTap: () => LanguageConfiguration.of(context)?.onLanguageChanged(lang),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          gradient: selected ? AppGradients.accentBtn : null,
          color: selected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected ? [const BoxShadow(color: AppColors.glowCyan, blurRadius: 10)] : [],
        ),
        child: Text(label, style: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.3,
          color: selected ? Colors.black87 : Colors.white.withOpacity(0.6),
        )),
      ),
    );
  }

  Widget _logoutBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const CreateAccountPage()), (r) => false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
          boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.2), blurRadius: 8)],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: const [
          Icon(Icons.logout_rounded, size: 12, color: Colors.redAccent),
          SizedBox(width: 5),
          Text('Logout', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.redAccent)),
        ]),
      ),
    );
  }
}

class NeonDivider extends StatelessWidget {
  final Color color;
  const NeonDivider({super.key, this.color = AppColors.primary});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.transparent, color, Colors.transparent]),
        boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 6)],
      ),
    );
  }
}

class GlowCard extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  const GlowCard({super.key, required this.child, this.glowColor = AppColors.primary, this.padding, this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.card,
        borderRadius: borderRadius ?? BorderRadius.circular(18),
        border: Border.all(color: glowColor.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(color: glowColor.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 4)),
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final LinearGradient? gradient;
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.icon, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: 54,
      decoration: BoxDecoration(
        gradient: gradient ?? AppGradients.accentBtn,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.50), blurRadius: 20, offset: const Offset(0, 7)),
          BoxShadow(color: AppColors.primary.withOpacity(0.20), blurRadius: 40, offset: const Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16), onTap: onPressed,
          child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (icon != null) ...[Icon(icon, color: Colors.black87, size: 18), const SizedBox(width: 8)],
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87, letterSpacing: 0.4)),
          ])),
        ),
      ),
    );
  }
}

class StyledField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final bool isPassword, passwordHidden, isUrdu;
  final VoidCallback? onTogglePassword;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const StyledField({
    super.key, required this.controller, required this.label, required this.hint,
    required this.icon, required this.isUrdu,
    this.isPassword = false, this.passwordHidden = true,
    this.onTogglePassword, this.keyboardType = TextInputType.text,
    this.inputFormatters, this.validator, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7, left: 2, right: 2),
          child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.5)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
            boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 6)],
          ),
          child: TextFormField(
            controller: controller, keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: isPassword && passwordHidden,
            textAlign: isUrdu ? TextAlign.right : TextAlign.left,
            onChanged: onChanged, validator: validator,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
            decoration: InputDecoration(
              prefixIcon: isUrdu ? null : Icon(icon, color: AppColors.primary, size: 20),
              suffixIcon: isUrdu
                  ? (isPassword
                      ? IconButton(icon: Icon(passwordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: AppColors.textLight, size: 20), onPressed: onTogglePassword)
                      : Icon(icon, color: AppColors.primary, size: 20))
                  : (isPassword
                      ? IconButton(icon: Icon(passwordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: AppColors.textLight, size: 20), onPressed: onTogglePassword)
                      : null),
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════
// PROVIDER MODEL
// ══════════════════════════════════════════════════════════
class ProviderModel {
  final String name, specialty, nextAvailableIn, phone;
  final double rating;
  final int reviews, eta;
  final bool isAvailable;
  ProviderModel({required this.name, required this.specialty, required this.rating,
    required this.reviews, required this.isAvailable, required this.eta,
    required this.nextAvailableIn, required this.phone});
}

// ══════════════════════════════════════════════════════════
// GLOBAL WRAPPER
// ══════════════════════════════════════════════════════════
class AppNavigationWrapper extends StatefulWidget {
  const AppNavigationWrapper({super.key});
  @override State<AppNavigationWrapper> createState() => _AppNavigationWrapperState();
}

class _AppNavigationWrapperState extends State<AppNavigationWrapper> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    return Scaffold(
      backgroundColor: AppColors.bg,
      floatingActionButtonLocation: isUrdu ? FloatingActionButtonLocation.startFloat : FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.accentBtn, shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.6), blurRadius: 25, offset: const Offset(0, 6)),
            BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 50),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent, elevation: 0,
          child: const Icon(Icons.chat_bubble_rounded, color: Colors.black87, size: 26),
          onPressed: () => showModalBottomSheet(
            context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
            builder: (_) => const ChatBotWidget(),
          ),
        ),
      ),
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => const CreateAccountPage()),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
// PAGE: CREATE ACCOUNT
// ══════════════════════════════════════════════════════════
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});
  @override State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _pwdHidden = true;
  String _strengthText = '';
  Color _strengthColor = Colors.transparent;
  double _strengthProgress = 0.0;

  void _checkStrength(String pw) {
    if (pw.isEmpty) { setState(() { _strengthText = ''; _strengthColor = Colors.transparent; _strengthProgress = 0; }); return; }
    int s = 0;
    if (pw.length >= 6) s++;
    if (pw.contains(RegExp(r'[A-Z]')) && pw.contains(RegExp(r'[a-z]'))) s++;
    if (pw.contains(RegExp(r'[0-9]'))) s++;
    if (pw.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) s++;
    setState(() {
      if (s <= 2)      { _strengthText = 'Weak 🔴';   _strengthColor = const Color(0xFFEF4444); _strengthProgress = 0.33; }
      else if (s == 3) { _strengthText = 'Medium 🟡'; _strengthColor = AppColors.accent;         _strengthProgress = 0.66; }
      else             { _strengthText = 'Strong 🟢';  _strengthColor = AppColors.primary;        _strengthProgress = 1.0; }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    final lang   = LanguageConfiguration.of(context)?.currentLanguage ?? AppLanguage.romanUrdu;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBackgroundIcons(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                // ── Hero Header ──
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 36),
                  decoration: BoxDecoration(
                    gradient: AppGradients.hero,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                    border: Border.all(color: AppColors.primary.withOpacity(0.15)),
                    boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 30, offset: Offset(0, 8))],
                  ),
                  child: Column(
                    crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      const LanguageSwitcherRow(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          if (!isUrdu) ...[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: AppGradients.accentBtn,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 14)],
                              ),
                              child: const Icon(Icons.handyman_rounded, color: Colors.black87, size: 22),
                            ),
                            const SizedBox(width: 12),
                          ],
                          ShaderMask(
                            shaderCallback: (b) => AppGradients.accentBtn.createShader(b),
                            child: Text(LocalizedStrings.get(context, 'appName'),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
                          ),
                          if (isUrdu) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: AppGradients.accentBtn,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 14)],
                              ),
                              child: const Icon(Icons.handyman_rounded, color: Colors.black87, size: 22),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 22),
                      ShaderMask(
                        shaderCallback: (b) => AppGradients.accentBtn.createShader(b),
                        child: Text(LocalizedStrings.get(context, 'signUpTitle'),
                          textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2)),
                      ),
                      const SizedBox(height: 8),
                      Text(LocalizedStrings.get(context, 'signUpSub'),
                        textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.65), height: 1.5)),
                    ],
                  ),
                ),

                // ── Form ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        StyledField(controller: _nameCtrl, label: LocalizedStrings.get(context, 'fullNameLabel'), hint: 'Anum Ejaz', icon: Icons.person_outline_rounded, isUrdu: isUrdu, validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null),
                        const SizedBox(height: 16),
                        StyledField(controller: _emailCtrl, label: LocalizedStrings.get(context, 'emailLabel'), hint: 'name@example.com', icon: Icons.mail_outline_rounded, isUrdu: isUrdu, keyboardType: TextInputType.emailAddress,
                          validator: (v) { if (v == null || v.trim().isEmpty) return 'Required'; if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.trim())) return 'Invalid email'; return null; }),
                        const SizedBox(height: 16),
                        StyledField(controller: _phoneCtrl, label: LocalizedStrings.get(context, 'mobileLabel'), hint: '03001234567', icon: Icons.phone_android_rounded, isUrdu: isUrdu, keyboardType: TextInputType.phone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                          validator: (v) { if (v == null || v.isEmpty) return 'Required'; if (v.length < 11) return 'Must be 11 digits'; return null; }),
                        const SizedBox(height: 16),
                        StyledField(controller: _passwordCtrl, label: LocalizedStrings.get(context, 'passwordLabel'), hint: '••••••••', icon: Icons.lock_outline_rounded, isUrdu: isUrdu,
                          isPassword: true, passwordHidden: _pwdHidden, onTogglePassword: () => setState(() => _pwdHidden = !_pwdHidden),
                          onChanged: _checkStrength, validator: (v) => (v == null || v.length < 6) ? 'Too short' : null),

                        if (_passwordCtrl.text.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Container(
                            height: 5, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                              color: AppColors.border, boxShadow: [BoxShadow(color: _strengthColor.withOpacity(0.3), blurRadius: 8)]),
                            child: ClipRRect(borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(value: _strengthProgress, backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(_strengthColor))),
                          ),
                          const SizedBox(height: 5),
                          Align(alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                            child: Text(_strengthText, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _strengthColor))),
                        ],

                        const SizedBox(height: 30),
                        PrimaryButton(
                          label: LocalizedStrings.get(context, 'btnSignUp'),
                          icon: Icons.arrow_forward_rounded,
                          onPressed: () { if (_formKey.currentState!.validate()) Navigator.push(context, MaterialPageRoute(builder: (_) => const WelcomeHomePage())); },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WelcomeHomePage())),
                            child: RichText(text: TextSpan(
                              text: lang == AppLanguage.urdu ? 'پہلے سے اکاؤنٹ ہے؟ ' : (lang == AppLanguage.english ? 'Already have an account? ' : 'Pehle se account hai? '),
                              style: const TextStyle(color: AppColors.textMid, fontSize: 13),
                              children: [TextSpan(
                                text: lang == AppLanguage.urdu ? 'لاگ ان کریں' : 'Log In',
                                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800),
                              )],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
// PAGE 1: WELCOME HOME
// ══════════════════════════════════════════════════════════
class WelcomeHomePage extends StatelessWidget {
  const WelcomeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBackgroundIcons(
        child: SafeArea(
          child: Column(children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
              decoration: BoxDecoration(
                gradient: AppGradients.hero,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(34)),
                border: Border.all(color: AppColors.primary.withOpacity(0.15)),
                boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 24, offset: Offset(0, 6))],
              ),
              child: Column(children: [
                const LanguageSwitcherRow(),
                const SizedBox(height: 28),
                Container(
                  width: 82, height: 82,
                  decoration: BoxDecoration(
                    gradient: AppGradients.accentBtn,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      const BoxShadow(color: AppColors.glowCyan, blurRadius: 24),
                      BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Icon(Icons.handyman_rounded, size: 42, color: Colors.black87),
                ),
                const SizedBox(height: 14),
                ShaderMask(
                  shaderCallback: (b) => AppGradients.accentBtn.createShader(b),
                  child: Text(LocalizedStrings.get(context, 'appName'),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
                ),
                const SizedBox(height: 6),
                Text(LocalizedStrings.get(context, 'tagline'),
                  style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)), textAlign: TextAlign.center),
              ]),
            ),

            const Spacer(),

            // Quick Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(children: [
                _statChip('500+', 'Providers', Icons.people_alt_rounded, AppColors.primary),
                const SizedBox(width: 12),
                _statChip('4.9★', 'Rating', Icons.star_rounded, AppColors.accent),
                const SizedBox(width: 12),
                _statChip('24/7', 'Support', Icons.support_agent_rounded, AppColors.accentPurple),
              ]),
            ),
            const SizedBox(height: 18),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LocationPage())),
                child: GlowCard(
                  glowColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  borderRadius: BorderRadius.circular(20),
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppGradients.accentBtn,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 10)],
                      ),
                      child: const Icon(Icons.search_rounded, color: Colors.black87, size: 18),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Text(LocalizedStrings.get(context, 'searchHint'),
                      style: const TextStyle(fontSize: 13, color: AppColors.textLight, fontWeight: FontWeight.w500))),
                    const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 14),
                  ]),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 7, height: 7,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: AppColors.glowCyan, blurRadius: 8)])),
                const SizedBox(width: 8),
                Text(LocalizedStrings.get(context, 'chatPrompt'),
                  style: const TextStyle(fontSize: 12, color: AppColors.textLight, fontWeight: FontWeight.w500)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _statChip(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: GlowCard(
        glowColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        borderRadius: BorderRadius.circular(14),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
        ]),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
// PAGE 2: LOCATION SELECTOR
// ══════════════════════════════════════════════════════════
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});
  @override State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String selectedCity = 'Karachi';
  String selectedArea = 'Saddar';
  final List<String> citiesList = ['Karachi', 'Lahore', 'Islamabad'];
  final Map<String, List<String>> cityAreasMap = {
    'Karachi':   ['Saddar', 'Gulshan-e-Iqbal', 'Clifton'],
    'Lahore':    ['Gulberg', 'DHA Phase 5', 'Johar Town'],
    'Islamabad': ['G-11', 'F-6', 'I-9'],
  };

  Widget _dropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged, required BuildContext context}) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.bgCard, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 8)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value, isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
          style: const TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w600),
          dropdownColor: AppColors.bgCardLight,
          alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
          items: items.map((i) => DropdownMenuItem(value: i,
            child: Align(alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(LocalizedStrings.get(context, i))))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBackgroundIcons(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                decoration: BoxDecoration(
                  gradient: AppGradients.hero,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                  border: Border.all(color: AppColors.primary.withOpacity(0.15)),
                  boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 20, offset: Offset(0, 6))],
                ),
                child: Column(
                  crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    const LanguageSwitcherRow(),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
                      if (!isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 18), onPressed: () => Navigator.pop(context)),
                      ShaderMask(
                        shaderCallback: (b) => AppGradients.accentBtn.createShader(b),
                        child: Text(LocalizedStrings.get(context, 'locationTitle'),
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                      ),
                      if (isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary, size: 18), onPressed: () => Navigator.pop(context)),
                    ]),
                    const SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.only(left: isUrdu ? 0 : 8, right: isUrdu ? 8 : 0),
                      child: Text(LocalizedStrings.get(context, 'locationSub'),
                        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6))),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
                  child: Column(
                    crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      _label(LocalizedStrings.get(context, 'cityLabel'), Icons.location_city_rounded),
                      const SizedBox(height: 8),
                      _dropdown(value: selectedCity, items: citiesList, context: context,
                        onChanged: (v) => setState(() { selectedCity = v!; selectedArea = cityAreasMap[selectedCity]![0]; })),
                      const SizedBox(height: 24),
                      _label(LocalizedStrings.get(context, 'areaLabel'), Icons.map_outlined),
                      const SizedBox(height: 8),
                      _dropdown(value: selectedArea, items: cityAreasMap[selectedCity]!, context: context,
                        onChanged: (v) => setState(() => selectedArea = v!)),

                      const SizedBox(height: 24),
                      // Map Preview Button
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => MapViewPage(city: selectedCity, area: selectedArea))),
                        child: GlowCard(
                          glowColor: AppColors.accentPurple,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          child: Row(children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: AppGradients.pinkPurple,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [const BoxShadow(color: AppColors.glowPurple, blurRadius: 10)],
                              ),
                              child: const Icon(Icons.map_rounded, color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 14),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocalizedStrings.get(context, 'viewOnMap'),
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                                const Text('Google Maps Integration', style: TextStyle(fontSize: 11, color: AppColors.textLight)),
                              ],
                            )),
                            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.accentPurple, size: 14),
                          ]),
                        ),
                      ),

                      const Spacer(),
                      PrimaryButton(
                        label: LocalizedStrings.get(context, 'btnNext'),
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => ServicesAndDetailsPage(city: selectedCity, area: selectedArea))),
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

  Widget _label(String text, IconData icon) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 15, color: AppColors.primary),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
    ]);
  }
}

// ══════════════════════════════════════════════════════════
// PAGE: GOOGLE MAP VIEW (PLACEHOLDER — BACKEND API READY)
// ══════════════════════════════════════════════════════════
class MapViewPage extends StatefulWidget {
  final String city, area;
  const MapViewPage({super.key, required this.city, required this.area});
  @override State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  // Simulated nearby providers for the map pins
  final List<Map<String, dynamic>> _mapProviders = [
    {'name': 'Ali Mohammad', 'type': 'AC Repair', 'distance': '0.5 km', 'rating': 4.9, 'available': true,  'x': 0.50, 'y': 0.45},
    {'name': 'Ghulam Mustafa','type': 'Plumber',   'distance': '1.1 km', 'rating': 4.8, 'available': true,  'x': 0.30, 'y': 0.35},
    {'name': 'Zeeshan Ahmed', 'type': 'Electrician','distance': '1.8 km', 'rating': 4.6, 'available': true,  'x': 0.70, 'y': 0.60},
    {'name': 'Farhan Khan',   'type': 'AC Repair', 'distance': '2.3 km', 'rating': 4.3, 'available': false, 'x': 0.20, 'y': 0.65},
    {'name': 'Tariq Mahmood', 'type': 'Electrician','distance': '2.9 km', 'rating': 4.4, 'available': false, 'x': 0.75, 'y': 0.28},
  ];

  int _selectedPin = 0;

  final Map<String, Color> _typeColors = {
    'AC Repair':   const Color(0xFF0EA5E9),
    'Plumber':     const Color(0xFFF59E0B),
    'Electrician': const Color(0xFF22C55E),
  };
  final Map<String, String> _typeEmoji = {
    'AC Repair': '❄️', 'Plumber': '🔧', 'Electrician': '⚡',
  };

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.15).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _pulseController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    final selected = _mapProviders[_selectedPin];
    final pinColor = _typeColors[selected['type']] ?? AppColors.primary;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBackgroundIcons(
        child: SafeArea(
          child: Column(children: [
            // ── Header ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
              decoration: BoxDecoration(
                gradient: AppGradients.hero,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
                border: Border.all(color: AppColors.accentPurple.withOpacity(0.2)),
                boxShadow: [const BoxShadow(color: AppColors.glowPurple, blurRadius: 20, offset: Offset(0, 5))],
              ),
              child: Column(
                crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  const LanguageSwitcherRow(),
                  const SizedBox(height: 18),
                  Row(mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
                    if (!isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 18), onPressed: () => Navigator.pop(context)),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient: AppGradients.pinkPurple,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [const BoxShadow(color: AppColors.glowPurple, blurRadius: 12)],
                      ),
                      child: const Icon(Icons.map_rounded, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    ShaderMask(
                      shaderCallback: (b) => AppGradients.pinkPurple.createShader(b),
                      child: Text(LocalizedStrings.get(context, 'mapTitle'),
                        style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900)),
                    ),
                    if (isUrdu) ...[
                      const SizedBox(width: 10),
                      IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary, size: 18), onPressed: () => Navigator.pop(context)),
                    ],
                  ]),
                  const SizedBox(height: 6),
                  Padding(
                    padding: EdgeInsets.only(left: isUrdu ? 0 : 4, right: isUrdu ? 4 : 0),
                    child: Row(mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
                      const Icon(Icons.location_on_rounded, color: AppColors.accent, size: 14),
                      const SizedBox(width: 4),
                      Text('${LocalizedStrings.get(context, widget.area)}, ${LocalizedStrings.get(context, widget.city)}',
                        style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                ],
              ),
            ),

            // ── Map Canvas ──
            Expanded(
              flex: 5,
              child: Stack(children: [
                // Dark map background with grid
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0A1628), Color(0xFF0D1F3C), Color(0xFF081424)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                    ),
                    child: CustomPaint(painter: _MapGridPainter()),
                  ),
                ),

                // Road lines (decorative)
                Positioned.fill(child: CustomPaint(painter: _RoadPainter())),

                // Google Maps watermark area
                Positioned(
                  bottom: 12, right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.accentPurple.withOpacity(0.3)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: const [
                      Icon(Icons.map_rounded, color: AppColors.accentPurple, size: 12),
                      SizedBox(width: 5),
                      Text('Google Maps API', style: TextStyle(color: AppColors.textMid, fontSize: 10, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),

                // "Your Location" center pin with pulse
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.50 - 16,
                  top: MediaQuery.of(context).size.height * 0.22,
                  child: AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (context, child) {
                      return Stack(alignment: Alignment.center, children: [
                        Container(
                          width: 50 * _pulseAnim.value, height: 50 * _pulseAnim.value,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.15 * (2 - _pulseAnim.value))),
                        ),
                        Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.bg,
                            border: Border.all(color: AppColors.primary, width: 3),
                            boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 16)],
                          ),
                          child: const Icon(Icons.my_location_rounded, color: AppColors.primary, size: 16),
                        ),
                      ]);
                    },
                  ),
                ),

                // Provider pins
                ...List.generate(_mapProviders.length, (i) {
                  final p = _mapProviders[i];
                  final color = _typeColors[p['type']] ?? AppColors.primary;
                  final isSelected = _selectedPin == i;
                  return LayoutBuilder(builder: (context, constraints) {
                    return Positioned(
                      left: (p['x'] as double) * MediaQuery.of(context).size.width - 18,
                      top: (p['y'] as double) * (MediaQuery.of(context).size.height * 0.38),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedPin = i),
                        child: AnimatedScale(
                          scale: isSelected ? 1.25 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: isSelected ? color : color.withOpacity(0.7),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: isSelected ? 2.5 : 1.5),
                                boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: isSelected ? 20 : 10)],
                              ),
                              child: Center(child: Text(_typeEmoji[p['type']] ?? '🔧', style: const TextStyle(fontSize: 16))),
                            ),
                            Container(width: 2, height: 8, color: color),
                            Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                          ]),
                        ),
                      ),
                    );
                  });
                }),

                // Zoom controls
                Positioned(
                  right: 14, top: 14,
                  child: Column(children: [
                    _mapControl(Icons.add_rounded),
                    const SizedBox(height: 6),
                    _mapControl(Icons.remove_rounded),
                    const SizedBox(height: 6),
                    _mapControl(Icons.my_location_rounded),
                  ]),
                ),

                // Legend
                Positioned(
                  top: 14, left: 14,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ..._typeColors.entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(width: 10, height: 10, decoration: BoxDecoration(color: e.value, shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: e.value.withOpacity(0.5), blurRadius: 6)])),
                          const SizedBox(width: 6),
                          Text(e.key, style: const TextStyle(fontSize: 10, color: AppColors.textMid, fontWeight: FontWeight.w600)),
                        ]),
                      )).toList(),
                    ]),
                  ),
                ),
              ]),
            ),

            // ── Selected Provider Card ──
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                gradient: AppGradients.heroAccent,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: pinColor.withOpacity(0.3))),
                boxShadow: [BoxShadow(color: pinColor.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, -4))],
              ),
              child: Column(children: [
                // Drag handle
                Container(width: 38, height: 4, margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(4))),

                Row(children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: pinColor.withOpacity(0.15), shape: BoxShape.circle,
                      border: Border.all(color: pinColor.withOpacity(0.4)),
                      boxShadow: [BoxShadow(color: pinColor.withOpacity(0.3), blurRadius: 12)],
                    ),
                    child: Center(child: Text(_typeEmoji[selected['type']] ?? '🔧', style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(selected['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                    const SizedBox(height: 3),
                    Text(selected['type'] as String, style: TextStyle(fontSize: 12, color: pinColor, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.star_rounded, color: AppColors.accent, size: 13),
                      const SizedBox(width: 3),
                      Text('${selected['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                      const SizedBox(width: 10),
                      const Icon(Icons.location_on_rounded, color: AppColors.textLight, size: 12),
                      const SizedBox(width: 2),
                      Text(selected['distance'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ]),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: (selected['available'] as bool) ? const Color(0xFF22C55E).withOpacity(0.15) : AppColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: (selected['available'] as bool) ? const Color(0xFF22C55E).withOpacity(0.4) : AppColors.accent.withOpacity(0.4)),
                      ),
                      child: Text(
                        (selected['available'] as bool) ? '🟢 Active' : '🟡 Busy',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                          color: (selected['available'] as bool) ? const Color(0xFF22C55E) : AppColors.accent),
                      ),
                    ),
                  ]),
                ]),

                const SizedBox(height: 14),
                NeonDivider(color: pinColor),
                const SizedBox(height: 14),

                Row(children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [pinColor.withOpacity(0.8), pinColor]),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: pinColor.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12), onTap: () {},
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const Icon(Icons.navigation_rounded, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(LocalizedStrings.get(context, 'getDirections'),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      gradient: AppGradients.accentBtn, borderRadius: BorderRadius.circular(12),
                      boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12), onTap: () {},
                        child: const Icon(Icons.phone_rounded, color: Colors.black87, size: 20),
                      ),
                    ),
                  ),
                ]),

                // Nearby providers horizontal scroll
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(LocalizedStrings.get(context, 'nearbyProviders'),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _mapProviders.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, i) {
                      final p = _mapProviders[i];
                      final c = _typeColors[p['type']] ?? AppColors.primary;
                      final isSel = _selectedPin == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedPin = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSel ? c.withOpacity(0.15) : AppColors.bgCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isSel ? c : AppColors.border, width: isSel ? 1.5 : 1),
                            boxShadow: isSel ? [BoxShadow(color: c.withOpacity(0.3), blurRadius: 10)] : [],
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Row(children: [
                              Text(_typeEmoji[p['type']] ?? '🔧', style: const TextStyle(fontSize: 14)),
                              const SizedBox(width: 4),
                              Expanded(child: Text(p['name'] as String,
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isSel ? c : AppColors.textDark),
                                overflow: TextOverflow.ellipsis)),
                            ]),
                            const SizedBox(height: 4),
                            Text(p['distance'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textLight)),
                            Text('⭐ ${p['rating']}', style: TextStyle(fontSize: 10, color: isSel ? c : AppColors.textMid, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _mapControl(IconData icon) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.65),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
        boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 6)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10), onTap: () {},
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
      ),
    );
  }
}

// Custom painters for the map canvas
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A2F4A).withOpacity(0.5)
      ..strokeWidth = 0.5;
    const step = 30.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override bool shouldRepaint(_) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = const Color(0xFF1E3A5F).withOpacity(0.8)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final roadGlow = Paint()
      ..color = const Color(0xFF00C9A7).withOpacity(0.06)
      ..strokeWidth = 14;

    // Horizontal roads
    final roads = [0.25, 0.5, 0.72];
    for (final r in roads) {
      canvas.drawLine(Offset(0, size.height * r), Offset(size.width, size.height * r), roadGlow);
      canvas.drawLine(Offset(0, size.height * r), Offset(size.width, size.height * r), road);
    }
    // Vertical roads
    final vroads = [0.25, 0.55, 0.78];
    for (final r in vroads) {
      canvas.drawLine(Offset(size.width * r, 0), Offset(size.width * r, size.height), roadGlow);
      canvas.drawLine(Offset(size.width * r, 0), Offset(size.width * r, size.height), road);
    }
    // Diagonal accent road
    final diagPaint = Paint()
      ..color = const Color(0xFF9B5DE5).withOpacity(0.12)
      ..strokeWidth = 6;
    canvas.drawLine(Offset(0, size.height * 0.1), Offset(size.width * 0.6, size.height * 0.9), diagPaint);
  }
  @override bool shouldRepaint(_) => false;
}

// ══════════════════════════════════════════════════════════
// PAGE 3: SERVICES + PROVIDERS
// ══════════════════════════════════════════════════════════
class ServicesAndDetailsPage extends StatefulWidget {
  final String city, area;
  const ServicesAndDetailsPage({super.key, required this.city, required this.area});
  @override State<ServicesAndDetailsPage> createState() => _ServicesAndDetailsPageState();
}

class _ServicesAndDetailsPageState extends State<ServicesAndDetailsPage> {
  String chosenService = '';
  bool loadingData = false;
  List<ProviderModel> availableList   = [];
  List<ProviderModel> unavailableList = [];

  void _loadProviders(String type) {
    setState(() { loadingData = true; chosenService = type; });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        loadingData = false; availableList.clear(); unavailableList.clear();
        if (type == 'AC Repair') {
          availableList.add(ProviderModel(name: 'Ali Mohammad', specialty: 'Inverter AC Expert', rating: 4.9, reviews: 142, isAvailable: true, eta: 10, nextAvailableIn: '', phone: '03001234567'));
          unavailableList.add(ProviderModel(name: 'Farhan Khan', specialty: 'Gas Leakage Specialist', rating: 4.3, reviews: 76, isAvailable: false, eta: 0, nextAvailableIn: '45 Mins', phone: '03019988771'));
        } else if (type == 'Plumber') {
          availableList.add(ProviderModel(name: 'Ghulam Mustafa', specialty: 'Water Leakage Expert', rating: 4.8, reviews: 94, isAvailable: true, eta: 8, nextAvailableIn: '', phone: '03217654321'));
          unavailableList.add(ProviderModel(name: 'Asif Raza', specialty: 'Sanitary Fittings Expert', rating: 4.2, reviews: 31, isAvailable: false, eta: 0, nextAvailableIn: '30 Mins', phone: '03451122334'));
        } else {
          availableList.add(ProviderModel(name: 'Zeeshan Ahmed', specialty: 'Home Wiring Fixer', rating: 4.6, reviews: 118, isAvailable: true, eta: 15, nextAvailableIn: '', phone: '03339876543'));
          unavailableList.add(ProviderModel(name: 'Tariq Mahmood', specialty: 'UPS Repair Specialist', rating: 4.4, reviews: 89, isAvailable: false, eta: 0, nextAvailableIn: '50 Mins', phone: '03009988776'));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    final loc = "${LocalizedStrings.get(context, widget.area)}, ${LocalizedStrings.get(context, widget.city)}";

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: AnimatedBackgroundIcons(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  gradient: AppGradients.hero,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                  border: Border.all(color: AppColors.primary.withOpacity(0.15)),
                  boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 20, offset: Offset(0, 6))],
                ),
                child: Column(
                  crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    const LanguageSwitcherRow(),
                    const SizedBox(height: 18),
                    Row(mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
                      if (!isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 18), onPressed: () => Navigator.pop(context)),
                      const Icon(Icons.location_on_rounded, color: AppColors.accent, size: 16),
                      const SizedBox(width: 6),
                      Text(loc, style: const TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w800)),
                      if (isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.primary, size: 18), onPressed: () => Navigator.pop(context)),
                    ]),
                    const SizedBox(height: 16),
                    Text(LocalizedStrings.get(context, 'selectServiceTitle'),
                      style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Row(children: [
                      _serviceBtn('AC Repair',   '❄️', const Color(0xFF0EA5E9)),
                      const SizedBox(width: 10),
                      _serviceBtn('Plumber',     '🔧', const Color(0xFFF59E0B)),
                      const SizedBox(width: 10),
                      _serviceBtn('Electrician', '⚡', const Color(0xFF22C55E)),
                    ]),
                  ],
                ),
              ),

              Expanded(
                child: chosenService.isEmpty
                    ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.glowCyan,
                            boxShadow: [BoxShadow(color: AppColors.glowCyan, blurRadius: 30)]),
                          child: const Icon(Icons.touch_app_rounded, size: 48, color: AppColors.primary),
                        ),
                        const SizedBox(height: 16),
                        Text(LocalizedStrings.get(context, 'selectServicePrompt'),
                          style: const TextStyle(color: AppColors.textMid, fontSize: 13), textAlign: TextAlign.center),
                      ]))
                    : loadingData
                        ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                        : ListView(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                            children: [
                              _sectionHeader(LocalizedStrings.get(context, 'availableNowTitle'), AppColors.primary, Icons.check_circle_rounded, isUrdu),
                              if (availableList.isNotEmpty) _availableCard(availableList.first, context),
                              const SizedBox(height: 22),
                              _sectionHeader(LocalizedStrings.get(context, 'busyTitle'), AppColors.textMid, Icons.hourglass_top_rounded, isUrdu),
                              ...unavailableList.map((p) => _busyCard(p)),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String text, Color color, IconData icon, bool isUrdu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isUrdu
            ? [Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color)), const SizedBox(width: 8), Icon(icon, size: 16, color: color)]
            : [Icon(icon, size: 16, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color))],
      ),
    );
  }

  Widget _availableCard(ProviderModel p, BuildContext context) {
    return GlowCard(
      glowColor: const Color(0xFF22C55E),
      padding: EdgeInsets.zero,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                gradient: AppGradients.accentBtn, shape: BoxShape.circle,
                boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 14)],
              ),
              child: Center(child: Text(p.name[0], style: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w900))),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textDark)),
              const SizedBox(height: 3),
              Text(p.specialty, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.star_rounded, color: AppColors.accent, size: 14),
                const SizedBox(width: 3),
                Text('${p.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accent)),
                const SizedBox(width: 6),
                Text('(${p.reviews} reviews)', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
              ]),
            ])),
            Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withOpacity(0.15), borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.4)),
                  boxShadow: [const BoxShadow(color: Color(0x2022C55E), blurRadius: 8)],
                ),
                child: const Text('🟢 Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF22C55E))),
              ),
              const SizedBox(height: 6),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.access_time_rounded, size: 12, color: AppColors.textLight),
                const SizedBox(width: 3),
                Text('${p.eta} min', style: const TextStyle(fontSize: 11, color: AppColors.textMid, fontWeight: FontWeight.w600)),
              ]),
            ]),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF22C55E)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [const BoxShadow(color: Color(0x3022C55E), blurRadius: 12, offset: Offset(0, 4))],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12), onTap: () {},
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.phone_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text('Call ${p.phone}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapViewPage(city: '', area: ''))),
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  gradient: AppGradients.pinkPurple, borderRadius: BorderRadius.circular(12),
                  boxShadow: [const BoxShadow(color: AppColors.glowPurple, blurRadius: 12, offset: Offset(0, 4))],
                ),
                child: const Icon(Icons.map_rounded, color: Colors.white, size: 20),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _busyCard(ProviderModel p) {
    return GlowCard(
      glowColor: AppColors.accent.withOpacity(0.5),
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(16),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: AppColors.textLight.withOpacity(0.1), shape: BoxShape.circle,
            border: Border.all(color: AppColors.border)),
          child: Center(child: Text(p.name[0], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textMid))),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark)),
          const SizedBox(height: 3),
          Text(p.specialty, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10),
              boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 4)],
            ),
            child: const Text('Busy', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.accent)),
          ),
          const SizedBox(height: 4),
          Text('in ${p.nextAvailableIn}', style: const TextStyle(fontSize: 11, color: AppColors.textMid, fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }

  Widget _serviceBtn(String name, String emoji, Color activeColor) {
    final active = chosenService == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => _loadProviders(name),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 72,
          decoration: BoxDecoration(
            color: active ? activeColor.withOpacity(0.18) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: active ? activeColor : Colors.white.withOpacity(0.12), width: active ? 2 : 1),
            boxShadow: active ? [BoxShadow(color: activeColor.withOpacity(0.4), blurRadius: 14)] : [],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(LocalizedStrings.get(context, name),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                color: active ? activeColor : Colors.white.withOpacity(0.6))),
          ]),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
// CHATBOT WIDGET
// ══════════════════════════════════════════════════════════
class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({super.key});
  @override State<ChatBotWidget> createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _ctrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_messages.isEmpty) {
      final lang = LanguageConfiguration.of(context)?.currentLanguage ?? AppLanguage.romanUrdu;
      String g = "Assalam-o-Alaikum! Main Assistant hoon. 🤖 Main Roman Urdu, Urdu aur English teeno samajh sakta hoon. Bataiye kya kaam hai?";
      if (lang == AppLanguage.english) g = "Hello! I am your AI Agent. 🤖 I can support English, Urdu, and Roman Urdu. How can I help you?";
      if (lang == AppLanguage.urdu)    g = "السلام علیکم! میں آپ کا اے آئی اسسٹنٹ ہوں۔ 🤖 میں اردو، انگلش اور رومن اردو سمجھ سکتا ہوں۔ بتائیے کیا خدمت کروں؟";
      _messages.add({"sender": "bot", "text": g});
    }
  }

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    final txt = _ctrl.text.trim();
    setState(() { _messages.add({"sender": "user", "text": txt}); _ctrl.clear(); });
    Future.delayed(const Duration(milliseconds: 400), () {
      final lower    = txt.toLowerCase();
      final isScript = txt.contains(RegExp(r'[\u0600-\u06FF]'));
      final isEn     = lower.contains('need') || lower.contains('help') || lower.contains('repair') || lower.contains('plumber');
      String reply;
      if (isScript) {
        if (txt.contains('اے سی') || txt.contains('گرمی')) reply = "❄️ ہمارے بہترین اے سی ٹیکنیشن علی محمد اس وقت دستیاب ہیں۔";
        else if (txt.contains('پلمبر') || txt.contains('پانی')) reply = "🔧 پانی کے مسئلے کے لیے غلام مصطفیٰ صاحب فوری دستیاب ہیں۔";
        else reply = "⚡ بجلی کے کام کے لیے ذیشان احمد حاضر ہیں۔";
      } else if (isEn) {
        if (lower.contains('ac') || lower.contains('cooling')) reply = "❄️ AC Expert Ali Mohammad is available right now with a 10 min ETA.";
        else if (lower.contains('plumber') || lower.contains('leak')) reply = "🔧 Plumber Ghulam Mustafa is ready to assist you in your area.";
        else reply = "⚡ Electrician Zeeshan Ahmed is active and can reach you soon.";
      } else {
        if (lower.contains('ac') || lower.contains('garmi')) reply = "❄️ AC repair ke liye Ali Mohammad is waqt active aur available hain.";
        else if (lower.contains('leak') || lower.contains('plumber')) reply = "🔧 Water leakage ke liye Ghulam Mustafa sahab available hain.";
        else reply = "⚡ Electrician wiring fix karne ke liye tayyar hain.";
      }
      setState(() => _messages.add({"sender": "bot", "text": reply}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.62,
        decoration: BoxDecoration(
          gradient: AppGradients.heroAccent,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: const Border(top: BorderSide(color: AppColors.glowCyan, width: 1)),
          boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 20, offset: Offset(0, -4))],
        ),
        child: Column(children: [
          const SizedBox(height: 10),
          Container(width: 42, height: 4,
            decoration: BoxDecoration(
              gradient: AppGradients.accentBtn,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 8)],
            )),
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.fromLTRB(20, 14, 16, 14),
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              border: const Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppGradients.accentBtn, borderRadius: BorderRadius.circular(10),
                  boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 10)],
                ),
                child: const Icon(Icons.smart_toy_rounded, color: Colors.black87, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('AI Multi-Lang Orchestrator', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w800, fontSize: 14)),
                Text('Online • Tri-lingual support', style: TextStyle(color: AppColors.primary, fontSize: 11)),
              ])),
              IconButton(icon: const Icon(Icons.close_rounded, color: AppColors.textMid), onPressed: () => Navigator.pop(context)),
            ]),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final isUser = _messages[i]["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      gradient: isUser ? AppGradients.accentBtn : null,
                      color: isUser ? null : AppColors.bgCard,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 16),
                      ),
                      border: isUser ? null : Border.all(color: AppColors.border),
                      boxShadow: [BoxShadow(
                        color: isUser ? AppColors.glowCyan : Colors.black.withOpacity(0.3),
                        blurRadius: isUser ? 10 : 4, offset: const Offset(0, 2))],
                    ),
                    child: Text(_messages[i]["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.black87 : AppColors.textDark,
                        fontSize: 13, height: 1.4)),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 12, 14),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard, borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 6)],
                  ),
                  child: TextField(
                    controller: _ctrl,
                    style: const TextStyle(color: AppColors.textDark, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'AC kharab hai / I need plumber',
                      hintStyle: TextStyle(color: AppColors.textLight, fontSize: 12),
                      border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 11),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  gradient: AppGradients.accentBtn, shape: BoxShape.circle,
                  boxShadow: [const BoxShadow(color: AppColors.glowCyan, blurRadius: 14, offset: Offset(0, 3))],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22), onTap: _send,
                    child: const Icon(Icons.send_rounded, color: Colors.black87, size: 20),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}