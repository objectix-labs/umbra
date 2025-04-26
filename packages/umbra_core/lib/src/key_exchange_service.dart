import 'package:cryptography_plus/cryptography_plus.dart';
import "identity_key.dart";
import "identity_key_pair.dart";

/// A service for performing key exchange using a local identity key pair and
/// a remote identity key.
///
/// This service uses the Diffie-Hellman algorithm over Curve25519 to derive a
/// shared key for secure communication between tweo entities represeted by
/// the given identity keys.
class KeyExchangeService {
  final X25519 _x25519 = X25519();

  KeyExchangeService();

  /// Dervices a shared key with a remote identity key using a local identity
  /// key pair.
  ///
  /// The [myKeyPair] parameter is the local identity key pair, and the
  /// [otherKey] parameter is the remote identity key.
  ///
  /// Returns a [CipherKey] representing the shared key.
  Future<SecretKey> exchange(
    IdentityKeyPair myKeyPair,
    IdentityKey otherKey,
  ) async {
    return _x25519.sharedSecretKey(
      keyPair: myKeyPair.key,
      remotePublicKey: otherKey.key,
    );
  }
}
