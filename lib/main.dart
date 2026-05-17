import 'package:flutter/material.dart';

void main() {
  runApp(const AsanKhidmatApp());
}

class AsanKhidmatApp extends StatelessWidget {
  const AsanKhidmatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asan Khidmat Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0D9488),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9), 
        fontFamily: 'sans-serif',
      ),
      home: const CreateAccountPage(), 
    );
  }
}

// Data Model for Service Providers
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

  // Password Strength State Variables
  String _strengthText = '';
  Color _strengthColor = Colors.transparent;
  double _strengthProgress = 0.0;

  // Real-time Visual Password Strength Logic
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
        _strengthText = 'Weak 🔴 (Ghair-Mahfooz)';
        _strengthColor = Colors.red;
        _strengthProgress = 0.33;
      } else if (score == 3) {
        _strengthText = 'Medium 🟡 (Behtar hai)';
        _strengthColor = Colors.orange;
        _strengthProgress = 0.66;
      } else if (score >= 4) {
        _strengthText = 'Strong 🟢 (Nihayat Mazboot)';
        _strengthColor = Colors.green;
        _strengthProgress = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D9488).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.handyman_rounded, color: Color(0xFF0D9488), size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text('Asan Khidmat Hub', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Naya Account\nBanayein ✨',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), height: 1.2),
                ),
                const SizedBox(height: 8),
                const Text('Asan sahulat ka faida uthane ke liye register karein.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                const SizedBox(height: 30),

                _buildInputFieldLabel('Aap ka Naam (Full Name)'),
                _buildNormalTextField(_nameController, Icons.person_outline, 'E.g., Anum Ejaz'),
                const SizedBox(height: 16),

                _buildInputFieldLabel('Email Address'),
                _buildNormalTextField(_emailController, Icons.mail_outline, 'name@example.com'),
                const SizedBox(height: 16),

                _buildInputFieldLabel('Mobile Number'),
                _buildNormalTextField(_phoneController, Icons.phone_android_outlined, '03001234567'),
                const SizedBox(height: 16),

                _buildInputFieldLabel('Password'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(14), 
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isPasswordHidden,
                    onChanged: _checkPasswordStrength, 
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8), size: 20),
                      hintText: '••••••••',
                      hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          color: const Color(0xFF94A3B8),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                    ),
                    
                    // FIXED STRICT ERROR VALIDATION RULES WITH ESCAPED $ SIGN
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password box khali nahi chora ja sakta';
                      }
                      if (value.length < 6) {
                        return 'Kam az kam 6 characters zaroori hain';
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Aik Capital letter (A-Z) hona lazmi hai';
                      }
                      if (!value.contains(RegExp(r'[a-z]'))) {
                        return 'Aik Small letter (a-z) hona lazmi hai';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Kam az kam aik Number (0-9) hona lazmi hai';
                      }
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Aik Special Symbol (E.g. @, #, \$) hona lazmi hai';
                      }
                      return null;
                    },
                  ),
                ),

                // PASSWORD STRENGTH PROGRESS INDICATOR
                if (_passwordController.text.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _strengthProgress,
                            backgroundColor: const Color(0xFFE2E8F0),
                            valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
                            minHeight: 5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Password Level: $_strengthText',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _strengthColor),
                        ),
                      ],
                    ),
                  ),
                ],
                
                const SizedBox(height: 32),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF0D9488).withOpacity(0.25), blurRadius: 15, offset: const Offset(0, 6))
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D9488),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Khush Aamdeed ${_nameController.text}! Account ban gaya.')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const WelcomeHomePage()),
                          );
                        }
                      },
                      child: const Text('Account Banayein (Sign Up)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomeHomePage()),
                      );
                    },
                    child: const Text(
                      'Pehle se account hai? Log In karein',
                      style: TextStyle(color: Color(0xFF0D9488), fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldLabel(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(labelText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
    );
  }

  Widget _buildNormalTextField(TextEditingController controller, IconData icon, String hint) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Yeh box khali nahi chora ja sakta';
          return null;
        },
      ),
    );
  }
}

