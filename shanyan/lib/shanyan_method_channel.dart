import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'shanyan_platform_interface.dart';

/// An implementation of [ShanyanPlatform] that uses method channels.
class MethodChannelShanyan extends ShanyanPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('shanyan');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
