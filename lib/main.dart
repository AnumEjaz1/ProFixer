import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ProFixerApp());
}

// Global Language Controller State
enum AppLanguage { english, urdu, romanUrdu }

class ProFixerApp extends StatefulWidget {
  const ProFixerApp({Key? key}) : super(key: key);

  @override
  State<ProFixerApp> createState() => _ProFixerAppState();
}

class _ProFixerAppState extends State<ProFixerApp> {
  AppLanguage _currentLang = AppLanguage.romanUrdu; // Default Language

  void _changeLanguage(AppLanguage lang) {
    setState(() {
      _currentLang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LanguageConfiguration(
      currentLanguage: _currentLang,
      onLanguageChanged: _changeLanguage,
      child: MaterialApp(
        title: 'Asan Khidmat Hub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0D9488),
          scaffoldBackgroundColor: const Color(0xFFF1F5F9), 
          fontFamily: 'sans-serif',
        ),
        home: const AppNavigationWrapper(), 
      ),
    );
  }
}

// InheritedWidget to broadcast language changes across all screens smoothly
class LanguageConfiguration extends InheritedWidget {
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const LanguageConfiguration({
    Key? key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required Widget child,
  }) : super(key: key, child: child);

  static LanguageConfiguration? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LanguageConfiguration>();
  }

  @override
  bool updateShouldNotify(LanguageConfiguration oldWidget) {
    return oldWidget.currentLanguage != currentLanguage;
  }
}

