import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:equatable/equatable.dart';

class CipherKey extends Equatable {
  final SecretKey _key;

  const CipherKey(this._key);

  @override
  List<Object> get props => [_key];
}
