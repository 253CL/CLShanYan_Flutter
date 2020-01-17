// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shanYanUIConfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShanYanUIConfig _$ShanYanUIConfigFromJson(Map<String, dynamic> json) {
  return ShanYanUIConfig(
    ios: json['ios'] == null
        ? null
        : ShanYanUIConfigIOS.fromJson(json['ios'] as Map<String, dynamic>),
    android_portrait: json['android_portrait'] == null
        ? null
        : ShanYanUIConfigAndroid.fromJson(
            json['android_portrait'] as Map<String, dynamic>),
    android_landscape: json['android_landscape'] == null
        ? null
        : ShanYanUIConfigAndroid.fromJson(
            json['android_landscape'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShanYanUIConfigToJson(ShanYanUIConfig instance) =>
    <String, dynamic>{
      'ios': instance.ios?.toJson(),
      'android_portrait': instance.android_portrait?.toJson(),
      'android_landscape': instance.android_landscape?.toJson(),
    };

ShanYanUIConfigIOS _$ShanYanUIConfigIOSFromJson(Map<String, dynamic> json) {
  return ShanYanUIConfigIOS(
    isFinish: json['isFinish'] as bool,
  )
    ..setAuthBGImgPath = json['setAuthBGImgPath'] as String
    ..setStatusBarHidden = json['setStatusBarHidden'] as bool
    ..navigationBackgroundClear = json['navigationBackgroundClear'] as bool
    ..navigationBackBtnImage = json['navigationBackBtnImage'] as String
    ..setLogoImgPath = json['setLogoImgPath'] as String
    ..loginBtnText = json['loginBtnText'] as String
    ..loginBtnTextColor = json['loginBtnTextColor'] as String
    ..loginBtnBgColor = json['loginBtnBgColor'] as String
    ..loginBtnTextFont = (json['loginBtnTextFont'] as num)?.toDouble()
    ..loginBtnCornerRadius = (json['loginBtnCornerRadius'] as num)?.toDouble()
    ..loginBtnBorderWidth = (json['loginBtnBorderWidth'] as num)?.toDouble()
    ..loginBtnBorderColor = json['loginBtnBorderColor'] as String
    ..phoneNumberFont = (json['phoneNumberFont'] as num)?.toDouble()
    ..layOut_portrait = json['layOut_portrait'] == null
        ? null
        : ClOrientationLayOutIOS.fromJson(
            json['layOut_portrait'] as Map<String, dynamic>)
    ..layOut_landscape = json['layOut_landscape'] == null
        ? null
        : ClOrientationLayOutIOS.fromJson(
            json['layOut_landscape'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ShanYanUIConfigIOSToJson(ShanYanUIConfigIOS instance) =>
    <String, dynamic>{
      'isFinish': instance.isFinish,
      'setAuthBGImgPath': instance.setAuthBGImgPath,
      'setStatusBarHidden': instance.setStatusBarHidden,
      'navigationBackgroundClear': instance.navigationBackgroundClear,
      'navigationBackBtnImage': instance.navigationBackBtnImage,
      'setLogoImgPath': instance.setLogoImgPath,
      'loginBtnText': instance.loginBtnText,
      'loginBtnTextColor': instance.loginBtnTextColor,
      'loginBtnBgColor': instance.loginBtnBgColor,
      'loginBtnTextFont': instance.loginBtnTextFont,
      'loginBtnCornerRadius': instance.loginBtnCornerRadius,
      'loginBtnBorderWidth': instance.loginBtnBorderWidth,
      'loginBtnBorderColor': instance.loginBtnBorderColor,
      'phoneNumberFont': instance.phoneNumberFont,
      'layOut_portrait': instance.layOut_portrait?.toJson(),
      'layOut_landscape': instance.layOut_landscape?.toJson(),
    };

ClOrientationLayOutIOS _$ClOrientationLayOutIOSFromJson(
    Map<String, dynamic> json) {
  return ClOrientationLayOutIOS(
    setLogBtnWidth: json['setLogBtnWidth'] as int,
  )
    ..setLogoWidth = json['setLogoWidth'] as int
    ..setLogoHeight = json['setLogoHeight'] as int
    ..setLogoLeft = json['setLogoLeft'] as int
    ..setLogoRight = json['setLogoRight'] as int
    ..setLogoTop = json['setLogoTop'] as int
    ..setLogoBottom = json['setLogoBottom'] as int
    ..setLogoCenterX = json['setLogoCenterX'] as int
    ..setLogoCenterY = json['setLogoCenterY'] as int
    ..setNumFieldWidth = json['setNumFieldWidth'] as int
    ..setNumFieldHeight = json['setNumFieldHeight'] as int
    ..setNumFieldLeft = json['setNumFieldLeft'] as int
    ..setNumFieldRight = json['setNumFieldRight'] as int
    ..setNumFieldTop = json['setNumFieldTop'] as int
    ..setNumFieldBottom = json['setNumFieldBottom'] as int
    ..setNumFieldCenterX = json['setNumFieldCenterX'] as int
    ..setNumFieldCenterY = json['setNumFieldCenterY'] as int
    ..setLogBtnHeight = json['setLogBtnHeight'] as int
    ..setLogBtnLeft = json['setLogBtnLeft'] as int
    ..setLogBtnRight = json['setLogBtnRight'] as int
    ..setLogBtnTop = json['setLogBtnTop'] as int
    ..setLogBtnBottom = json['setLogBtnBottom'] as int
    ..setLogBtnCenterX = json['setLogBtnCenterX'] as int
    ..setLogBtnCenterY = json['setLogBtnCenterY'] as int
    ..setPrivacyHeight = json['setPrivacyHeight'] as int
    ..setPrivacyWidth = json['setPrivacyWidth'] as int
    ..setPrivacyLeft = json['setPrivacyLeft'] as int
    ..setPrivacyRight = json['setPrivacyRight'] as int
    ..setPrivacyTop = json['setPrivacyTop'] as int
    ..setPrivacyBottom = json['setPrivacyBottom'] as int
    ..setPrivacyCenterX = json['setPrivacyCenterX'] as int
    ..setPrivacyCenterY = json['setPrivacyCenterY'] as int
    ..setSloganHeight = json['setSloganHeight'] as int
    ..setSloganWidth = json['setSloganWidth'] as int
    ..setSloganLeft = json['setSloganLeft'] as int
    ..setSloganRight = json['setSloganRight'] as int
    ..setSloganTop = json['setSloganTop'] as int
    ..setSloganBottom = json['setSloganBottom'] as int
    ..setSloganCenterX = json['setSloganCenterX'] as int
    ..setSloganCenterY = json['setSloganCenterY'] as int
    ..setShanYanSloganHeight = json['setShanYanSloganHeight'] as int
    ..setShanYanSloganWidth = json['setShanYanSloganWidth'] as int
    ..setShanYanSloganLeft = json['setShanYanSloganLeft'] as int
    ..setShanYanSloganRight = json['setShanYanSloganRight'] as int
    ..setShanYanSloganTop = json['setShanYanSloganTop'] as int
    ..setShanYanSloganBottom = json['setShanYanSloganBottom'] as int
    ..setShanYanSloganCenterX = json['setShanYanSloganCenterX'] as int
    ..setShanYanSloganCenterY = json['setShanYanSloganCenterY'] as int;
}

Map<String, dynamic> _$ClOrientationLayOutIOSToJson(
        ClOrientationLayOutIOS instance) =>
    <String, dynamic>{
      'setLogoWidth': instance.setLogoWidth,
      'setLogoHeight': instance.setLogoHeight,
      'setLogoLeft': instance.setLogoLeft,
      'setLogoRight': instance.setLogoRight,
      'setLogoTop': instance.setLogoTop,
      'setLogoBottom': instance.setLogoBottom,
      'setLogoCenterX': instance.setLogoCenterX,
      'setLogoCenterY': instance.setLogoCenterY,
      'setNumFieldWidth': instance.setNumFieldWidth,
      'setNumFieldHeight': instance.setNumFieldHeight,
      'setNumFieldLeft': instance.setNumFieldLeft,
      'setNumFieldRight': instance.setNumFieldRight,
      'setNumFieldTop': instance.setNumFieldTop,
      'setNumFieldBottom': instance.setNumFieldBottom,
      'setNumFieldCenterX': instance.setNumFieldCenterX,
      'setNumFieldCenterY': instance.setNumFieldCenterY,
      'setLogBtnHeight': instance.setLogBtnHeight,
      'setLogBtnWidth': instance.setLogBtnWidth,
      'setLogBtnLeft': instance.setLogBtnLeft,
      'setLogBtnRight': instance.setLogBtnRight,
      'setLogBtnTop': instance.setLogBtnTop,
      'setLogBtnBottom': instance.setLogBtnBottom,
      'setLogBtnCenterX': instance.setLogBtnCenterX,
      'setLogBtnCenterY': instance.setLogBtnCenterY,
      'setPrivacyHeight': instance.setPrivacyHeight,
      'setPrivacyWidth': instance.setPrivacyWidth,
      'setPrivacyLeft': instance.setPrivacyLeft,
      'setPrivacyRight': instance.setPrivacyRight,
      'setPrivacyTop': instance.setPrivacyTop,
      'setPrivacyBottom': instance.setPrivacyBottom,
      'setPrivacyCenterX': instance.setPrivacyCenterX,
      'setPrivacyCenterY': instance.setPrivacyCenterY,
      'setSloganHeight': instance.setSloganHeight,
      'setSloganWidth': instance.setSloganWidth,
      'setSloganLeft': instance.setSloganLeft,
      'setSloganRight': instance.setSloganRight,
      'setSloganTop': instance.setSloganTop,
      'setSloganBottom': instance.setSloganBottom,
      'setSloganCenterX': instance.setSloganCenterX,
      'setSloganCenterY': instance.setSloganCenterY,
      'setShanYanSloganHeight': instance.setShanYanSloganHeight,
      'setShanYanSloganWidth': instance.setShanYanSloganWidth,
      'setShanYanSloganLeft': instance.setShanYanSloganLeft,
      'setShanYanSloganRight': instance.setShanYanSloganRight,
      'setShanYanSloganTop': instance.setShanYanSloganTop,
      'setShanYanSloganBottom': instance.setShanYanSloganBottom,
      'setShanYanSloganCenterX': instance.setShanYanSloganCenterX,
      'setShanYanSloganCenterY': instance.setShanYanSloganCenterY,
    };

ShanYanUIConfigAndroid _$ShanYanUIConfigAndroidFromJson(
    Map<String, dynamic> json) {
  return ShanYanUIConfigAndroid(
    isFinish: json['isFinish'] as bool,
  )
    ..setAuthBGImgPath = json['setAuthBGImgPath'] as String
    ..setStatusBarHidden = json['setStatusBarHidden'] as bool
    ..setAuthBgGifPath = json['setAuthBgGifPath'] as String
    ..setAuthBgVideoPath = json['setAuthBgVideoPath'] as String
    ..setStatusBarColor = json['setStatusBarColor'] as String
    ..setLightColor = json['setLightColor'] as bool
    ..setVirtualKeyTransparent = json['setVirtualKeyTransparent'] as bool
    ..setFullScreen = json['setFullScreen'] as bool
    ..setNavReturnBtnWidth = json['setNavReturnBtnWidth'] as int
    ..setNavReturnBtnHeight = json['setNavReturnBtnHeight'] as int
    ..setNavReturnBtnOffsetRightX = json['setNavReturnBtnOffsetRightX'] as int
    ..setNavReturnBtnOffsetX = json['setNavReturnBtnOffsetX'] as int
    ..setNavReturnBtnOffsetY = json['setNavReturnBtnOffsetY'] as int
    ..setLogoImgPath = json['setLogoImgPath'] as String
    ..setLogoHidden = json['setLogoHidden'] as bool
    ..setLogoOffsetY = json['setLogoOffsetY'] as int
    ..setLogoOffsetBottomY = json['setLogoOffsetBottomY'] as int
    ..setLogoOffsetX = json['setLogoOffsetX'] as int
    ..setLogoWidth = json['setLogoWidth'] as int
    ..setLogoHeight = json['setLogoHeight'] as int
    ..setNumFieldOffsetY = json['setNumFieldOffsetY'] as int
    ..setNumFieldOffsetBottomY = json['setNumFieldOffsetBottomY'] as int
    ..setNumberSize = json['setNumberSize'] as int
    ..setNumFieldOffsetX = json['setNumFieldOffsetX'] as int
    ..setNumFieldWidth = json['setNumFieldWidth'] as int
    ..setNumFieldHeight = json['setNumFieldHeight'] as int
    ..setLogBtnOffsetY = json['setLogBtnOffsetY'] as int
    ..setLogBtnOffsetBottomY = json['setLogBtnOffsetBottomY'] as int
    ..setLogBtnTextSize = json['setLogBtnTextSize'] as int
    ..setLogBtnOffsetX = json['setLogBtnOffsetX'] as int
    ..setLogBtnHeight = json['setLogBtnHeight'] as int
    ..setLogBtnWidth = json['setLogBtnWidth'] as int
    ..setPrivacyOffsetBottomY = json['setPrivacyOffsetBottomY'] as int
    ..setPrivacyOffsetY = json['setPrivacyOffsetY'] as int
    ..setPrivacyOffsetX = json['setPrivacyOffsetX'] as int
    ..setSloganOffsetY = json['setSloganOffsetY'] as int
    ..setSloganOffsetBottomY = json['setSloganOffsetBottomY'] as int
    ..setSloganOffsetX = json['setSloganOffsetX'] as int
    ..setShanYanSloganOffsetY = json['setShanYanSloganOffsetY'] as int
    ..setShanYanSloganOffsetBottomY =
        json['setShanYanSloganOffsetBottomY'] as int
    ..setShanYanSloganOffsetX = json['setShanYanSloganOffsetX'] as int;
}

Map<String, dynamic> _$ShanYanUIConfigAndroidToJson(
        ShanYanUIConfigAndroid instance) =>
    <String, dynamic>{
      'isFinish': instance.isFinish,
      'setAuthBGImgPath': instance.setAuthBGImgPath,
      'setStatusBarHidden': instance.setStatusBarHidden,
      'setAuthBgGifPath': instance.setAuthBgGifPath,
      'setAuthBgVideoPath': instance.setAuthBgVideoPath,
      'setStatusBarColor': instance.setStatusBarColor,
      'setLightColor': instance.setLightColor,
      'setVirtualKeyTransparent': instance.setVirtualKeyTransparent,
      'setFullScreen': instance.setFullScreen,
      'setNavReturnBtnWidth': instance.setNavReturnBtnWidth,
      'setNavReturnBtnHeight': instance.setNavReturnBtnHeight,
      'setNavReturnBtnOffsetRightX': instance.setNavReturnBtnOffsetRightX,
      'setNavReturnBtnOffsetX': instance.setNavReturnBtnOffsetX,
      'setNavReturnBtnOffsetY': instance.setNavReturnBtnOffsetY,
      'setLogoImgPath': instance.setLogoImgPath,
      'setLogoHidden': instance.setLogoHidden,
      'setLogoOffsetY': instance.setLogoOffsetY,
      'setLogoOffsetBottomY': instance.setLogoOffsetBottomY,
      'setLogoOffsetX': instance.setLogoOffsetX,
      'setLogoWidth': instance.setLogoWidth,
      'setLogoHeight': instance.setLogoHeight,
      'setNumFieldOffsetY': instance.setNumFieldOffsetY,
      'setNumFieldOffsetBottomY': instance.setNumFieldOffsetBottomY,
      'setNumberSize': instance.setNumberSize,
      'setNumFieldOffsetX': instance.setNumFieldOffsetX,
      'setNumFieldWidth': instance.setNumFieldWidth,
      'setNumFieldHeight': instance.setNumFieldHeight,
      'setLogBtnOffsetY': instance.setLogBtnOffsetY,
      'setLogBtnOffsetBottomY': instance.setLogBtnOffsetBottomY,
      'setLogBtnTextSize': instance.setLogBtnTextSize,
      'setLogBtnOffsetX': instance.setLogBtnOffsetX,
      'setLogBtnHeight': instance.setLogBtnHeight,
      'setLogBtnWidth': instance.setLogBtnWidth,
      'setPrivacyOffsetBottomY': instance.setPrivacyOffsetBottomY,
      'setPrivacyOffsetY': instance.setPrivacyOffsetY,
      'setPrivacyOffsetX': instance.setPrivacyOffsetX,
      'setSloganOffsetY': instance.setSloganOffsetY,
      'setSloganOffsetBottomY': instance.setSloganOffsetBottomY,
      'setSloganOffsetX': instance.setSloganOffsetX,
      'setShanYanSloganOffsetY': instance.setShanYanSloganOffsetY,
      'setShanYanSloganOffsetBottomY': instance.setShanYanSloganOffsetBottomY,
      'setShanYanSloganOffsetX': instance.setShanYanSloganOffsetX,
    };
