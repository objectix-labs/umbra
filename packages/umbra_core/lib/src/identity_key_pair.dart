import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:umbra_core/umbra_core.dart';

/// Represents an identity key pair, which consists of a DH key pair
/// and a signing key pair. The DH key pair is used for secure communication,
/// while the signing key pair is used for authentication.
class IdentityKeyPair extends Equatable {
  /// Diffie-Hellman key pair used for secure communication.
  final SimpleKeyPair keyPair;

  /// Signing key pair used for authentication.
  final SimpleKeyPair signingKeyPair;

  const IdentityKeyPair(this.keyPair, this.signingKeyPair);

  Future<IdentityKey> get identityKey async {
    final pubKey = await keyPair.extractPublicKey();
    final signingPubKey = await signingKeyPair.extractPublicKey();
    return IdentityKey(pubKey, signingPubKey);
  }

  @override
  List<Object> get props => [keyPair, signingKeyPair];
}
