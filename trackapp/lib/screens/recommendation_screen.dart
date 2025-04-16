import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationScreen extends StatelessWidget {
  final List<Map<String, String>> recommendations = [
    {
      "title": "Flutter Official Docs",
      "url": "https://docs.flutter.dev",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
    },
    {
      "title": "GitHub - Flutter Repository",
      "url": "https://github.com/flutter/flutter",
      "image":
          "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
    },
  ];

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendation Sites"),
        backgroundColor: const Color(0xFF8E44AD),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E44AD), Color(0xFF2980B9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final site = recommendations[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white.withOpacity(0.95),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    site["image"]!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  site["title"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  site["url"]!,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                trailing: const Icon(Icons.open_in_new, color: Colors.blueGrey),
                onTap: () => _launchURL(site["url"]!),
              ),
            );
          },
        ),
      ),
    );
  }
}
