import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_the_bird/block/location_cubit.dart';

import 'add_bird_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MapScreen extends StatelessWidget {
  Future<void> _pickImageAndPost({required LatLng latLng, required context}) async {
    File? image;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddBirdScreen(latLng: latLng, image: image!)));
    } else {
      print("didn't pick");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
      if (state is LocationLoaded) {
        return FlutterMap(
          options: MapOptions(
            onLongPress: (tapPosition, latLng) {
              _pickImageAndPost(latLng: latLng, context: context);
            },
            center: LatLng(state.latitude, state.longitude),
            zoom: 15.3,
            maxZoom: 17,
            minZoom: 3.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              retinaMode: true,
            ),
          ],
        );
      }

      if (state is LocationError) {
        Center(
            child: MaterialButton(
          child: const Text('try again'),
          onPressed: () {
            context.read<LocationCubit>().getLocation();
          },
        ));
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}
