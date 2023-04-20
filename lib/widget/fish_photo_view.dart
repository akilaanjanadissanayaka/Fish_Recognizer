import 'dart:io';
import 'package:flutter/material.dart';

import '../styles.dart';

class PlantPhotoView extends StatelessWidget {
  final File? file;
  const PlantPhotoView({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: (file == null)
          ? _buildEmptyView()
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(file!, fit: BoxFit.contain),
            ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
        child: Image(
      image: AssetImage('assets/fish.png'),
      width: 500,
      height: 500,
    ));
  }
}
