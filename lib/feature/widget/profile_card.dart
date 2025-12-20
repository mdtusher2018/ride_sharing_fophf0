import 'package:flutter/material.dart';

Widget profileCard({required String image, required Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
