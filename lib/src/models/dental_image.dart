import 'package:flutter/foundation.dart';

enum DentalImageType {
  front,
  upper,
  lower,
  other
}

extension DentalImageTypeExtension on DentalImageType {
  String get value {
    switch (this) {
      case DentalImageType.front:
        return 'front';
      case DentalImageType.upper:
        return 'upper';
      case DentalImageType.lower:
        return 'lower';
      case DentalImageType.other:
        return 'other';
    }
  }
  
  static DentalImageType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'front':
        return DentalImageType.front;
      case 'upper':
        return DentalImageType.upper;
      case 'lower':
        return DentalImageType.lower;
      default:
        return DentalImageType.other;
    }
  }
}

@immutable
class DentalImage {
  final String id;
  final String url;
  final DentalImageType type;
  final DateTime captureDate;
  final String memberId;
  final Map<String, dynamic>? metadata;
  final String? localPath;
  final bool isProcessed;
  final String? analysisId;

  const DentalImage({
    required this.id,
    required this.url,
    required this.type,
    required this.captureDate,
    required this.memberId,
    this.metadata,
    this.localPath,
    this.isProcessed = false,
    this.analysisId,
  });

  DentalImage copyWith({
    String? id,
    String? url,
    DentalImageType? type,
    DateTime? captureDate,
    String? memberId,
    Map<String, dynamic>? metadata,
    String? localPath,
    bool? isProcessed,
    String? analysisId,
  }) {
    return DentalImage(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      captureDate: captureDate ?? this.captureDate,
      memberId: memberId ?? this.memberId,
      metadata: metadata ?? this.metadata,
      localPath: localPath ?? this.localPath,
      isProcessed: isProcessed ?? this.isProcessed,
      analysisId: analysisId ?? this.analysisId,
    );
  }

  factory DentalImage.fromJson(Map<String, dynamic> json) {
    return DentalImage(
      id: json['id'] as String,
      url: json['url'] as String,
      type: DentalImageTypeExtension.fromString(json['type'] as String),
      captureDate: DateTime.parse(json['captureDate'] as String),
      memberId: json['memberId'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      localPath: json['localPath'] as String?,
      isProcessed: json['isProcessed'] as bool? ?? false,
      analysisId: json['analysisId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'type': type.value,
      'captureDate': captureDate.toIso8601String(),
      'memberId': memberId,
      'metadata': metadata,
      'localPath': localPath,
      'isProcessed': isProcessed,
      'analysisId': analysisId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DentalImage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          url == other.url &&
          type == other.type &&
          captureDate == other.captureDate &&
          memberId == other.memberId &&
          isProcessed == other.isProcessed &&
          analysisId == other.analysisId;

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode ^
      type.hashCode ^
      captureDate.hashCode ^
      memberId.hashCode ^
      isProcessed.hashCode ^
      analysisId.hashCode;

  @override
  String toString() {
    return 'DentalImage(id: $id, type: ${type.value}, memberId: $memberId, isProcessed: $isProcessed)';
  }
}