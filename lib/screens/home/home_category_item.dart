import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/widgets/app_placeholder.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryModel? item;
  final Function(CategoryModel)? onPressed;

  const HomeCategoryItem({
    Key? key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 48,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.21,
      child: GestureDetector(
      onTap: () => onPressed!(item!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: item!.color,
          ),
          child: item!.categoryImage != null
            ? Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              ),
              child: ClipOval(
              child: OverflowBox(
                maxWidth: 75,
                maxHeight: 75,
                child: Image.network(
                item!.categoryImage!,
                fit: BoxFit.cover,
                ),
              ),
              ),
            )
            : FaIcon(
              item!.icon,
              size: 28,
              color: Colors.white,
            ),
        ),
        const SizedBox(height: 4),
        Text(
          item!.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        ],
      ),
      ),
    );
  }
}
