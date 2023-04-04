import 'dart:io';

class BirdModel{
  String? birdName;
  final double latitude;
  final double longitude;
  String? birdDescription;
  final File image;

  BirdModel(this.birdName, this.latitude, this.longitude, this.birdDescription, this.image);
}