import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_users_generator/cubit/users_cubit.dart';

class UsersAvatar extends StatelessWidget {
  const UsersAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersStates>(
      builder: (context, state) {
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                state.model.results?[0].picture?.large ?? '',
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                offset: const Offset(7, 7),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-7, -7),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
