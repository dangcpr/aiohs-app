import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../cubit/save_info_cooking.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SaveInfoCookingCubit>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên món 1'),
            sizedBox.mediumHeight(),
            name1(),
            sizedBox.mediumHeight(),
            Text('Tên món 2'),
            sizedBox.mediumHeight(),
            name2(),
            sizedBox.mediumHeight(),
            Text('Tên món 3'),
            sizedBox.mediumHeight(),
            name3(),
            sizedBox.mediumHeight(),
            Text('Tên món 4'),
            sizedBox.mediumHeight(),
            name4(),
          ],
        ),
      ),
    );
  }

  Widget name1() {
    return TextFormField(
      style: const TextStyle(fontFamily: fontApp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(padding.paddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: colorProject.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        setState(() {
          context.read<SaveInfoCookingCubit>().state.food1 = value;
          print(context.read<SaveInfoCookingCubit>().state.food1);
        });
      },
    );
  }

  Widget name2() {
    return TextFormField(
      style: const TextStyle(fontFamily: fontApp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(padding.paddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: colorProject.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        setState(() {
          context.read<SaveInfoCookingCubit>().state.food2 = value;
        });
      },
    );
  }

  Widget name3() {
    return TextFormField(
      style: const TextStyle(fontFamily: fontApp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(padding.paddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: colorProject.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        setState(() {
          context.read<SaveInfoCookingCubit>().state.food3 = value;
        });
      },
    );
  }

  Widget name4() {
    return TextFormField(
      style: const TextStyle(fontFamily: fontApp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(padding.paddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: colorProject.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        setState(() {
          context.read<SaveInfoCookingCubit>().state.food4 = value;
        });
      },
    );
  }
}
