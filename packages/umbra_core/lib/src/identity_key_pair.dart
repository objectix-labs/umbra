import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:umbra_core/umbra_core.dart';

/// Represents an identity key pair, which consists of a DH key pair
/// and a signing key pair. The DH key pair is used for secure communication,
/// while the signing key pair is used for authentication.
class IdentityKeyPair extends Equatable {
  /// The device address that identifies the device associated with this key.
  final DeviceAddress device;

  /// Diffie-Hellman key pair used for secure communication.
  final SimpleKeyPair key;

  /// Signing key pair used for authentication.
  final SimpleKeyPair signingKey;

  const IdentityKeyPair({
    required this.device,
    required this.key,
    required this.signingKey,
  });

  Future<IdentityKey> get identityKey async {
    final pubKey = await key.extractPublicKey();
    final signingPubKey = await signingKey.extractPublicKey();
    return IdentityKey(device: device, key: pubKey, signingKey: signingPubKey);
  }

  @override
  List<Object> get props => [device, key, signingKey];
}
