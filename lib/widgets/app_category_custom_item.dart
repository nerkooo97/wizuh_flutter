import 'package:flutter/material.dart';

class CategoryItemWithRoute {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  CategoryItemWithRoute({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class AppCategoryCustomItem extends StatelessWidget {
  final List<CategoryItemWithRoute> categoryItems = [
    CategoryItemWithRoute(
      title: 'Home',
      icon: Icons.home,
      color: Colors.blue,
      route: '/home',
    ),
    CategoryItemWithRoute(
      title: 'Profile',
      icon: Icons.person,
      color: Colors.green,
      route: '/profile',
    ),
    CategoryItemWithRoute(
      title: 'Settings',
      icon: Icons.settings,
      color: Colors.orange,
      route: '/settings',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          final item = categoryItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, item.route);
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: item.color,
                    radius: 30,
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}