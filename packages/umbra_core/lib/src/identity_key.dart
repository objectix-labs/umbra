import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

/// Represents an identity key pair, which consists of a public DH
/// key and a public signing key. The DH key is used for secure communication,
/// while the signing key is used for authentication.
class IdentityKey extends Equatable {
  /// Diffie-Hellman public key used for secure communication.
  final SimplePublicKey key;

  /// Signing public key used for authentication.
  final SimplePublicKey signingKey;

  const IdentityKey(this.key, this.signingKey);

  Map<String, dynamic> toJson() {
    return {
      'key': base64Encode(key.bytes),
      'signingKey': base64Encode(signingKey.bytes),
    };
  }

  factory IdentityKey.fromJson(Map<String, dynamic> json) {
    return IdentityKey(
      SimplePublicKey(base64Decode(json['key']), type: KeyPairType.x25519),
      SimplePublicKey(
        base64Decode(json['signingKey']),
        type: KeyPairType.ed25519,
      ),
    );
  }

  @override
  List<Object> get props => [key, signingKey];
}
