import 'package:flutter_test/flutter_test.dart';

import 'package:umbra_core/umbra_core.dart';

void main() {
  test('user address accepts correct e-mail address only', () {
    expect(() => UserAddress(email: "some.user@domain.com"), returnsNormally);
    expect(() => UserAddress(email: "some-identifier"), throwsArgumentError);
    expect(() => UserAddress(email: ""), throwsArgumentError);
    expect(() => UserAddress(email: "incomplete@address"), throwsArgumentError);
  });

  test('user address produces correct address strings', () {
    final userAddress = UserAddress(email: "some.user@example.com");
    expect(userAddress.toString(), "some.user@example.com");

    final userAddressWithName = UserAddress(
      email: "some.user@domain.com",
      displayName: "Some User",
    );
    expect(userAddressWithName.toString(), "some.user@domain.com <Some User>");
  });

  test('user address trims and lowercases address', () {
    final userAddress = UserAddress(email: "  Some.User@examplE.CoM     ");
    expect(userAddress.address, "some.user@example.com");
  });
}
