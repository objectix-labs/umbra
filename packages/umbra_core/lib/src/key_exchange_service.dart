import 'package:cryptography_plus/cryptography_plus.dart';
import "cipher_key.dart";
import "identity_key.dart";
import "identity_key_pair.dart";

class KeyExchangeService {
  final X25519 _x25519 = X25519();

  KeyExchangeService();

  Future<CipherKey> exchange(
    IdentityKeyPair myKeyPair,
    IdentityKey otherKey,
  ) async {
    final key = await _x25519.sharedSecretKey(
      keyPair: myKeyPair.keyPair,
      remotePublicKey: otherKey.key,
    );

    return CipherKey(key);
  }
}
