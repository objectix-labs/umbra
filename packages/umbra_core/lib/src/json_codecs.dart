import 'package:cryptography_plus/cryptography_plus.dart';
import 'dart:convert';

Map<String, dynamic> simplePublicKeyToJson(SimplePublicKey key) {
  final String keyType;
  switch (key.type) {
    case KeyPairType.x25519:
      keyType = "x25519";
    case KeyPairType.ed25519:
      keyType = "ed25519";
    default:
      throw ArgumentError("Unsupported key type: ${key.type}");
  }
  return {"bytes": base64Encode(key.bytes), "type": keyType};
}

SimplePublicKey simplePublicKeyFromJson(Map<String, dynamic> json) {
  final bytes = base64Decode(json["bytes"]);
  final keyType = json["type"];
  final KeyPairType type;

  switch (keyType) {
    case "x25519":
      type = KeyPairType.x25519;
      break;
    case "ed25519":
      type = KeyPairType.ed25519;
      break;
    default:
      throw ArgumentError("Unsupported key type: $keyType");
  }

  return SimplePublicKey(bytes, type: type);
}

Map<String, dynamic> signatureToJson(Signature signature) {
  return {
    "bytes": base64Encode(signature.bytes),
    "publicKey": simplePublicKeyToJson(signature.publicKey as SimplePublicKey),
  };
}

Signature signatureFromJson(Map<String, dynamic> json) {
  final bytes = base64Decode(json["bytes"]);
  final publicKey = simplePublicKeyFromJson(json["publicKey"]);
  return Signature(bytes, publicKey: publicKey);
}
