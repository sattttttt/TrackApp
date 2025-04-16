import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart'; // Ensure this is imported

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        backgroundColor: const Color(0xFF8E44AD),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E44AD), Color(0xFF2980B9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white.withOpacity(0.95),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                // Make this part scrollable
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Panduan Penggunaan Aplikasi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "1. Login dengan akun Anda.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "   - Masukkan username dan password pada halaman login.",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "   - Jika berhasil, Anda akan diarahkan ke halaman utama.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "2. Pilih menu yang tersedia di halaman utama.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "   - Stopwatch: Menghitung waktu mundur atau berjalan.",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "   - Jenis Bilangan: Menentukan tipe bilangan (positif, genap, dll).",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "   - Tracking LBS: Menampilkan lokasi Anda secara real-time.",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "   - Konversi Waktu: Mengubah tahun ke jam, menit, dan detik.",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "   - Rekomendasi Situs: Daftar situs bermanfaat yang bisa disimpan.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "3. Navigasi aplikasi:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "   - Gunakan menu navigasi bawah untuk pindah antar halaman.",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "   - Halaman Anggota menampilkan daftar tim pengembang.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "4. Keluar dari aplikasi:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "   - Klik ikon Logout di bagian bawah untuk keluar dari sesi.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Catatan: Pastikan koneksi internet aktif untuk fitur lokasi.",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(), // Static BottomNav
    );
  }
}
