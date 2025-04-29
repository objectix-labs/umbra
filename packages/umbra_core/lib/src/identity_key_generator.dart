import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:umbra_core/umbra_core.dart';

/// Generates identity key pairs for secure communication and authentication.
class IdentityKeyGenerator {
  final _x25519 = X25519();
  final _ed25519 = Ed25519();

  /// Generates a new identity key pair.
  ///
  /// Returns a [IdentityKeyPair] containing the generated key pair.
  Future<IdentityKeyPair> generate(DeviceAddress device) async {
    // Generate a new X25519 key pair for the DH key
    final dhKeyPair = await _x25519.newKeyPair();

    // Generate a new Ed25519 key pair for the signing key
    final signingKeyPair = await _ed25519.newKeyPair();

    // Return the generated identity key pair
    return IdentityKeyPair(
      device: device,
      key: dhKeyPair,
      signingKey: signingKeyPair,
    );
  }
}
