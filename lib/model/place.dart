import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final double latitude;
  final double longitude;
  final String? address;
}
