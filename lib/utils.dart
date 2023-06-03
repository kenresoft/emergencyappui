import 'package:extensionresoft/helper.dart';
import 'package:flutter/material.dart';

bool layout(BuildContext context, BoxConstraints constraints) {
  var size = constraints.maxWidth;
  var orientation = MediaQuery.of(context).orientation.name;
  var width = condition(
    orientation == "portrait",
    MediaQuery.of(context).size.width,
    MediaQuery.of(context).size.flipped.width,
  );
  return size > width;
}

var iconList = [
  Icons.medical_services_rounded,
  Icons.medical_information,
  Icons.local_hospital_rounded,
  Icons.health_and_safety_rounded,
  Icons.bedroom_parent_rounded,
  Icons.medication_liquid_rounded,
];
