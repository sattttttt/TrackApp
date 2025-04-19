import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final List<Map<String, String>> recommendations = [
    {
      "title": "Google",
      "url": "https://www.google.com",
      "image":
          "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
    },
    {
      "title": "Google Maps",
      "url": "https://maps.google.com",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Google_Maps_icon_%282020%29.svg/1200px-Google_Maps_icon_%282020%29.svg.png",
    },
    {
      "title": "Wikipedia",
      "url": "https://www.wikipedia.org",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Wikipedia-logo-v2.svg/1200px-Wikipedia-logo-v2.svg.png",
    },
    {
      "title": "Detik.com",
      "url": "https://www.detik.com",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Detikcom_Logo_2019.svg/1200px-Detikcom_Logo_2019.svg.png",
    },
    {
      "title": "Kompas.com",
      "url": "https://www.kompas.com",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Kompas.com_Logo_2019.svg/2560px-Kompas.com_Logo_2019.svg.png",
    },
    {
      "title": "YouTube",
      "url": "https://www.youtube.com",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/1024px-YouTube_full-color_icon_%282017%29.svg.png",
    },
  ];

  Set<String> _favorites = Set<String>();

  Future<void> _launchURL(String url) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Tidak bisa membuka $url")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _toggleFavorite(String url) {
    setState(() {
      if (_favorites.contains(url)) {
        _favorites.remove(url);
      } else {
        _favorites.add(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Sites"),
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
            final isFavorite = _favorites.contains(site["url"]);

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
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 50),
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(site["url"]!),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.open_in_new, color: Colors.blueGrey),
                  ],
                ),
                onTap: () => _launchURL(site["url"]!),
              ),
            );
          },
        ),
      ),
    );
  }
}
