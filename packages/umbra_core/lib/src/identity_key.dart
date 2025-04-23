import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';

/// Represents an identity key pair, which consists of a public DH
/// key and a public signing key. The DH key is used for secure communication,
/// while the signing key is used for authentication.
class IdentityKey extends Equatable {
  final SimplePublicKey key;
  final SimplePublicKey signingKey;

  const IdentityKey(this.key, this.signingKey);

  @override
  List<Object> get props => [key, signingKey];
}
