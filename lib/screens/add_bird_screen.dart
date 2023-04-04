import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';

import 'package:spot_the_bird/models/post_model.dart';

class AddBirdScreen extends StatefulWidget {
  final LatLng latLng;
  final File image;

  AddBirdScreen({required this.latLng, required this.image});

  @override
  State<AddBirdScreen> createState() => _AddBirdScreenState();
}

class _AddBirdScreenState extends State<AddBirdScreen> {
  String? name;
  String? description;
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    _descriptionFocusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void submit(BirdModel birdModel, BuildContext context){
    if(!_formKey.currentState!.validate()){
      return;
    }

    _formKey.currentState!.save();
    //save to cubit
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "add bird screen",
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(widget.image),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "enter a description"),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  name = value!.trim();
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "pleas enter a value";
                  }
                  if (value!.length < 2) {
                    return "enter longer name";
                  }
                  return null;
                },
              ),
              TextFormField(
                focusNode: _descriptionFocusNode,
                decoration: InputDecoration(hintText: "enter a description"),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_){
                  final BirdModel birdModel = BirdModel(name, widget.latLng.latitude,
                      widget.latLng.longitude, description, widget.image);
                  submit(birdModel, context);
                },
                onSaved: (value) {
                  description = value!.trim();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "pleas enter a description";
                  }
                  if (value!.length < 2) {
                    return "enter longer description";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

              final BirdModel birdModel = BirdModel(name, widget.latLng.latitude,
                  widget.latLng.longitude, description, widget.image);
              submit(birdModel, context);
        },
        child: const Icon(
          Icons.check,
          size: 30,
        ),
      ),
    );
  }
}
