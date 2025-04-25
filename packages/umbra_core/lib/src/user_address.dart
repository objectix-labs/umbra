import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

class UserAddress extends Equatable {
  /// Address of the user.
  /// This is the address of the user in the form of a string.
  final String address;

  /// Optional name of the user.
  /// This is the name of the user, which can be used for display purposes.
  /// It is optional and can be null.
  /// If not provided, the address will be used as the display name.
  final String? name;

  UserAddress(String emailAddress, {String? displayName})
    : address = emailAddress.trim().toLowerCase(),
      name = displayName?.trim() {
    if (address.isEmpty) {
      throw ArgumentError('Address cannot be empty');
    }

    if (!EmailValidator.validate(address, false, false)) {
      throw ArgumentError('Address must be a valid email address');
    }
  }

  @override
  String toString() => name != null ? "$address <$name>" : address;

  @override
  List<Object?> get props => [address, name];
}
