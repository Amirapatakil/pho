import 'package:flutter/material.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_textstyle.dart';

class ElevatedButtom extends StatelessWidget {
  const ElevatedButtom({super.key, required this.text, required this.iconPath});
  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: PHOColor.blue4674FF,
          foregroundColor: PHOColor.white,
        ),
        onPressed: () {},
        child: SizedBox(
          height: 80,
          width: 343,
          child: Row(
            children: [
              Image(image: AssetImage(iconPath)),
              const SizedBox(
                width: 16,
              ),
              Text(text, style: PHOTextstyle.s20w510),
            ],
          ),
        ));
  }
}
