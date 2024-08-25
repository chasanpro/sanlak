import 'package:flutter/material.dart';
import 'package:sanlak/Components/reusableText.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const DrawerItem(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 45),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: MyText(
          title,
          color: Colors.black,
        ),
        onTap: onTap,
      ),
    );
  }
}