// Multi-Language Dictionary Matrix
class LocalizedStrings {
  static String get(BuildContext context, String key) {
    final lang = LanguageConfiguration.of(context)?.currentLanguage ?? AppLanguage.romanUrdu;
    
    final Map<String, Map<AppLanguage, String>> localizedValues = {
      'appName': {
        AppLanguage.english: 'Asan Khidmat Hub',
        AppLanguage.urdu: 'آسان خدمت ہب',
        AppLanguage.romanUrdu: 'Asan Khidmat Hub',
      },
      'tagline': {
        AppLanguage.english: 'Convenience at home, in just one click',
        AppLanguage.urdu: 'گھر بیٹھے سہولت، ایک کلک پر',
        AppLanguage.romanUrdu: 'Ghar bethe sahulat, aik click par',
      },
      'signUpTitle': {
        AppLanguage.english: 'Create Account ✨',
        AppLanguage.urdu: 'نیا اکاؤنٹ بنائیں ✨',
        AppLanguage.romanUrdu: 'Naya Account Banayein ✨',
      },
      'signUpSub': {
        AppLanguage.english: 'Register now to access premium informal services.',
        AppLanguage.urdu: 'آسان سہولیات کا فائدہ اٹھانے کے لیے ابھی رجسٹر کریں۔',
        AppLanguage.romanUrdu: 'Asan sahulat ka faida uthane ke liye register karein.',
      },
      'fullNameLabel': {
        AppLanguage.english: 'Full Name',
        AppLanguage.urdu: 'آپ کا نام (پورا نام)',
        AppLanguage.romanUrdu: 'Aap ka Naam (Full Name)',
      },
      'emailLabel': {
        AppLanguage.english: 'Email Address',
        AppLanguage.urdu: 'ای میل ایڈریس',
        AppLanguage.romanUrdu: 'Email Address',
      },
      'mobileLabel': {
        AppLanguage.english: 'Mobile Number',
        AppLanguage.urdu: 'موبائل نمبر',
        AppLanguage.romanUrdu: 'Mobile Number',
      },
      'passwordLabel': {
        AppLanguage.english: 'Password',
        AppLanguage.urdu: 'پاس ورڈ',
        AppLanguage.romanUrdu: 'Password',
      },
      'btnSignUp': {
        AppLanguage.english: 'Create Account (Sign Up)',
        AppLanguage.urdu: 'اکاؤنٹ بنائیں',
        AppLanguage.romanUrdu: 'Account Banayein (Sign Up)',
      },
      'alreadyAccount': {
        AppLanguage.english: 'Already have an account? Log In',
        AppLanguage.urdu: 'پہلے سے اکاؤنٹ ہے؟ لاگ ان کریں',
        AppLanguage.romanUrdu: 'Pehle se account hai? Log In karein',
      },
      'searchHint': {
        AppLanguage.english: 'How can I help you today?',
        AppLanguage.urdu: 'میں آپ کی کیا مدد کر سکتا ہوں؟',
        AppLanguage.romanUrdu: 'Main kya madad karoon aap ki?',
      },
      'chatPrompt': {
        AppLanguage.english: 'Tap below to chat with our AI Agent 💬',
        AppLanguage.urdu: 'اے آئی بوٹ سے بات کرنے کے لیے نیچے دبائیں 💬',
        AppLanguage.romanUrdu: 'Chatbot se baat karne ke liye niche 💬 dabayein',
      },
      'locationTitle': {
        AppLanguage.english: 'Select Location',
        AppLanguage.urdu: 'لوکیشن منتخب کریں',
        AppLanguage.romanUrdu: 'Location Chunye',
      },
      'locationSub': {
        AppLanguage.english: 'Select your city and operating area:',
        AppLanguage.urdu: 'اپنا شہر اور علاقہ منتخب کریں:',
        AppLanguage.romanUrdu: 'Apna Sheher aur Ilaqa muntakhif karein:',
      },
      'cityLabel': {
        AppLanguage.english: 'City',
        AppLanguage.urdu: 'شہر',
        AppLanguage.romanUrdu: 'Sheher (City)',
      },
      'areaLabel': {
        AppLanguage.english: 'Area',
        AppLanguage.urdu: 'علاقہ',
        AppLanguage.romanUrdu: 'Ilaqa (Area)',
      },
      'btnNext': {
        AppLanguage.english: 'Proceed Forward',
        AppLanguage.urdu: 'آگے چلیں',
        AppLanguage.romanUrdu: 'Aagay Chalein',
      },
      'selectServiceTitle': {
        AppLanguage.english: 'Select Required Service:',
        AppLanguage.urdu: 'سروس منتخب کریں:',
        AppLanguage.romanUrdu: 'Service Muntakhif Karein:',
      },
      'availableNowTitle': {
        AppLanguage.english: 'Available Now:',
        AppLanguage.urdu: 'ابھی دستیاب ہے:',
        AppLanguage.romanUrdu: 'Available Now (Abhi Maujood Hai):',
      },
      'busyTitle': {
        AppLanguage.english: 'Currently Busy Providers:',
        AppLanguage.urdu: 'مصروف فراہم کنندگان:',
        AppLanguage.romanUrdu: 'Filhal Busy Providers:',
      },
      'selectServicePrompt': {
        AppLanguage.english: 'Please select a service from above categories.',
        AppLanguage.urdu: 'اوپر سے کوئی بھی ایک سروس منتخب کریں۔',
        AppLanguage.romanUrdu: 'Upar se koi bhi aik service select karein.',
      },
      
      // Cities
      'Karachi': { AppLanguage.english: 'Karachi', AppLanguage.urdu: 'کراچی', AppLanguage.romanUrdu: 'Karachi' },
      'Lahore': { AppLanguage.english: 'Lahore', AppLanguage.urdu: 'لاہور', AppLanguage.romanUrdu: 'Lahore' },
      'Islamabad': { AppLanguage.english: 'Islamabad', AppLanguage.urdu: 'اسلام آباد', AppLanguage.romanUrdu: 'Islamabad' },

      // Areas
      'Saddar': { AppLanguage.english: 'Saddar', AppLanguage.urdu: 'صدر', AppLanguage.romanUrdu: 'Saddar' },
      'Gulshan-e-Iqbal': { AppLanguage.english: 'Gulshan-e-Iqbal', AppLanguage.urdu: 'گلشنِ اقبال', AppLanguage.romanUrdu: 'Gulshan-e-Iqbal' },
      'Clifton': { AppLanguage.english: 'Clifton', AppLanguage.urdu: 'کلفٹن', AppLanguage.romanUrdu: 'Clifton' },
      'Gulberg': { AppLanguage.english: 'Gulberg', AppLanguage.urdu: 'گلبرگ', AppLanguage.romanUrdu: 'Gulberg' },
      'DHA Phase 5': { AppLanguage.english: 'DHA Phase 5', AppLanguage.urdu: 'ڈی ایچ اے فیز 5', AppLanguage.romanUrdu: 'DHA Phase 5' },
      'Johar Town': { AppLanguage.english: 'Johar Town', AppLanguage.urdu: 'جوہر ٹاؤن', AppLanguage.romanUrdu: 'Johar Town' },
      'G-11': { AppLanguage.english: 'G-11', AppLanguage.urdu: 'جی الیون', AppLanguage.romanUrdu: 'G-11' },
      'F-6': { AppLanguage.english: 'F-6', AppLanguage.urdu: 'ایف سکس', AppLanguage.romanUrdu: 'F-6' },
      'I-9': { AppLanguage.english: 'I-9', AppLanguage.urdu: 'آئی نائن', AppLanguage.romanUrdu: 'I-9' },

      // Services
      'AC Repair': { AppLanguage.english: 'AC Repair', AppLanguage.urdu: 'اے سی کی مرمت', AppLanguage.romanUrdu: 'AC Repair' },
      'Plumber': { AppLanguage.english: 'Plumber', AppLanguage.urdu: 'پلمبر (نل ساز)', AppLanguage.romanUrdu: 'Plumber' },
      'Electrician': { AppLanguage.english: 'Electrician', AppLanguage.urdu: 'الیکٹریشن', AppLanguage.romanUrdu: 'Electrician' },
    };

    return localizedValues[key]?[lang] ?? key;
  }
}

