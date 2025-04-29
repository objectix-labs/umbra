import 'package:flutter_test/flutter_test.dart';

import 'package:umbra_core/umbra_core.dart';

void main() {
  final signatureService = SignatureService();
  final identityKeyGenerator = IdentityKeyGenerator();

  late IdentityKeyPair identityKeyPair;
  late IdentityKey identityKey;

  setUp(() async {
    final alice = UserAddress(email: 'alice@example.com', displayName: 'Alice');
    final deviceAlice = DeviceAddress.newForUser(alice);
    identityKeyPair = await identityKeyGenerator.generate(deviceAlice);
    identityKey = await identityKeyPair.identityKey;
  });

  test(
    'signature service signs messages and verifies correct signatures',
    () async {
      final message = [1, 2, 3, 4, 5];
      final signature = await signatureService.sign(message, identityKeyPair);

      expect(signature, isNotNull);
      expect(signature, isNotEmpty);
      expect(signature.length, 64);

      final isValid = await signatureService.verify(
        message,
        signature,
        identityKey,
      );
      expect(isValid, true);
    },
  );

  test(
    'signature service does not verify correct signature on tampered message',
    () async {
      final message = [1, 2, 3, 4, 5];
      final signature = await signatureService.sign(message, identityKeyPair);

      final tamperedMessage = [5, 4, 3, 2, 1];
      final isInvalid = await signatureService.verify(
        tamperedMessage,
        signature,
        identityKey,
      );
      expect(isInvalid, false);
    },
  );

  test(
    'signature service does not verify tampered signature on original message',
    () async {
      final message = [1, 2, 3, 4, 5];
      final signature = await signatureService.sign(message, identityKeyPair);

      final tamperedSignature = [
        ...signature.sublist(0, 32),
        ...[0, 0, 0, 0],
        ...signature.sublist(36),
      ];
      final isTamperedSignatureValid = await signatureService.verify(
        message,
        tamperedSignature,
        identityKey,
      );
      expect(isTamperedSignatureValid, false);
    },
  );
}
