import 'package:flutter/material.dart';

class ManageCard extends StatelessWidget {
  final Widget page;
  final Widget child;
  final Icon icon;
  const ManageCard({
    super.key,
    required this.child,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: icon,
          ),
          const SizedBox(width: 10),
          child,
        ],
      ),
    );
  }
}