// Reusable Language Switcher Row
class LanguageSwitcherRow extends StatelessWidget {
  const LanguageSwitcherRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = LanguageConfiguration.of(context);
    final current = config?.currentLanguage ?? AppLanguage.romanUrdu;
    final isUrdu = current == AppLanguage.urdu;

    return Row(
      mainAxisAlignment: isUrdu ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        _buildLangChip(context, 'English', AppLanguage.english, current == AppLanguage.english),
        const SizedBox(width: 6),
        _buildLangChip(context, 'اردو', AppLanguage.urdu, current == AppLanguage.urdu),
        const SizedBox(width: 6),
        _buildLangChip(context, 'Roman', AppLanguage.romanUrdu, current == AppLanguage.romanUrdu),
      ],
    );
  }

  Widget _buildLangChip(BuildContext context, String label, AppLanguage lang, bool isSelected) {
    return GestureDetector(
      onTap: () => LanguageConfiguration.of(context)?.onLanguageChanged(lang),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0D9488) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFCBD5E1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}

// Provider Data Model
class ProviderModel {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final bool isAvailable;
  final int eta; 
  final String nextAvailableIn; 
  final String phone;

  ProviderModel({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.isAvailable,
    required this.eta,
    required this.nextAvailableIn,
    required this.phone,
  });
}

// ==========================================================
// GLOBAL WRAPPER: PERSISTENT CHATBOT ACCROSS ALL PAGES
// ==========================================================
class AppNavigationWrapper extends StatefulWidget {
  const AppNavigationWrapper({Key? key}) : super(key: key);

  @override
  State<AppNavigationWrapper> createState() => _AppNavigationWrapperState();
}

class _AppNavigationWrapperState extends State<AppNavigationWrapper> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;

    return Scaffold(
      // FLOATING ACTION BUTTON ACCROSS EVERY ROUTE WINDOW (FIXED ATTRIBUTES)
      floatingActionButtonLocation: isUrdu 
          ? FloatingActionButtonLocation.startFloat 
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0F766E),
        child: const Icon(Icons.chat_rounded, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const ChatBotWidget(),
          );
        },
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => const CreateAccountPage(),
          );
        },
      ),
    );
  }
}

