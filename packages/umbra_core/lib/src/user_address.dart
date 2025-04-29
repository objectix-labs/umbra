import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

class UserAddress extends Equatable {
  /// Address of the user.
  /// This is the address of the user in the form of a string.
  final String address;

  /// Optional name of the user.
  /// This is the name of the user, which can be used for display purposes.
  final String? name;

  UserAddress({required String email, String? displayName})
    : address = email.trim().toLowerCase(),
      name = displayName?.trim() {
    if (address.isEmpty) {
      throw ArgumentError('Address cannot be empty');
    }

    if (!EmailValidator.validate(address, false, false)) {
      throw ArgumentError('Address must be a valid email address');
    }
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'name': name};
  }

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      email: json['address'] as String,
      displayName: json['name'] as String?,
    );
  }

  @override
  String toString() {
    if (name != null && name!.isNotEmpty) {
      return "$address <$name>";
    }
    return address;
  }

  @override
  List<Object?> get props => [address, name];
}
