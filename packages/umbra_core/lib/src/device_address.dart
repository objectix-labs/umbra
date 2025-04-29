import 'package:equatable/equatable.dart';
import 'package:umbra_core/umbra_core.dart';

/// Represents a device address, which is a unique identifier for a device
/// associated with a user. The device address is used to identify the
/// device in the Umbra network and is associated with a user address.
/// The device address is a 16-character string that is globally unique.
class DeviceAddress extends Equatable {
  /// The device ID of the of the device. Must be globally unique.
  final String id;

  /// The user address denoting the owner of this device.
  final UserAddress user;

  /// The constructor for the [DeviceAddress] class.
  DeviceAddress({required this.id, required this.user}) {
    if (id.length != 16) {
      throw ArgumentError('Device identifier must be 16 characters long');
    }
  }

  /// Creates a new [DeviceAddress] for the given user address.
  factory DeviceAddress.newForUser(UserAddress userAddress) {
    return DeviceAddress(id: IdGenerator.generate(16), user: userAddress);
  }

  /// Returns this device address as a Umbra Device URI.
  String toUri() => "umbra://${user.address}/dev/$id";

  Map<String, dynamic> toJson() {
    return {'id': id, 'user': user.toJson()};
  }

  factory DeviceAddress.fromJson(Map<String, dynamic> json) {
    return DeviceAddress(
      id: json['id'] as String,
      user: UserAddress.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [id, user];
}
