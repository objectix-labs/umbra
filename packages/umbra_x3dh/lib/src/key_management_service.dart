import "package:umbra_core/umbra_core.dart";
import "package:cryptography_plus/cryptography_plus.dart";
import "package:umbra_x3dh/umbra_x3dh.dart";

/// An interface for a key management service that allows for the registration,
/// updating, and fetching of prekeys and identity keys.
///
/// This service is used to manage prekeys and identity keys for secure
/// communication between users.
/// It provides methods to register new keys, update existing keys, and fetch
/// prekey bundles for a given user address.
/// The implementation of this service should handle the storage and retrieval
/// of keys, as well as the necessary cryptographic operations to ensure the
/// security and integrity of the keys.
/// The [KeyManagementService] interface is designed to be flexible and can be
/// implemented by different storage backends, such as local storage, remote
/// servers, or cloud storage.
/// The implementation should ensure that the keys are stored securely and
/// are only accessible to authorized users.

abstract interface class KeyManagementService {
  /// Registers an initial key package for the local user.
  ///
  /// This method should be called when the user first registers with the
  /// key publishing service. It should include the identity key, prekey,
  /// prekey signature, and a list of one-time prekeys. This method should be
  /// called only once for each user. If the user has already registered, the
  /// implementation should throw an exception or return an error.
  /// It should also handle any necessary cryptographic operations to ensure the
  /// security and integrity of the keys.
  ///
  /// The [identityKey] parameter is the identity key of the local user.
  /// The [preKey] parameter is the prekey that will be used for initial
  /// communication.
  /// The [preKeySignature] parameter is the signature of the prekey,
  /// which is used to verify the authenticity of the prekey.
  /// The [oneTimePreKeys] parameter is a list of one-time prekeys that can
  /// be used for secure communication with other users.
  /// The implementation should ensure that the keys are stored securely
  /// and are only accessible to authorized users.
  Future<void> register({
    required IdentityKey identityKey,
    required SimplePublicKey preKey,
    required Signature preKeySignature,
    required List<SimplePublicKey> oneTimePreKeys,
  });

  /// Updates the prekey and prekey signature for the local user.
  ///
  /// This method should be called when the user wants to update their
  /// prekey and prekey signature. The [preKey] parameter is the new prekey that
  /// will be used for initial communication. The [preKeySignature] parameter is
  /// the new signature of the updated prekey, which is used to verify the
  /// authenticity of the prekey.
  Future<void> update(SimplePublicKey preKey, Signature preKeySignature);

  /// Adds a list of one-time prekeys for the local user.
  ///
  /// This method should be called when the user wants to add new one-time
  /// prekeys. The [oneTimePreKeys] parameter is a list of one-time prekeys
  /// that can be used for secure communication with other users.
  Future<void> add(List<SimplePublicKey> oneTimePreKeys);

  /// Fetches the prekey bundle for a given device address.
  ///
  /// This method should be called when the user wants to retrieve the
  /// prekey bundle for a specific user address. The [deviceAddress] parameter
  /// is the address of the device whose prekey bundle is being requested.
  Future<PrekeyBundle> fetch(DeviceAddress deviceAddress);
}
