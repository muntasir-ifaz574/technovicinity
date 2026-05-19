class LatLngEntity {
  final double lat;
  final double lng;

  const LatLngEntity({
    required this.lat,
    required this.lng,
  });
}

class RouteEntity {
  final LatLngEntity pointA;
  final LatLngEntity pointB;

  const RouteEntity({
    required this.pointA,
    required this.pointB,
  });
}

class UserEntity {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String address;
  final String avatarColor;
  final RouteEntity route;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.address,
    required this.avatarColor,
    required this.route,
  });

  // Convenient type-safe computed getters for routing coordinates and names
  double get latA => route.pointA.lat;
  double get lngA => route.pointA.lng;
  double get latB => route.pointB.lat;
  double get lngB => route.pointB.lng;
  
  String get routeNameA => '${address.split(',').first.trim()} Center';
  String get routeNameB => '${address.split(',').first.trim()} Dispatch Hub';
}
