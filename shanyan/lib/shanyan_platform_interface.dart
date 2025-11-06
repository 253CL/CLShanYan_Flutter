import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'shanyan_method_channel.dart';

abstract class ShanyanPlatform extends PlatformInterface {
  /// Constructs a ShanyanPlatform.
  ShanyanPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShanyanPlatform _instance = MethodChannelShanyan();

  /// The default instance of [ShanyanPlatform] to use.
  ///
  /// Defaults to [MethodChannelShanyan].
  static ShanyanPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShanyanPlatform] when
  /// they register themselves.
  static set instance(ShanyanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
