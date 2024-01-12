import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/app_assets.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class InfoAccount extends StatefulWidget {
  const InfoAccount({super.key});

  @override
  State<InfoAccount> createState() => _InfoAccountState();
}

class _InfoAccountState extends State<InfoAccount> {
  @override
  Widget build(BuildContext context) {
    var userCubit = context.watch<UserCubit>();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 85,
              width: 85,
              child: userCubit.state.avatar_url!.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage('${userCubit.state.avatar_url}'),
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.profile),
                    )),
          SizedBox(height: 8),
          Text(
            userCubit.state.full_name ?? userCubit.state.email!,
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.large,
              color: colorProject.primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('${userCubit.state.email!}',
              style: TextStyle(
                fontFamily: fontApp,
                fontSize: fontSize.medium,
                color: colorProject.subColor,
              ))
        ],
      ),
    );
  }
}
