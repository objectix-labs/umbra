import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:umbra_core/umbra_core.dart';

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
    return {'key': key.toJson(), 'signingKey': signingKey.toJson()};
  }

  factory IdentityKey.fromJson(Map<String, dynamic> json) {
    return IdentityKey(
      SimplePublicKeyJson.fromJson(json['key']),
      SimplePublicKeyJson.fromJson(json['signingKey']),
    );
  }

  @override
  List<Object> get props => [key, signingKey];
}
