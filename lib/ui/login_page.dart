import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keuanganpribadi/ui/landing_page.dart';
import 'package:keuanganpribadi/ui/registrasi_page.dart';
import '../bloc/login_bloc.dart';
import '../helpers/user_info.dart';
import '../widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk membuat layar fullscreen pada saat inisialisasi widget
    _makeFullScreen();
  }

  @override
  void dispose() {
    // Kembalikan status bar ke mode normal saat widget dihapus
    _exitFullScreen();
    super.dispose();
  }

  // Fungsi untuk membuat layar fullscreen
  void _makeFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []); // Sembunyikan notifikasi bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Atur warna status bar menjadi transparan
    ));
  }

  // Fungsi untuk kembali ke status bar normal
  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // Tampilkan notifikasi bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Atur warna status bar menjadi transparan
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Disable back navigation by returning false
          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Image.asset(
                'assets/bg_login.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Welcome Text aligned to the left
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20.0),
                            child: Text(
                              'Selamat Datang!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Subtitle Text below "Selamat Datang!"
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Silakan login untuk melanjutkan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Email and Password Fields
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _emailTextField(),
                              const SizedBox(height: 16.0),
                              _passwordTextField(),
                              _buttonLogin(),
                              const SizedBox(
                                height: 30,
                              ),
                              _menuRegistrasi(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Logo Image positioned half outside the top border
              Positioned(
                top: 150.0,
                left: 0,
                right: 0,
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icon.png',
                      width: 95.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _emailTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        // Text color
        decoration: const InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        // Text color
        decoration: const InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: _passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password harus diisi";
          }
          return null;
        },
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? Colors.grey
                  : Colors.blue;
            },
          ),
          elevation: MaterialStateProperty.all(5.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate && !_isLoading) {
            _submit();
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) async {
      await UserInfo().setToken(value.token.toString());
      await UserInfo().setUserID(int.parse(value.userID.toString()));

      // Tampilkan notifikasi login berhasil
      _showSuccessDialog();
    }, onError: (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
      setState(() {
        _isLoading = false;
      });
    });
  }

// Fungsi untuk menampilkan dialog notifikasi login berhasil
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Login Berhasil"),
        content: const Text("Selamat datang di aplikasi keuangan pribadi!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _navigateToLandingPage(); // Navigate to LandingPage
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _navigateToLandingPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LandingPage(),
      ),
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Belum Punya Akun? Registrasi",
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
