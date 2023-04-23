import 'dart:io';
import 'package:flutter/material.dart';

import '../styles.dart';

class PlantPhotoView extends StatelessWidget {
  final File? file;
  const PlantPhotoView({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Center(
        child: Container(
          width: 350,
          height: 135,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 350,
                  height: 135,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: (file == null)
                      ? _buildEmptyView()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(file!, fit: BoxFit.contain),
                        ),
                ),
              ),
            ),
          ),
        ),
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