// ==========================================
// PAGE 1: WELCOME HOME PAGE WITH PREMIUM LOGO & CHATBOT
// ==========================================
class WelcomeHomePage extends StatelessWidget {
  const WelcomeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF0D9488).withOpacity(0.1)),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0F766E), Color(0xFF14B8A6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [BoxShadow(color: const Color(0xFF0D9488).withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: const Icon(Icons.handyman_rounded, size: 48, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  const Text('Asan Khidmat Hub', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: 0.5)),
                  const SizedBox(height: 6),
                  const Text('Ghar bethe sahulat, aik click par', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                  const SizedBox(height: 48),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                        boxShadow: [BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search_rounded, color: Color(0xFF0D9488), size: 24),
                          SizedBox(width: 14),
                          Expanded(child: Text('How can I help you? / Main kya madad karoon?', style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text('Chatbot se baat karne ke liye niche 💬 dabayein', style: TextStyle(fontSize: 12, color: Colors.grey[400], fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
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
    return Scaffold(
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Location Chunye', style: TextStyle(color: Color(0xFF1E293B), fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Apna Sheher aur Ilaqa muntakhif karein:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
            const SizedBox(height: 24),
            _buildSelectionLabel('Sheher (City)'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCity,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
                  style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B), fontWeight: FontWeight.w600),
                  items: citiesList.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
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
            _buildSelectionLabel('Ilaqa (Area)'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedArea,
                  isExpanded: true,
                  icon: const Icon(Icons.location_on_rounded, color: Color(0xFF0D9488)),
                  style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B), fontWeight: FontWeight.w600),
                  items: cityAreasMap[selectedCity]!.map((a) => DropdownMenuItem(value: a, child: Text(a))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedArea = val!;
                    });
                  },
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: const Color(0xFF0D9488).withOpacity(0.25), blurRadius: 15, offset: const Offset(0, 6))],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9488),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesAndDetailsPage(city: selectedCity, area: selectedArea)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Aagay Chalein ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
    );
  }
}

