import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/home/home_category_item.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _homeCubit = HomeCubit();
  StreamSubscription? _submitSubscription;
  StreamSubscription? _reviewSubscription;

  @override
  void initState() {
    super.initState();
    _homeCubit.onLoad(reload: true);
    _reviewSubscription = AppBloc.reviewCubit.stream.listen((state) {
      if (state is ReviewSuccess && state.id != null) {
        _homeCubit.onLoad();
      }
    });
  }

  @override
  void dispose() {
    _homeCubit.close();
    _submitSubscription?.cancel();
    _reviewSubscription?.cancel();
    super.dispose();
  }

  ///Refresh
  Future<void> _onRefresh() async {
    await _homeCubit.onLoad();
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///On scan
  void _onScan() async {
    final result = await Navigator.pushNamed(context, Routes.scanQR);
    if (result != null) {
      final deeplink = DeepLinkModel.fromString(result as String);
      if (deeplink.target.isNotEmpty) {
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          Routes.deepLink,
          arguments: deeplink,
        );
      }
    }
  }

  ///On select category
  void _onCategory(CategoryModel? item) {
    if (item == null) {
      Navigator.pushNamed(context, Routes.category);
      return;
    }
    if (item.hasChild) {
      Navigator.pushNamed(context, Routes.category, arguments: item);
    } else {
      Navigator.pushNamed(context, Routes.listProduct, arguments: item);
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On handle submit listing
  void _onSubmit() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.submit,
      );
      if (result == null) return;
    }
    if (!mounted) return;
    Navigator.pushNamed(context, Routes.submit);
  }

  ///Build category UI
  Widget _buildCategory(List<CategoryModel>? category) {
    ///Loading
    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: HomeCategoryItem(),
        );
      },
      itemCount: 8,
    );

    if (category != null) {
      final more = CategoryModel.fromJson({
        "term_id": -1,
        "name": Translate.of(context).translate("more"),
        "icon": "fas fa-ellipsis",
        "color": "#ff8a65",
      });

      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          if (index < category.length) {
            final item = category[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: HomeCategoryItem(
                item: item,
                onPressed: _onCategory,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: HomeCategoryItem(
                item: more,
                onPressed: (item) {
                  _onCategory(null);
                },
              ),
            );
          }
        },
        itemCount: category.length + 1,
      );
    }

    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      child: content,
    );
  }
  ///Build hardcoded items UI
  Widget _buildHardcodedItems() {
    final items = [
      {
        "title": "Dešavanja",
        "color": Colors.red,
        "icon": 'fas fa-calendar-check',
        "route": Routes.eventPage,
      },
      {
        "title": "Autobuske linije",
        "color": Colors.green,
        "icon": 'fas fa-van-shuttle',
        "route": Routes.busLines,
      },
      {
        "title": "Kupi auto",
        "color": Colors.blue,
        "icon": 'fas fa-car',
        "route": Routes.blogList,
      },
      {
        "title": "Projekt Njemačka",
        "color": const Color.fromARGB(255, 227, 227, 227),
        "icon": 'fas fa-pen-fancy',
        "image": 'https://projektnjemacka.com/wp-content/uploads/2020/06/by_Dragojuki%C4%87__2_-removebg-preview-1.png',
        "route": Routes.topicsPage,
      },
    ];

    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: HomeCategoryItem(),
        );
      },
      itemCount: 8,
    );

    content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, item['route'] as String);
            },
            child: HomeCategoryItem(
              item: CategoryModel.fromJson({
                "term_id": index,
                "name": item['title'],
                "icon": item['icon'],
                'category_image': item['image'],
                "color": (item['color'] as Color).value.toRadixString(16),
              }),
              onPressed: (category) {
                Navigator.pushNamed(context, item['route'] as String);
              },
            ),
          ),
        );
      },
      itemCount: items.length,
    );

    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      child: content,
    );
  }

  ///Build popular UI
  Widget _buildLocation(List<CategoryModel>? location) {
    ///Loading
    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AppCategoryItem(
            type: CategoryViewType.card,
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );

    if (location != null) {
      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          final item = location[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppCategoryItem(
              item: item,
              type: CategoryViewType.card,
              onPressed: () {
                _onCategory(item);
              },
            ),
          );
        },
        itemCount: location.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate(
                  'popular_location',
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate(
                  'let_find_interesting',
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.only(top: 4),
          child: content,
        ),
      ],
    );
  }

  ///Build list recent
  Widget _buildRecent(List<ProductModel>? recent) {
    ///Loading
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: AppProductItem(type: ProductViewType.grid),
        );
      },
      itemCount: 8,
    );

    if (recent != null) {
      content = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = recent[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppProductItem(
              onPressed: () {
                _onProductDetail(item);
              },
              item: item,
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: recent.length,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Translate.of(context).translate('recent_location'),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate(
                  'what_happen',
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  ///Build submit button
  Widget? _buildSubmit() {
    if (Application.setting.enableSubmit) {
      return FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _onSubmit,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarMain(),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: _homeCubit,
        builder: (context, state) {
          List<String>? banner;
          List<CategoryModel>? category;
          List<CategoryModel>? location;
          List<ProductModel>? recent;

          if (state is HomeSuccess) {
            banner = state.banner;
            category = state.category;
            location = state.location;
            recent = state.recent;
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: Column(
                    children: [
                      SafeArea(
                        top: false,
                        bottom: true,
                        child: Column(
                          children: <Widget>[
                            _buildSearchBar(),
                            _buildBannerSlider(banner),
                            _buildCategory(category),
                            _buildHardcodedItems(),
                            _buildLocation(location),
                            const SizedBox(height: 8),
                            _buildRecent(recent),
                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _buildSubmit(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  PreferredSizeWidget _appBarMain() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.green, // Changed background color to green
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 60, bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/web-logo.png', // Replace with your logo asset path
                    height: 50,
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // Add your menu action here
                    },
                  ),
                ],
              ),
            ),
/*             Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 1),
              child: AppSearchBar(
                onSearch: _onSearch,
                onScan: _onScan,
              ),
            ), */
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.green, // Set background color to green
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set inner container color to white
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), // Rounded bottom left corner
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20) // Rounded bottom right corner
          ),
        ),
        child: AppSearchBar(
          onSearch: _onSearch,
          onScan: _onScan,
        ),
      ),
    );
  }

  ///Build banner slider
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
      height: 225,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), // Add rounded corners
        child: PageView.builder(
          itemCount: banner.length,
          itemBuilder: (context, index) {
            return Image.network(
              banner[index],
              fit: BoxFit.cover,
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
            );
          },
        ),
      ),
    );
  }


}