// ==========================================
// PAGE: CREATE ACCOUNT / SIGN UP SCREEN
// ==========================================
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isPasswordHidden = true;
  String _strengthText = '';
  Color _strengthColor = Colors.transparent;
  double _strengthProgress = 0.0;

  void _checkPasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        _strengthText = '';
        _strengthColor = Colors.transparent;
        _strengthProgress = 0.0;
      });
      return;
    }

    int score = 0;
    if (password.length >= 6) score++; 
    if (password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'))) score++; 
    if (password.contains(RegExp(r'[0-9]'))) score++; 
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++; 

    setState(() {
      if (score <= 2) {
        _strengthText = 'Weak 🔴';
        _strengthColor = Colors.red;
        _strengthProgress = 0.33;
      } else if (score == 3) {
        _strengthText = 'Medium 🟡';
        _strengthColor = Colors.orange;
        _strengthProgress = 0.66;
      } else if (score >= 4) {
        _strengthText = 'Strong 🟢';
        _strengthColor = Colors.green;
        _strengthProgress = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  const LanguageSwitcherRow(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (isUrdu) ...[
                        Text(LocalizedStrings.get(context, 'appName'), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
                        const SizedBox(width: 8),
                      ],
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.handyman_rounded, color: Color(0xFF0D9488), size: 20),
                      ),
                      if (!isUrdu) ...[
                        const SizedBox(width: 8),
                        Text(LocalizedStrings.get(context, 'appName'), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    LocalizedStrings.get(context, 'signUpTitle'),
                    textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LocalizedStrings.get(context, 'signUpSub'), 
                    textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                  ),
                  const SizedBox(height: 26),

                  _buildInputFieldLabel(LocalizedStrings.get(context, 'fullNameLabel')),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: TextFormField(
                      controller: _nameController,
                      textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        prefixIcon: isUrdu ? null : const Icon(Icons.person_outline, color: Color(0xFF94A3B8), size: 20),
                        suffixIcon: isUrdu ? const Icon(Icons.person_outline, color: Color(0xFF94A3B8), size: 20) : null,
                        hintText: 'Anum Ejaz',
                        hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: (value) => (value == null || value.trim().isEmpty) ? 'Required Field' : null,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _buildInputFieldLabel(LocalizedStrings.get(context, 'emailLabel')),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        prefixIcon: isUrdu ? null : const Icon(Icons.mail_outline, color: Color(0xFF94A3B8), size: 20),
                        suffixIcon: isUrdu ? const Icon(Icons.mail_outline, color: Color(0xFF94A3B8), size: 20) : null,
                        hintText: 'name@example.com',
                        hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Field cannot be empty';
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) return 'Invalid Email Format';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 14),

                  _buildInputFieldLabel(LocalizedStrings.get(context, 'mobileLabel')),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
                      textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        prefixIcon: isUrdu ? null : const Icon(Icons.phone_android_outlined, color: Color(0xFF94A3B8), size: 20),
                        suffixIcon: isUrdu ? const Icon(Icons.phone_android_outlined, color: Color(0xFF94A3B8), size: 20) : null,
                        hintText: '03001234567',
                        hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required Field';
                        if (value.length < 11) return 'Must be 11 digits';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 14),

                  _buildInputFieldLabel(LocalizedStrings.get(context, 'passwordLabel')),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordHidden,
                      onChanged: _checkPasswordStrength, 
                      textAlign: isUrdu ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8), size: 20),
                        hintText: '••••••••',
                        hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: const Color(0xFF94A3B8), size: 20),
                          onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                        ),
                      ),
                      validator: (value) => (value == null || value.length < 6) ? 'Password too short' : null,
                    ),
                  ),

                  if (_passwordController.text.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(value: _strengthProgress, backgroundColor: const Color(0xFFE2E8F0), valueColor: AlwaysStoppedAnimation<Color>(_strengthColor), minHeight: 4),
                        const SizedBox(height: 4),
                        Text(_strengthText, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _strengthColor)),
                      ],
                    ),
                  ],
                  
                  const SizedBox(height: 28),

                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: const Color(0xFF0D9488).withOpacity(0.25), blurRadius: 15, offset: const Offset(0, 6))]),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D9488), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeHomePage()));
                          }
                        },
                        child: Text(LocalizedStrings.get(context, 'btnSignUp'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeHomePage())),
                      child: Text(LocalizedStrings.get(context, 'alreadyAccount'), style: const TextStyle(color: Color(0xFF0D9488), fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldLabel(String labelText) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Align(
        alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(labelText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
      ),
    );
  }
}

