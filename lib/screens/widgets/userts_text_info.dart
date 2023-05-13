import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_users_generator/cubit/users_cubit.dart';

class UsersTextInfo extends StatelessWidget {
  const UsersTextInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersStates>(
      builder: (context, state) {
        final users = state.model.results?[0];
        return Column(
          children: [
            Text(
              '${users?.name?.title}. ${users?.name?.first} ${users?.name?.last}'
                  .toUpperCase(),
              style: TextStyle(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '${users?.email}',
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '${users?.phone}',
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'City: ${users?.location?.city}',
            ),
          ],
        );
      },
    );
  }
}
