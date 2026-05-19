import 'package:flutter_test/flutter_test.dart';
import 'package:technovicinity/app/feature/home/domain/entity/user_entity.dart';

void main() {
  group('UserEntity Domain Tests', () {
    test('should compute correct coordinate getters from RouteEntity', () {
      const user = UserEntity(
        id: 1,
        name: 'Muntasir',
        email: 'muntasir@example.com',
        phone: '12345678',
        avatar: 'avatar.png',
        address: 'Dhaka, Bangladesh',
        avatarColor: '0xFF4364F7',
        route: RouteEntity(
          pointA: LatLngEntity(lat: 23.8103, lng: 90.4125),
          pointB: LatLngEntity(lat: 22.3569, lng: 91.7832),
        ),
      );

      expect(user.latA, 23.8103);
      expect(user.lngA, 90.4125);
      expect(user.latB, 22.3569);
      expect(user.lngB, 91.7832);
    });

    test('should compute correct dynamic route names from address', () {
      const user = UserEntity(
        id: 2,
        name: 'John Doe',
        email: 'john@example.com',
        phone: '87654321',
        avatar: 'avatar2.png',
        address: 'New York, NY, USA',
        avatarColor: '0xFF0066FF',
        route: RouteEntity(
          pointA: LatLngEntity(lat: 40.7128, lng: -74.0060),
          pointB: LatLngEntity(lat: 40.7306, lng: -73.9352),
        ),
      );

      expect(user.routeNameA, 'New York Center');
      expect(user.routeNameB, 'New York Dispatch Hub');
    });
  });
}
