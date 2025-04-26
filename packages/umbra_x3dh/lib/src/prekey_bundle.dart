import "package:cryptography_plus/cryptography_plus.dart";
import "package:umbra_core/umbra_core.dart";

class PrekeyBundle {
  final IdentityKey identityKey;
  final SimplePublicKey preKey;
  final SimplePublicKey oneTimePreKey;
  final Signature preKeySignature;

  PrekeyBundle({
    required this.identityKey,
    required this.preKey,
    required this.oneTimePreKey,
    required this.preKeySignature,
  });

  Map<String, dynamic> toJson() {
    return {
      'identityKey': identityKey.toJson(),
      'preKey': preKey.toJson(),
      'preKeySignature': preKeySignature.toJson(),
      'oneTimePreKey': oneTimePreKey.toJson(),
    };
  }

  factory PrekeyBundle.fromJson(Map<String, dynamic> json) {
    return PrekeyBundle(
      identityKey: IdentityKey.fromJson(json['identityKey']),
      preKey: SimplePublicKeyJson.fromJson(json['preKey']),
      preKeySignature: SignatureJson.fromJson(json['preKeySignature']),
      oneTimePreKey: SimplePublicKeyJson.fromJson(json['oneTimePreKey']),
    );
  }
}
