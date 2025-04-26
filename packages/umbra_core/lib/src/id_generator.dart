import 'dart:math';

class IdGenerator {
  /// Generates a random ID of the specified length using a secure random number generator.
  /// The generated ID consists of uppercase letters, lowercase letters, and digits,
  /// excluding confusing characters like '0', 'O', 'I', and 'l'. The resulting
  /// ID is a string of the specified length.
  static String generate(int length) {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789'; // no confusing chars
    final rand = Random.secure();

    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
