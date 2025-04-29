import 'package:cryptography_plus/cryptography_plus.dart';
import "dart:convert";

extension SimplePublicKeyJson on SimplePublicKey {
  /// Converts the [SimplePublicKey] to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {'bytes': base64Encode(bytes), 'type': type.toJson()};
  }

  /// Creates a [SimplePublicKey] from a JSON-compatible map.
  static SimplePublicKey fromJson(Map<String, dynamic> json) {
    final type = KeyPairTypeJson.fromJson(json['type']);
    final bytes = base64Decode(json['bytes']);
    return SimplePublicKey(bytes, type: type);
  }
}

extension KeyPairTypeJson on KeyPairType {
  /// Converts the [KeyPairType] to a JSON-compatible string.
  String toJson() {
    return name;
  }

  /// Creates a [KeyPairType] from a JSON-compatible string.
  static KeyPairType fromJson(String json) {
    switch (json) {
      case 'x25519':
        return KeyPairType.x25519;
      case 'ed25519':
        return KeyPairType.ed25519;
      default:
        throw ArgumentError('Unsupported key pair type: $json');
    }
  }
}

extension SignatureJson on Signature {
  /// Converts the [Signature] to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    if (publicKey is! SimplePublicKey) {
      throw ArgumentError('Signature public key must be a SimplePublicKey');
    }

    return {
      'bytes': base64Encode(bytes),
      'publicKey': (publicKey as SimplePublicKey).toJson(),
    };
  }

  /// Creates a [Signature] from a JSON-compatible map.
  static Signature fromJson(Map<String, dynamic> json) {
    final bytes = base64Decode(json['bytes']);
    final publicKey = SimplePublicKeyJson.fromJson(json['publicKey']);
    return Signature(bytes, publicKey: publicKey);
  }
}

T? parseIfNotNull<T>(dynamic value, T Function(Map<String, dynamic>) parser) {
  if (value == null) return null;
  return parser(value as Map<String, dynamic>);
}
