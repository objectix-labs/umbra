import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:umbra_core/umbra_core.dart';

/// Provides functions for generating signatures on binary data
/// and verifying them.
class SignatureService {
  final Ed25519 _ed25519 = Ed25519();

  // The constructor initializes the service.
  SignatureService();

  /// Signs a [message] using the provided [identityKey].
  ///
  /// Returns the binary signature as a list of bytes.
  Future<List<int>> sign(List<int> message, IdentityKeyPair identityKey) async {
    final signature = await _ed25519.sign(
      message,
      keyPair: identityKey.signingKey,
    );

    return signature.bytes;
  }

  /// Verifies a [signature] for a given [message] using the provided
  /// [identityKey].
  ///
  /// Returns true if the signature is valid, false otherwise.
  Future<bool> verify(
    List<int> message,
    List<int> signature,
    IdentityKey identityKey,
  ) async {
    final sig = Signature(signature, publicKey: identityKey.signingKey);
    final isValid = await _ed25519.verify(message, signature: sig);
    return isValid;
  }
}
