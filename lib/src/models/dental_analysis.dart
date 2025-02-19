import 'package:flutter/material.dart';

/// Represents a single tooth and its analysis data.
class Tooth {
  final String toothClass;
  final String groupClass;
  final String jaw;
  final String quadrant;
  final String professionalName;
  final List<double> bbox;      // [x, y, width, height]
  final List<double> groupBbox; // [x, y, width, height] for a group of teeth
  final double confidence;
  final int imageIndex;
  final String imageName;

  Tooth({
    required this.toothClass,
    required this.groupClass,
    required this.jaw,
    required this.quadrant,
    required this.professionalName,
    required this.bbox,
    required this.groupBbox,
    required this.confidence,
    required this.imageIndex,
    required this.imageName,
  });

  factory Tooth.fromJson(Map<String, dynamic> json) {
    return Tooth(
      toothClass: json["tooth_class"],
      groupClass: json["group_class"],
      jaw: json["jaw"],
      quadrant: json["quadrant"].toString(),
      professionalName: json["professional_name"],
      bbox: List<double>.from(json["bbox"].map((x) => (x as num).toDouble())),
      groupBbox: List<double>.from(json["group_bbox"].map((x) => (x as num).toDouble())),
      confidence: (json["confidence"] as num).toDouble(),
      imageIndex: json["image_index"],
      imageName: json["image_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tooth_class": toothClass,
      "group_class": groupClass,
      "jaw": jaw,
      "quadrant": quadrant,
      "professional_name": professionalName,
      "bbox": bbox,
      "group_bbox": groupBbox,
      "confidence": confidence,
      "image_index": imageIndex,
      "image_name": imageName,
    };
  }
}

/// Represents the entire dental analysis for a set of images.
class DentalAnalysis {
  final List<Tooth> teeth;
  /// Computed markers (relative offsets) for display on a dental map.
  final List<Offset> markers;

  DentalAnalysis({required this.teeth, required this.markers});

  factory DentalAnalysis.fromJson(Map<String, dynamic> json) {
    List<Tooth> teethList = (json["teeth"] as List)
        .map((toothJson) => Tooth.fromJson(toothJson))
        .toList();

    // Compute center points for each tooth based on its bounding box.
    List<Offset> computedMarkers = teethList.map((tooth) {
      double x = tooth.bbox[0];
      double y = tooth.bbox[1];
      double width = tooth.bbox[2];
      double height = tooth.bbox[3];
      return Offset(x + width / 2, y + height / 2);
    }).toList();

    return DentalAnalysis(teeth: teethList, markers: computedMarkers);
  }

  Map<String, dynamic> toJson() {
    return {
      "teeth": teeth.map((tooth) => tooth.toJson()).toList(),
      // Markers are typically used for UI display; include them if needed.
      "markers": markers.map((offset) => {"dx": offset.dx, "dy": offset.dy}).toList(),
    };
  }
}
