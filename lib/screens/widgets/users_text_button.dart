import 'package:flutter/material.dart';

class UsersTextButton extends StatelessWidget {
  const UsersTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActive,
  });
  final String text;
  final Function() onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
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
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}
