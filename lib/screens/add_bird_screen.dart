import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';

class AddBirdScreen extends StatefulWidget {
  final LatLng latLng;
  final File image;

  AddBirdScreen({required this.latLng, required this.image});

  @override
  State<AddBirdScreen> createState() => _AddBirdScreenState();
}

class _AddBirdScreenState extends State<AddBirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "add bird screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(widget.image),
                  fit: BoxFit.cover,
                )),
          ),
          TextField(),
          TextField(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.check,
          size: 30,
        ),
      ),
    );
  }
}