// ==========================================
// PAGE 1: WELCOME HOME PAGE 
// ==========================================
class WelcomeHomePage extends StatelessWidget {
  const WelcomeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LanguageSwitcherRow(),
              const Spacer(),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF0F766E), Color(0xFF14B8A6)]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.handyman_rounded, size: 44, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(LocalizedStrings.get(context, 'appName'), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 6),
              Text(LocalizedStrings.get(context, 'tagline'), style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationPage())),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2E8F0))),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: Color(0xFF0D9488), size: 22),
                      const SizedBox(width: 14),
                      Expanded(child: Text(LocalizedStrings.get(context, 'searchHint'), style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)))),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(LocalizedStrings.get(context, 'chatPrompt'), style: TextStyle(fontSize: 12, color: Colors.grey[400], fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE 2: LOCATION SELECTOR PAGE
// ==========================================
class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String selectedCity = 'Karachi';
  String selectedArea = 'Saddar';

  final List<String> citiesList = ['Karachi', 'Lahore', 'Islamabad'];
  final Map<String, List<String>> cityAreasMap = {
    'Karachi': ['Saddar', 'Gulshan-e-Iqbal', 'Clifton'],
    'Lahore': ['Gulberg', 'DHA Phase 5', 'Johar Town'],
    'Islamabad': ['G-11', 'F-6', 'I-9'],
  };

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              const LanguageSwitcherRow(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 18), onPressed: () => Navigator.pop(context)),
                  Text(LocalizedStrings.get(context, 'locationTitle'), style: const TextStyle(color: Color(0xFF1E293B), fontSize: 18, fontWeight: FontWeight.bold)),
                  if (isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF1E293B), size: 18), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 20),
              Text(LocalizedStrings.get(context, 'locationSub'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
              const SizedBox(height: 24),
              _buildSelectionLabel(LocalizedStrings.get(context, 'cityLabel')),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCity,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B), fontWeight: FontWeight.w600),
                    alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                    items: citiesList.map((c) => DropdownMenuItem(
                      value: c, 
                      child: Align(
                        alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(LocalizedStrings.get(context, c))
                      )
                    )).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCity = val!;
                        selectedArea = cityAreasMap[selectedCity]![0];
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSelectionLabel(LocalizedStrings.get(context, 'areaLabel')),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedArea,
                    isExpanded: true,
                    alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                    items: cityAreasMap[selectedCity]!.map((a) => DropdownMenuItem(
                      value: a, 
                      child: Align(
                        alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(LocalizedStrings.get(context, a))
                      )
                    )).toList(),
                    onChanged: (val) => setState(() => selectedArea = val!),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D9488), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesAndDetailsPage(city: selectedCity, area: selectedArea))),
                  child: Text(LocalizedStrings.get(context, 'btnNext'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionLabel(String text) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.bold))
      ),
    );
  }
}

// ==========================================
// PAGE 3: DUAL LIST VIEW 
// ==========================================
class ServicesAndDetailsPage extends StatefulWidget {
  final String city;
  final String area;
  const ServicesAndDetailsPage({Key? key, required this.city, required this.area}) : super(key: key);

  @override
  State<ServicesAndDetailsPage> createState() => _ServicesAndDetailsPageState();
}

class _ServicesAndDetailsPageState extends State<ServicesAndDetailsPage> {
  String chosenService = '';
  bool loadingData = false;
  List<ProviderModel> availableProvidersList = [];
  List<ProviderModel> unavailableProvidersList = [];

