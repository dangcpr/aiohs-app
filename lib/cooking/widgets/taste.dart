import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../cubit/save_info_cooking.dart';

class Taste extends StatefulWidget {
  const Taste({super.key});

  @override
  State<Taste> createState() => _TasteState();
}

class _TasteState extends State<Taste> {
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isSelect1 = !isSelect1;
              isSelect2 = false;
              isSelect3 = false;
              context.read<SaveInfoCookingCubit>().state.taste = 'Bắc';
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: isSelect1
                  ? Border.all(color: Colors.orange)
                  : Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding.paddingMedium),
              child: Text(
                'Bắc',
                style: textStyle.normalStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        sizedBox.mediumHeight(),
        InkWell(
          onTap: () {
            setState(() {
              isSelect1 = false;
              isSelect2 = !isSelect2;
              isSelect3 = false;
              context.read<SaveInfoCookingCubit>().state.taste = 'Trung';
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: isSelect2
                  ? Border.all(color: Colors.orange)
                  : Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding.paddingMedium),
              child: Text(
                'Trung',
                style: textStyle.normalStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        sizedBox.mediumHeight(),
        InkWell(
          onTap: () {
            setState(() {
              isSelect1 = false;
              isSelect2 = false;
              isSelect3 = !isSelect3;
              context.read<SaveInfoCookingCubit>().state.taste = 'Nam';
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: isSelect3
                  ? Border.all(color: Colors.orange)
                  : Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding.paddingMedium),
              child: Text(
                'Nam',
                style: textStyle.normalStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
