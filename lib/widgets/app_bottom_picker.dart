import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class AppBottomPicker extends StatelessWidget {
  final PickerModel picker;

  const AppBottomPicker({
    Key? key,
    required this.picker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Column(
                  children: picker.data.map((item) {
                    Widget trailing = Container();
                    String title = '';
                    if (item is String) {
                      title = item;
                    } else {
                      title = item.title;
                    }
                    if (picker.selected.contains(item)) {
                      trailing = Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: AppListTitle(
                        title: Translate.of(context).translate(title),
                        trailing: trailing,
                        onPressed: () {
                          Navigator.pop(context, item);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
