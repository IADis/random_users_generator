import 'package:flutter/material.dart';

class UsersIconsButton extends StatelessWidget {
  const UsersIconsButton({
    super.key,
    required this.icon,
    required this.onPress,
  });

  final Icon icon;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
        splashColor: null,
        iconSize: 40,
        icon: icon,
        onPressed: onPress,
      ),
    );
  }
}
