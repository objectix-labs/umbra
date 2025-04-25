import "package:cryptography_plus/cryptography_plus.dart";
import "package:umbra_core/umbra_core.dart";

class PrekeyBundle {
  final IdentityKey identityKey;
  final SimplePublicKey preKey;
  final Signature preKeySignature;

  PrekeyBundle({
    required this.identityKey,
    required this.preKey,
    required this.preKeySignature,
  });

  Map<String, dynamic> toJson() {
    return {
      'identityKey': identityKey.toJson(),
      'preKey': simplePublicKeyToJson(preKey),
      'prekeySignature': signatureToJson(preKeySignature),
    };
  }

  factory PrekeyBundle.fromJson(Map<String, dynamic> json) {
    return PrekeyBundle(
      identityKey: IdentityKey.fromJson(json['identityKey']),
      preKey: simplePublicKeyFromJson(json['preKey']),
      preKeySignature: signatureFromJson(json['signedPreKey']),
    );
  }
}
