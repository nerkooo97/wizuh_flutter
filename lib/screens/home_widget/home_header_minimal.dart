import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/home_widget/burger_menu.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class HomeHeaderMinimal extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final CategoryModel? category;
  final VoidCallback onSelectCategory;
  final VoidCallback onSearch;
  final VoidCallback onScan;
  final VoidCallback onAddListing;

  HomeHeaderMinimal({
    required this.maxHeight,
    required this.minHeight,
    required this.category,
    required this.onSelectCategory,
    required this.onSearch,
    required this.onScan,
    required this.onAddListing,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    double marginSearch = 16;
    if (Application.setting.enableSubmit) {
      marginSearch = 16 + shrinkOffset;
      if (marginSearch >= 64) {
        marginSearch = 64;
      }
    }

    Widget buildSubmit() {
      if (Application.setting.enableSubmit) {
        return InkWell(
          onTap: onAddListing,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      }
      return Container();
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Color.fromRGBO(16, 165, 73, 30),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Promjena
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: onSelectCategory,
                        child: Row(
                          children: [
                            Text(
                              category?.title ??
                                  Translate.of(context).translate(
                                    'select_location',
                                  ),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Boja teksta
                                  ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      // Dodavanje burger menija na desnu stranu
                      /* Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white, // Boja ikone
                            ),
                            onPressed: () {
                              // Otvara bočni meni
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ],
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: EdgeInsets.only(
              bottom: 8,
              top: 5,
              left: 16,
              right: marginSearch,
            ),
            child: AppSearchBar(
              onSearch: onSearch,
              onScan: onScan,
            ),
          ),
        )
        
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
