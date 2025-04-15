import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart'; // Ensure this is imported

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BANTUAN"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A90E2),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Panduan Penggunaan Aplikasi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("1. Login dengan akun Anda."),
                  SizedBox(height: 6),
                  Text(
                    "   - Masukkan username dan password pada halaman login.",
                  ),
                  Text(
                    "   - Jika berhasil, Anda akan diarahkan ke halaman utama.",
                  ),
                  SizedBox(height: 10),
                  Text("2. Pilih menu yang tersedia di halaman utama."),
                  SizedBox(height: 6),
                  Text(
                    "   - Stopwatch: Menghitung waktu mundur atau berjalan.",
                  ),
                  Text(
                    "   - Jenis Bilangan: Menentukan tipe bilangan (positif, genap, dll).",
                  ),
                  Text(
                    "   - Tracking LBS: Menampilkan lokasi Anda secara real-time.",
                  ),
                  Text(
                    "   - Konversi Waktu: Mengubah tahun ke jam, menit, dan detik.",
                  ),
                  Text(
                    "   - Rekomendasi Situs: Daftar situs bermanfaat yang bisa disimpan.",
                  ),
                  SizedBox(height: 10),
                  Text("3. Navigasi aplikasi:"),
                  SizedBox(height: 6),
                  Text(
                    "   - Gunakan menu navigasi bawah untuk pindah antar halaman.",
                  ),
                  Text(
                    "   - Halaman Anggota menampilkan daftar tim pengembang.",
                  ),
                  SizedBox(height: 10),
                  Text("4. Keluar dari aplikasi:"),
                  SizedBox(height: 6),
                  Text(
                    "   - Klik ikon Logout di bagian bawah untuk keluar dari sesi.",
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Catatan: Pastikan koneksi internet aktif untuk fitur lokasi.",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(), // Static BottomNav
    );
  }
}
