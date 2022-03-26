import 'dart:html';

import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Image.network(
        'https://i1.pickpik.com/photos/528/587/667/bloom-blossom-blur-close-up-preview.jpg',
      ),
    );
  }
}