// ==========================================
// PAGE 3: DUAL LIST VIEW (AVAILABLE & UNAVAILABLE)
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

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        loadingData = false;
        availableProvidersList.clear();
        unavailableProvidersList.clear();

        if (type == 'AC Repair') {
          availableProvidersList.add(
            ProviderModel(
              name: 'Ali Mohammad',
              specialty: 'Inverter AC & Split System Expert',
              rating: 4.9,
              reviews: 142,
              isAvailable: true,
              eta: 10,
              nextAvailableIn: '',
              phone: '+92 300 1234567',
            ),
          );
          
          unavailableProvidersList.addAll([
            ProviderModel(
              name: 'Farhan Khan',
              specialty: 'Gas Refilling & Leakage Specialist',
              rating: 4.3,
              reviews: 76,
              isAvailable: false,
              eta: 0,
              nextAvailableIn: '45 Minutes',
              phone: '+92 301 9988771',
            ),
            ProviderModel(
              name: 'Kamran Akmal',
              specialty: 'Compressor & Outer Fan Fixer',
              rating: 4.5,
              reviews: 52,
              isAvailable: false,
              eta: 0,
              nextAvailableIn: '2 Hours',
              phone: '+92 312 4455667',
            ),
          ]);
        } 
        
        else if (type == 'Plumber') {
          availableProvidersList.add(
            ProviderModel(
              name: 'Ghulam Mustafa',
              specialty: 'Underground Water Leakage Expert',
              rating: 4.8,
              reviews: 94,
              isAvailable: true,
              eta: 8,
              nextAvailableIn: '',
              phone: '+92 321 7654321',
            ),
          );

          unavailableProvidersList.addAll([
            ProviderModel(
              name: 'Asif Raza',
              specialty: 'Sanitary Fittings & Geyser Expert',
              rating: 4.2,
              reviews: 31,
              isAvailable: false,
              eta: 0,
              nextAvailableIn: '30 Minutes',
              phone: '+92 345 1122334',
            ),
            ProviderModel(
              name: 'Muhammad Bilal',
              specialty: 'Drainage & Pipe Blockage Specialist',
              rating: 4.6,
              reviews: 64,
              isAvailable: false,
              eta: 0,
              nextAvailableIn: '1 Hour 15 Mins',
              phone: '+92 333 4455661',
            ),
          ]);
        } 
        
        else {
          availableProvidersList.add(
            ProviderModel(
              name: 'Zeeshan Ahmed',
              specialty: 'Short Circuit Fixer & Home Wiring',
              rating: 4.6,
              reviews: 118,
              isAvailable: true,
              eta: 15,
              nextAvailableIn: '',
              phone: '+92 333 9876543',
            ),
          );

          unavailableProvidersList.addAll([
            ProviderModel(
              name: 'Tariq Mahmood',
              specialty: 'Ceiling Fan & Generator Repair',
              rating: 4.4,
              reviews: 89,
              isAvailable: false,
              eta: 0,
              nextAvailableIn: '50 Minutes',
              phone: '+92 300 9988776',
            ),
            ProviderModel(
              name: 'Sajid Ali',
              specialty: 'UPS & Inverter Wiring Specialist',
              rating: 4.7,
              reviews: 102,
              isAvailable: false,
              eta: 0,
              nextAvailableIn: '3 Hours',
              phone: '+92 321 5566778',
            ),
          ]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D9488),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.location_on_rounded, size: 16, color: Colors.white70),
            const SizedBox(width: 6),
            Text('${widget.area}, ${widget.city}', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Service Muntakhif Karein:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildOptionButton('AC Repair', '❄️', const Color(0xFF0284C7)),
                const SizedBox(width: 10),
                _buildOptionButton('Plumber', '🔧', const Color(0xFFD97706)),
                const SizedBox(width: 10),
                _buildOptionButton('Electrician', '⚡', const Color(0xFF16A34A)),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFCBD5E1), thickness: 1),
            const SizedBox(height: 10),
            
            Expanded(
              child: chosenService.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bubble_chart_outlined, size: 44, color: Colors.grey[400]),
                          const SizedBox(height: 8),
                          Text('Upar se koi bhi aik service select karein.', style: TextStyle(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )
                  : loadingData
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFF0D9488)))
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 4, bottom: 10, top: 6),
                                child: Text('Available Now (Abhi Maujood Hai):', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
                              ),
                              
                              if (availableProvidersList.isNotEmpty) 
                                _buildAvailableProviderCard(availableProvidersList.first),
                              
                              const SizedBox(height: 24),
                              
                              Row(
                                children: [
                                  const Text('Filhal Busy Providers (Back-up Options):', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(10)),
                                    child: Text('${unavailableProvidersList.length}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: unavailableProvidersList.length,
                                itemBuilder: (context, index) {
                                  return _buildUnavailableProviderCard(unavailableProvidersList[index]);
                                },
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableProviderCard(ProviderModel provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(chosenService.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0D9488), fontSize: 11, letterSpacing: 1)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(20)),
                child: const Text('● Available Now', style: TextStyle(color: Color(0xFF15803D), fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFF1F5F9),
                child: Text(chosenService == 'AC Repair' ? '❄️' : chosenService == 'Plumber' ? '🔧' : '⚡', style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    const SizedBox(height: 4),
                    Text(provider.specialty, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(provider.rating.toString(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                        const SizedBox(width: 6),
                        Text('(${provider.reviews} reviews)', style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFF1F5F9))),
            child: Row(
              children: [
                const Icon(Icons.electric_bolt_rounded, color: Color(0xFFD97706), size: 18),
                const SizedBox(width: 8),
                Text('Estimated Arrival: ', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                Text('${provider.eta} Minutes', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${provider.name} (${provider.phone}) ko call lagayi ja rahi hai...')));
              },
              icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 18),
              label: Text('Direct Call (${provider.phone})', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnavailableProviderCard(ProviderModel provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFF8FAFC),
                child: Text(chosenService == 'AC Repair' ? '❄️' : chosenService == 'Plumber' ? '🔧' : '⚡', style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                    const SizedBox(height: 2),
                    Text(provider.specialty, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    const SizedBox(width: 2),
                    Text(provider.rating.toString(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF78350F))),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED), 
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFEDD5))
            ),
            child: Row(
              children: [
                const Icon(Icons.hourglass_top_rounded, color: Color(0xFFEA580C), size: 14),
                const SizedBox(width: 6),
                const Text('Expected Availability: ', style: TextStyle(fontSize: 12, color: Color(0xFF9A3412), fontWeight: FontWeight.w500)),
                Text(
                  'Free in ${provider.nextAvailableIn}', 
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOptionButton(String name, String badge, Color activeBorderColor) {
    bool isActive = chosenService == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => loadServiceRowData(name),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 80,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : const Color(0xFFE2E8F0).withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isActive ? activeBorderColor : Colors.transparent, width: isActive ? 2 : 1),
            boxShadow: isActive ? [BoxShadow(color: activeBorderColor.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))] : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(badge, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 6),
              Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isActive ? activeBorderColor : const Color(0xFF64748B))),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// INTERACTIVE CHATBOT AGENT WIDGET
// ==========================================
class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({Key? key}) : super(key: key);

  @override
  State<ChatBotWidget> createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
  final List<Map<String, String>> _messages = [
    {"sender": "bot", "text": "Assalam-o-Alaikum! Main Khidmat Bot hoon. 🤖 Aap ki kya madad kar sakta hoon?"}
  ];
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return;

    String userText = _chatController.text.trim();
    setState(() {
      _messages.add({"sender": "user", "text": userText});
      _chatController.clear();
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 600), () {
      String botReply = "Ji, main aap ki baat samajh gaya. Hamare premium service providers aap ke ilaqay mein behtareen kaam ke liye har waqt tayyar hain! Kya aap mazeed details janna chahte hain?";
      
      String checkLower = userText.toLowerCase();
      if (checkLower.contains('ac') || checkLower.contains('garmi')) {
        botReply = "❄️ AC Repairing ke liye Ali Mohammad is waqt Saddar mein sab se behtareen aur active provider hain.";
      } else if (checkLower.contains('leak') || checkLower.contains('plumber') || checkLower.contains('pani')) {
        botReply = "🔧 Water Leakage ya sanitary ke maslay ke liye Ghulam Mustafa sahab available hain, aap unhein direct call kar sakte hain.";
      } else if (checkLower.contains('bijli') || checkLower.contains('current') || checkLower.contains('electrician')) {
        botReply = "⚡ Electrician Zeeshan Ahmed is waqt available hain aur unka arrival time sirf 15 minutes hai.";
      } else if (checkLower.contains('hello') || checkLower.contains('hi') || checkLower.contains('aoa')) {
        botReply = "Khush Aamdeed! Mujhe batayein ke aap ko AC, Plumber, ya Electrician mein se kis ki khidmat chahiye? ✨";
      }

      setState(() {
        _messages.add({"sender": "bot", "text": botReply});
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF0F766E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Text('🤖', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Asan Khidmat Assistant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('Online • AI Support Agent', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isUser = _messages[index]["sender"] == "user";
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isUser ? const Color(0xFF0D9488) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 16),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2))
                        ],
                        border: isUser ? null : Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      child: Text(
                        _messages[index]["text"]!,
                        style: TextStyle(
                          color: isUser ? Colors.white : const Color(0xFF334155),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _chatController,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: const InputDecoration(
                          hintText: 'Type a message / Sawaal likhein...',
                          hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF0D9488),
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                      onPressed: _sendMessage,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}