import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class HomeHeaderBasic extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<String>? banners;
  final VoidCallback onSearch;
  final VoidCallback onScan;

  HomeHeaderBasic({
    required this.expandedHeight,
    required this.onSearch,
    required this.onScan,
    this.banners,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green, // Changed background color to green
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/web-logo.png', // Replace with your logo asset path
                  height: 50,
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    // Add your menu action here
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 1),
            child: AppSearchBar(
              onSearch: onSearch,
              onScan: onScan,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 115;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
