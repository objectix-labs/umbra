import 'package:flutter_test/flutter_test.dart';

import 'package:umbra_core/umbra_core.dart';

void main() {
  final keyExchangeService = KeyExchangeService();
  final identityKeyGenerator = IdentityKeyGenerator();

  late IdentityKeyPair identityKeyPairAlice;
  late IdentityKeyPair identityKeyPairBob;

  setUp(() async {
    identityKeyPairAlice = await identityKeyGenerator.generate();
    identityKeyPairBob = await identityKeyGenerator.generate();
  });

  test('key exchangee service correctly exchanges key', () async {
    final sharedKeyAlice = await keyExchangeService.exchange(
      identityKeyPairAlice,
      await identityKeyPairBob.identityKey,
    );

    final sharedKeyBob = await keyExchangeService.exchange(
      identityKeyPairBob,
      await identityKeyPairAlice.identityKey,
    );

    expect(sharedKeyAlice, isNotNull);
    expect(sharedKeyBob, isNotNull);
    expect(sharedKeyAlice, sharedKeyBob);
  });
}
