import 'package:flutter/material.dart';

class BusBanner extends StatelessWidget {
  final List<Map<String, String>> banners = [
    {
      'title': 'Banner 1',
      'subtitle': 'Podnaslov',
      'url': 'https://example.com/1',
      'image': 'https://backend.wie-zuhause.app/wp-content/uploads/2025/02/banner-app2.png'
    },
    {
      'title': 'Banner 2',
      'subtitle': 'Subtitle 2',
      'url': 'https://example.com/2',
      'image': 'https://placehold.co/600x400/png'
    },
    {
      'title': 'Banner 3',
      'subtitle': 'Subtitle 3',
      'url': 'https://example.com/3',
      'image': 'https://placehold.co/600x400/png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _buildBannerSlider(banners.map((banner) => banner['image']!).toList());
  }

  Widget _buildBannerSlider(List<String>? banner) {
    if (banner == null || banner.isEmpty) {
      return Container(
        height: 200,
        color: Colors.grey[200],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(16), // Add rounded corners
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
        final banner = banners[index];
        return Stack(
          children: [
          Image.network(
            banner['image']!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                : null,
              ),
            );
            },
            errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: const Icon(
              Icons.error,
              color: Colors.red,
              ),
            );
            },
          ),
          Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, const Color.fromARGB(111, 0, 0, 0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              banner['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 8),
              Text(
              banner['subtitle']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
              onPressed: () {
                final url = banner['url'];
                if (url != null) {
                // Open the URL
                // You can use url_launcher package to launch the URL
                }
              },
              child: const Text('Pogledajte'),
              ),
            ],
            ),
          ),
          ],
        );
        },
      ),
      ),
    );
  }
}
