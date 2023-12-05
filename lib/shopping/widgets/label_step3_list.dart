import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/widgets/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LabelStep3List extends StatelessWidget {
  const LabelStep3List({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextLabel(
          label: AppLocalizations.of(context)!.shoppingStep3Label1List,
          isDarkMode: isDarkMode,
        ),
        InkWell(
          onTap: () {
            debugPrint("Xóa tất cả sản phẩm");
            if (context.read<AddItemCubit>().state.isNotEmpty) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  contentPadding: EdgeInsets.all(20),
                  content: const Text(
                    'Bạn có chắc chắn xóa tất cả sản phẩm?',
                    style: TextStyle(
                      fontFamily: fontApp,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.pop(context),
                        context.read<AddItemCubit>().removeAllItem(),
                        context
                            .read<SaveDataShopping>()
                            .setItems(context.read<AddItemCubit>().state),
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          child: Text(
            AppLocalizations.of(context)!.shoppingStep3Label1Remove,
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger,
              color: colorProject.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
