import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';

/// Represents a symmetric cipher key used for encryption and decryption
/// of binary messages.
class CipherKey extends Equatable {
  final SecretKey key;

  const CipherKey(this.key);

  @override
  List<Object> get props => [key];
}
