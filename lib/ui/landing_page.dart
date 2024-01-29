import 'package:flutter/material.dart';
import 'package:keuanganpribadi/ui/transaksi_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Disable back navigation by returning false
          return Future.value(false);
        },
        child: Scaffold(
          body: Stack(
            children: [
              // Background Image
              Image.asset(
                'assets/bg_landing.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              // Content
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(16.0),
                  // Hilangkan dekorasi yang memberikan efek transparan
                  // ...
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Ratakan teks ke kiri
                      children: [
                        // Penjelasan Aplikasi
                        const Text(
                          'Selamat Datang di KasKu!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Aplikasi ini membantu Anda mengelola keuangan pribadi dengan mudah. Mulailah mencatat transaksi keuangan Anda sekarang!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign:
                              TextAlign.left, // Atur alignment teks ke kiri
                        ),
                        const SizedBox(height: 16.0),
                        // Tombol Get Started
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TransaksiPage()),
                            );
                          },
                          child: const Text('Get Started'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