  void loadServiceRowData(String type) {
    setState(() {
      loadingData = true;
      chosenService = type;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        loadingData = false;
        availableProvidersList.clear();
        unavailableProvidersList.clear();

        if (type == 'AC Repair') {
          availableProvidersList.add(ProviderModel(name: 'Ali Mohammad', specialty: 'Inverter AC Expert', rating: 4.9, reviews: 142, isAvailable: true, eta: 10, nextAvailableIn: '', phone: '03001234567'));
          unavailableProvidersList.add(ProviderModel(name: 'Farhan Khan', specialty: 'Gas Leakage Specialist', rating: 4.3, reviews: 76, isAvailable: false, eta: 0, nextAvailableIn: '45 Mins', phone: '03019988771'));
        } else if (type == 'Plumber') {
          availableProvidersList.add(ProviderModel(name: 'Ghulam Mustafa', specialty: 'Water Leakage Expert', rating: 4.8, reviews: 94, isAvailable: true, eta: 8, nextAvailableIn: '', phone: '03217654321'));
          unavailableProvidersList.add(ProviderModel(name: 'Asif Raza', specialty: 'Sanitary Fittings Expert', rating: 4.2, reviews: 31, isAvailable: false, eta: 0, nextAvailableIn: '30 Mins', phone: '03451122334'));
        } else {
          availableProvidersList.add(ProviderModel(name: 'Zeeshan Ahmed', specialty: 'Home Wiring Fixer', rating: 4.6, reviews: 118, isAvailable: true, eta: 15, nextAvailableIn: '', phone: '03339876543'));
          unavailableProvidersList.add(ProviderModel(name: 'Tariq Mahmood', specialty: 'UPS Repair Specialist', rating: 4.4, reviews: 89, isAvailable: false, eta: 0, nextAvailableIn: '50 Mins', phone: '03009988776'));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUrdu = LanguageConfiguration.of(context)?.currentLanguage == AppLanguage.urdu;
    String displayLocation = "${LocalizedStrings.get(context, widget.area)}, ${LocalizedStrings.get(context, widget.city)}";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              const LanguageSwitcherRow(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: isUrdu ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 18), onPressed: () => Navigator.pop(context)),
                  Text(displayLocation, style: const TextStyle(color: Color(0xFF0D9488), fontSize: 16, fontWeight: FontWeight.bold)),
                  if (isUrdu) IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87, size: 18), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 14),
              Text(LocalizedStrings.get(context, 'selectServiceTitle'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildOptionButton('AC Repair', '❄️', const Color(0xFF0284C7)),
                  const SizedBox(width: 10),
                  _buildOptionButton('Plumber', '🔧', const Color(0xFFD97706)),
                  const SizedBox(width: 10),
                  _buildOptionButton('Electrician', '⚡', const Color(0xFF16A34A)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: chosenService.isEmpty
                    ? Center(child: Text(LocalizedStrings.get(context, 'selectServicePrompt'), style: TextStyle(color: Colors.grey[500], fontSize: 13)))
                    : loadingData
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)))
                        : ListView(
                            children: [
                              Align(
                                alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                                child: Text(LocalizedStrings.get(context, 'availableNowTitle'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F766E)))
                              ),
                              if (availableProvidersList.isNotEmpty) _buildAvailableCard(availableProvidersList.first),
                              const SizedBox(height: 20),
                              Align(
                                alignment: isUrdu ? Alignment.centerRight : Alignment.centerLeft,
                                child: Text(LocalizedStrings.get(context, 'busyTitle'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))
                              ),
                              ...unavailableProvidersList.map((p) => _buildUnavailableCard(p)).toList(),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailableCard(ProviderModel provider) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        children: [
          ListTile(
            title: Text(provider.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${provider.specialty} • ETA: ${provider.eta} Mins'),
            trailing: const Text('🟢 Active', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 40)),
            onPressed: () {},
            icon: const Icon(Icons.phone, color: Colors.white),
            label: Text('Call ${provider.phone}', style: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildUnavailableCard(ProviderModel provider) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(provider.name),
        subtitle: Text('Busy • Available in: ${provider.nextAvailableIn}'),
        trailing: const Icon(Icons.hourglass_empty, color: Colors.amber),
      ),
    );
  }

  Widget _buildOptionButton(String name, String badge, Color activeBorderColor) {
    bool isActive = chosenService == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => loadServiceRowData(name),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : const Color(0xFFE2E8F0).withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isActive ? activeBorderColor : Colors.transparent, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(badge, style: const TextStyle(fontSize: 20)),
              Text(
                LocalizedStrings.get(context, name),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? activeBorderColor : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TRI-LINGUAL AI CHATBOT AGENT ENGINE
// ==========================================
class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({Key? key}) : super(key: key);

  @override
  State<ChatBotWidget> createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _chatController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_messages.isEmpty) {
      final lang = LanguageConfiguration.of(context)?.currentLanguage ?? AppLanguage.romanUrdu;
      String greeting = "Assalam-o-Alaikum! Main Assistant hoon. 🤖 Main Roman Urdu, Urdu aur English teeno samajh sakta hoon. Bataiye kya kaam hai?";
      if (lang == AppLanguage.english) greeting = "Hello! I am your AI Agent. 🤖 I can support English, Urdu, and Roman Urdu. How can I help you?";
      if (lang == AppLanguage.urdu) greeting = "السلام علیکم! میں آپ کا اے آئی اسسٹنٹ ہوں۔ 🤖 میں اردو، انگلش اور رومن اردو سمجھ سکتا ہوں۔ بتائیے کیا خدمت کروں؟";
      
      _messages.add({"sender": "bot", "text": greeting});
    }
  }

  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return;
    String userText = _chatController.text.trim();
    
    setState(() {
      _messages.add({"sender": "user", "text": userText});
      _chatController.clear();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      String botReply = "Processing query details...";
      String lowerInput = userText.toLowerCase();

      bool isEnglish = lowerInput.contains('need') || lowerInput.contains('help') || lowerInput.contains('repair') || lowerInput.contains('plumber');
      bool isUrduScript = userText.contains(RegExp(r'[\u0600-\u06FF]'));

      if (isUrduScript) {
        if (userText.contains('اے سی') || userText.contains('گرمی')) {
          botReply = "❄️ ہمارے بہترین اے سی ٹیکنیشن علی محمد اس وقت دستیاب ہیں۔";
        } else if (userText.contains('پلمبر') || userText.contains('پانی')) {
          botReply = "🔧 پانی کے مسئلے کے لیے غلام مصطفیٰ صاحب فوری دستیاب ہیں۔";
        } else {
          botReply = "⚡ بجلی کے کام کے لیے ذیشان احمد حاضر ہیں۔";
        }
      } else if (isEnglish) {
        if (lowerInput.contains('ac') || lowerInput.contains('cooling')) {
          botReply = "❄️ AC Expert Ali Mohammad is available right now with a 10 min ETA.";
        } else if (lowerInput.contains('plumber') || lowerInput.contains('leak')) {
          botReply = "🔧 Plumber Ghulam Mustafa is ready to assist you in your area.";
        } else {
          botReply = "⚡ Electrician Zeeshan Ahmed is active and can reach you soon.";
        }
      } else {
        if (lowerInput.contains('ac') || lowerInput.contains('garmi')) {
          botReply = "❄️ AC repair ke liye Ali Mohammad is waqt active aur available hain.";
        } else if (lowerInput.contains('leak') || lowerInput.contains('plumber')) {
          botReply = "🔧 Water leakage ke liye Ghulam Mustafa sahab available hain.";
        } else {
          botReply = "⚡ Electrician wiring fix karne ke liye tayyar hain.";
        }
      }

      setState(() {
        _messages.add({"sender": "bot", "text": botReply});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF0F766E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('AI Multi-Lang Orchestrator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, i) {
                  bool isUser = _messages[i]["sender"] == "user";
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: isUser ? const Color(0xFF0D9488) : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
                      child: Text(_messages[i]["text"]!, style: TextStyle(color: isUser ? Colors.white : Colors.black87)),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFFF8FAFC),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      decoration: const InputDecoration(hintText: 'Type: AC kharab hai / I need plumber', border: InputBorder.none),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.send, color: Color(0xFF0D9488)), onPressed: _sendMessage),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}