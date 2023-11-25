import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../cubit/save_info_cooking.dart';

class ServiceBonus extends StatefulWidget {
  const ServiceBonus({super.key});

  @override
  State<ServiceBonus> createState() => _ServiceBonusState();
}

class _ServiceBonusState extends State<ServiceBonus> {
  var bonusService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bonusService = context.read<SaveInfoCookingCubit>().state.bonusService;
    bonusService == 0 ? select = true : select = false;
  }

  late bool select;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: firstChild(),
      secondChild: secondChild(),
      crossFadeState:
          select ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 350),
    );
  }

  Widget firstChild() {
    return InkWell(
      onTap: () {
        setState(() {
          select = !select;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(padding.paddingSmall),
          child: Row(
            children: [
              Icon(
                Icons.local_grocery_store,
                color: colorProject.primaryColor,
                size: 40,
              ),
              sizedBox.largeWidth(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Người làm đi chợ'),
                  Text('+ 0.5 giờ'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget secondChild() {
    return InkWell(
      onTap: () {
        setState(() {
          select = !select;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(padding.paddingMedium),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_grocery_store,
                        color: colorProject.primaryColor,
                        size: 40,
                      ),
                      sizedBox.largeWidth(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Người làm đi chợ'),
                          Text('+ 0.5 giờ'),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.check, color: Colors.orange),
                ],
              ),
              sizedBox.mediumHeight(),
              Text(
                'CHI PHÍ TỐI ĐA CHO VIỆC ĐI CHỢ',
                style: textStyle.normalStyle(fontSize: 16),
              ),
              sizedBox.mediumHeight(),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: padding.paddingMedium, vertical: 0.0),
                    child: Row(
                      children: [
                        Text(
                          'VND',
                          style: textStyle.normalStyle(),
                        ),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: colorProject.primaryColor,
                            style: const TextStyle(fontFamily: fontApp),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            initialValue: context
                                .read<SaveInfoCookingCubit>()
                                .state
                                .bonusService
                                .toString(),
                            onChanged: (value) {
                              int valueTemp = int.parse(value);
                              setState(() {
                                context
                                    .read<SaveInfoCookingCubit>()
                                    .state
                                    .bonusService = valueTemp;
                                print(context
                                    .read<SaveInfoCookingCubit>()
                                    .state
                                    .bonusService);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox.mediumHeight(),
              Text(
                'Cộng tác viên sẽ đến nhà bạn nhận tiền và đi chợ theo yêu cầu',
                style: textStyle.normalStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
