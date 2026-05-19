import '../../domain/entity/user_entity.dart';

class LatLngModel extends LatLngEntity {
  const LatLngModel({required super.lat, required super.lng});

  factory LatLngModel.fromJson(Map<String, dynamic> json) {
    return LatLngModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}

class RouteModel extends RouteEntity {
  const RouteModel({required LatLngModel super.pointA, required LatLngModel super.pointB});

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      pointA: LatLngModel.fromJson(json['point_a'] as Map<String, dynamic>),
      pointB: LatLngModel.fromJson(json['point_b'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'point_a': (pointA as LatLngModel).toJson(),
    'point_b': (pointB as LatLngModel).toJson(),
  };
}

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.avatar,
    required super.address,
    required super.avatarColor,
    required super.route,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final colors = [
      '0xFF0066FF', // Premium Blue
      '0xFFFF3366', // Premium Rose
      '0xFF00CC99', // Premium Emerald
      '0xFF8A2BE2', // Premium Violet
      '0xFFFF9900', // Premium Amber
    ];
    final avatarColor = json['avatar_color'] as String? ?? colors[id % colors.length];

    return UserModel(
      id: id,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String,
      address: json['address'] as String,
      avatarColor: avatarColor,
      route: RouteModel.fromJson(json['route'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'avatar': avatar,
    'address': address,
    'avatar_color': avatarColor,
    'route': (route as RouteModel).toJson(),
  };
}
