import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_users_generator/cubit/users_cubit.dart';

class RefreshButton extends StatefulWidget {
  const RefreshButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  final Function() onPressed;
  final bool isLoading;

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didUpdateWidget(covariant RefreshButton oldWidget) {
    if (widget.isLoading) {
      animationController.repeat();
    } else {
      animationController.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersStates>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                color: Colors.grey.shade600,
                blurRadius: 15,
                spreadRadius: 1,
              ),
              const BoxShadow(
                offset: Offset(-5, -5),
                color: Colors.white,
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            splashRadius: 0.1,
            iconSize: 40,
            onPressed: widget.onPressed,
            icon: RotationTransition(
              turns: animationController,
              child: const Icon(Icons.refresh),
            ),
          ),
        );
      },
    );
  }
}
