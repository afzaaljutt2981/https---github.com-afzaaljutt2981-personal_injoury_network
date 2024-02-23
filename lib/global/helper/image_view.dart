import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView({super.key, required this.imageUrl});

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Image View"),
          centerTitle: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
