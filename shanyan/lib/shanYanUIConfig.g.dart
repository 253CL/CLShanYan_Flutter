// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shanYanUIConfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShanYanUIConfig _$ShanYanUIConfigFromJson(Map<String, dynamic> json) {
  return ShanYanUIConfig()
    ..ios = json['ios'] == null
        ? null
        : ShanYanUIConfigIOS.fromJson(json['ios'] as Map<String, dynamic>)
    ..androidPortrait = json['androidPortrait'] == null
        ? null
        : ShanYanUIConfigAndroid.fromJson(
            json['androidPortrait'] as Map<String, dynamic>)
    ..androidLandscape = json['androidLandscape'] == null
        ? null
        : ShanYanUIConfigAndroid.fromJson(
            json['androidLandscape'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ShanYanUIConfigToJson(ShanYanUIConfig instance) =>
    <String, dynamic>{
      'ios': instance.ios?.toJson(),
      'androidPortrait': instance.androidPortrait?.toJson(),
      'androidLandscape': instance.androidLandscape?.toJson(),
    };

ShanYanUIConfigIOS _$ShanYanUIConfigIOSFromJson(Map<String, dynamic> json) {
  return ShanYanUIConfigIOS()
    ..isFinish = json['isFinish'] as bool
    ..setAuthBGImgPath = json['setAuthBGImgPath'] as String
    ..setPreferredStatusBarStyle = _$enumDecodeNullable(
        _$iOSStatusBarStyleEnumMap, json['setPreferredStatusBarStyle'])
    ..setStatusBarHidden = json['setStatusBarHidden'] as bool
    ..setAuthNavHidden = json['setAuthNavHidden'] as bool
    ..setNavigationBarStyle = _$enumDecodeNullable(
        _$iOSBarStyleEnumMap, json['setNavigationBarStyle'])
    ..setAuthNavTransparent = json['setAuthNavTransparent'] as bool
    ..setNavText = json['setNavText'] as String
    ..setNavTextColor = json['setNavTextColor'] as String
    ..setNavTextSize = json['setNavTextSize'] as int
    ..setNavReturnImgPath = json['setNavReturnImgPath'] as String
    ..setNavReturnImgHidden = json['setNavReturnImgHidden'] as bool
    ..setNavBackBtnAlimentRight = json['setNavBackBtnAlimentRight'] as bool
    ..setNavigationBottomLineHidden =
        json['setNavigationBottomLineHidden'] as bool
    ..setNavigationTintColor = json['setNavigationTintColor'] as String
    ..setNavigationBarTintColor = json['setNavigationBarTintColor'] as String
    ..setNavigationBackgroundImage =
        json['setNavigationBackgroundImage'] as String
    ..setNavigationShadowImage = json['setNavigationShadowImage'] as String
    ..setLogoImgPath = json['setLogoImgPath'] as String
    ..setLogoCornerRadius = json['setLogoCornerRadius'] as num
    ..setLogoHidden = json['setLogoHidden'] as bool
    ..setNumberColor = json['setNumberColor'] as String
    ..setNumberSize = json['setNumberSize'] as num
    ..setNumberBold = json['setNumberBold'] as bool
    ..setNumberTextAlignment = _$enumDecodeNullable(
        _$iOSTextAlignmentEnumMap, json['setNumberTextAlignment'])
    ..setLogBtnText = json['setLogBtnText'] as String
    ..setLogBtnTextColor = json['setLogBtnTextColor'] as String
    ..setLoginBtnTextSize = json['setLoginBtnTextSize'] as num
    ..setLoginBtnTextBold = json['setLoginBtnTextBold'] as bool
    ..setLoginBtnBgColor = json['setLoginBtnBgColor'] as String
    ..setLoginBtnNormalBgImage = json['setLoginBtnNormalBgImage'] as String
    ..setLoginBtnHightLightBgImage =
        json['setLoginBtnHightLightBgImage'] as String
    ..setLoginBtnDisabledBgImage = json['setLoginBtnDisabledBgImage'] as String
    ..setLoginBtnBorderColor = json['setLoginBtnBorderColor'] as String
    ..setLoginBtnCornerRadius = json['setLoginBtnCornerRadius'] as num
    ..setLoginBtnBorderWidth = json['setLoginBtnBorderWidth'] as num
    ..setAppPrivacyColor =
        (json['setAppPrivacyColor'] as List)?.map((e) => e as String)?.toList()
    ..setPrivacyTextSize = json['setPrivacyTextSize'] as num
    ..setPrivacyTextBold = json['setPrivacyTextBold'] as bool
    ..setAppPrivacyTextAlignment = _$enumDecodeNullable(
        _$iOSTextAlignmentEnumMap, json['setAppPrivacyTextAlignment'])
    ..setPrivacySmhHidden = json['setPrivacySmhHidden'] as bool
    ..setAppPrivacyLineSpacing = json['setAppPrivacyLineSpacing'] as num
    ..setAppPrivacyNeedSizeToFit = json['setAppPrivacyNeedSizeToFit'] as bool
    ..setAppPrivacyLineFragmentPadding =
        json['setAppPrivacyLineFragmentPadding'] as num
    ..setAppPrivacyAbbreviatedName =
        json['setAppPrivacyAbbreviatedName'] as String
    ..setAppPrivacyFirst =
        (json['setAppPrivacyFirst'] as List)?.map((e) => e as String)?.toList()
    ..setAppPrivacySecond =
        (json['setAppPrivacySecond'] as List)?.map((e) => e as String)?.toList()
    ..setAppPrivacyThird =
        (json['setAppPrivacyThird'] as List)?.map((e) => e as String)?.toList()
    ..setAppPrivacyNormalDesTextFirst =
        json['setAppPrivacyNormalDesTextFirst'] as String
    ..setAppPrivacyNormalDesTextSecond =
        json['setAppPrivacyNormalDesTextSecond'] as String
    ..setAppPrivacyNormalDesTextThird =
        json['setAppPrivacyNormalDesTextThird'] as String
    ..setAppPrivacyNormalDesTextFourth =
        json['setAppPrivacyNormalDesTextFourth'] as String
    ..setAppPrivacyNormalDesTextLast =
        json['setAppPrivacyNormalDesTextLast'] as String
    ..setOperatorPrivacyAtLast = json['setOperatorPrivacyAtLast'] as bool
    ..setPrivacyNavTextColor = json['setPrivacyNavTextColor'] as String
    ..setPrivacyNavTextSize = json['setPrivacyNavTextSize'] as num
    ..setPrivacyNavReturnImgPath = json['setPrivacyNavReturnImgPath'] as String
    ..setAppPrivacyWebPreferredStatusBarStyle = _$enumDecodeNullable(
        _$iOSStatusBarStyleEnumMap,
        json['setAppPrivacyWebPreferredStatusBarStyle'])
    ..setAppPrivacyWebNavigationBarStyle = _$enumDecodeNullable(
        _$iOSBarStyleEnumMap, json['setAppPrivacyWebNavigationBarStyle'])
    ..setAppPrivacyWebNavigationTintColor =
        json['setAppPrivacyWebNavigationTintColor'] as String
    ..setAppPrivacyWebNavigationBarTintColor =
        json['setAppPrivacyWebNavigationBarTintColor'] as String
    ..setAppPrivacyWebNavigationBackgroundImage =
        json['setAppPrivacyWebNavigationBackgroundImage'] as String
    ..setAppPrivacyWebNavigationShadowImage =
        json['setAppPrivacyWebNavigationShadowImage'] as String
    ..setSloganTextSize = json['setSloganTextSize'] as num
    ..setSloganTextBold = json['setSloganTextBold'] as bool
    ..setSloganTextColor = json['setSloganTextColor'] as String
    ..setSlogaTextAlignment =
        _$enumDecodeNullable(_$iOSTextAlignmentEnumMap, json['setSlogaTextAlignment'])
    ..setShanYanSloganTextSize = json['setShanYanSloganTextSize'] as num
    ..setShanYanSloganTextBold = json['setShanYanSloganTextBold'] as bool
    ..setShanYanSloganTextColor = json['setShanYanSloganTextColor'] as String
    ..setShanYanSlogaTextAlignment = _$enumDecodeNullable(_$iOSTextAlignmentEnumMap, json['setShanYanSlogaTextAlignment'])
    ..setShanYanSloganHidden = json['setShanYanSloganHidden'] as bool
    ..setCheckBoxHidden = json['setCheckBoxHidden'] as bool
    ..setPrivacyState = json['setPrivacyState'] as bool
    ..setCheckBoxWH = (json['setCheckBoxWH'] as List)?.map((e) => e as num)?.toList()
    ..setCheckBoxImageEdgeInsets = (json['setCheckBoxImageEdgeInsets'] as List)?.map((e) => e as num)?.toList()
    ..setCheckBoxVerticalAlignmentToAppPrivacyTop = json['setCheckBoxVerticalAlignmentToAppPrivacyTop'] as bool
    ..setCheckBoxVerticalAlignmentToAppPrivacyCenterY = json['setCheckBoxVerticalAlignmentToAppPrivacyCenterY'] as bool
    ..setUncheckedImgPath = json['setUncheckedImgPath'] as String
    ..setCheckedImgPath = json['setCheckedImgPath'] as String
    ..setLoadingCornerRadius = json['setLoadingCornerRadius'] as num
    ..setLoadingBackgroundColor = json['setLoadingBackgroundColor'] as String
    ..setLoadingTintColor = json['setLoadingTintColor'] as String
    ..setShouldAutorotate = json['setShouldAutorotate'] as bool
    ..supportedInterfaceOrientations = _$enumDecodeNullable(_$iOSInterfaceOrientationMaskEnumMap, json['supportedInterfaceOrientations'])
    ..preferredInterfaceOrientationForPresentation = _$enumDecodeNullable(_$iOSInterfaceOrientationEnumMap, json['preferredInterfaceOrientationForPresentation'])
    ..setAuthTypeUseWindow = json['setAuthTypeUseWindow'] as bool
    ..setAuthWindowCornerRadius = json['setAuthWindowCornerRadius'] as num
    ..setAuthWindowModalTransitionStyle = _$enumDecodeNullable(_$iOSModalTransitionStyleEnumMap, json['setAuthWindowModalTransitionStyle'])
    ..setAuthWindowModalPresentationStyle = _$enumDecodeNullable(_$iOSModalPresentationStyleEnumMap, json['setAuthWindowModalPresentationStyle'])
    ..setAppPrivacyWebModalPresentationStyle = _$enumDecodeNullable(_$iOSModalPresentationStyleEnumMap, json['setAppPrivacyWebModalPresentationStyle'])
    ..setAuthWindowOverrideUserInterfaceStyle = _$enumDecodeNullable(_$iOSUserInterfaceStyleEnumMap, json['setAuthWindowOverrideUserInterfaceStyle'])
    ..setAuthWindowPresentingAnimate = json['setAuthWindowPresentingAnimate'] as bool;
}

Map<String, dynamic> _$ShanYanUIConfigIOSToJson(ShanYanUIConfigIOS instance) =>
    <String, dynamic>{
      'isFinish': instance.isFinish,
      'setAuthBGImgPath': instance.setAuthBGImgPath,
      'setPreferredStatusBarStyle':
          _$iOSStatusBarStyleEnumMap[instance.setPreferredStatusBarStyle],
      'setStatusBarHidden': instance.setStatusBarHidden,
      'setAuthNavHidden': instance.setAuthNavHidden,
      'setNavigationBarStyle':
          _$iOSBarStyleEnumMap[instance.setNavigationBarStyle],
      'setAuthNavTransparent': instance.setAuthNavTransparent,
      'setNavText': instance.setNavText,
      'setNavTextColor': instance.setNavTextColor,
      'setNavTextSize': instance.setNavTextSize,
      'setNavReturnImgPath': instance.setNavReturnImgPath,
      'setNavReturnImgHidden': instance.setNavReturnImgHidden,
      'setNavBackBtnAlimentRight': instance.setNavBackBtnAlimentRight,
      'setNavigationBottomLineHidden': instance.setNavigationBottomLineHidden,
      'setNavigationTintColor': instance.setNavigationTintColor,
      'setNavigationBarTintColor': instance.setNavigationBarTintColor,
      'setNavigationBackgroundImage': instance.setNavigationBackgroundImage,
      'setNavigationShadowImage': instance.setNavigationShadowImage,
      'setLogoImgPath': instance.setLogoImgPath,
      'setLogoCornerRadius': instance.setLogoCornerRadius,
      'setLogoHidden': instance.setLogoHidden,
      'setNumberColor': instance.setNumberColor,
      'setNumberSize': instance.setNumberSize,
      'setNumberBold': instance.setNumberBold,
      'setNumberTextAlignment':
          _$iOSTextAlignmentEnumMap[instance.setNumberTextAlignment],
      'setLogBtnText': instance.setLogBtnText,
      'setLogBtnTextColor': instance.setLogBtnTextColor,
      'setLoginBtnTextSize': instance.setLoginBtnTextSize,
      'setLoginBtnTextBold': instance.setLoginBtnTextBold,
      'setLoginBtnBgColor': instance.setLoginBtnBgColor,
      'setLoginBtnNormalBgImage': instance.setLoginBtnNormalBgImage,
      'setLoginBtnHightLightBgImage': instance.setLoginBtnHightLightBgImage,
      'setLoginBtnDisabledBgImage': instance.setLoginBtnDisabledBgImage,
      'setLoginBtnBorderColor': instance.setLoginBtnBorderColor,
      'setLoginBtnCornerRadius': instance.setLoginBtnCornerRadius,
      'setLoginBtnBorderWidth': instance.setLoginBtnBorderWidth,
      'setAppPrivacyColor': instance.setAppPrivacyColor,
      'setPrivacyTextSize': instance.setPrivacyTextSize,
      'setPrivacyTextBold': instance.setPrivacyTextBold,
      'setAppPrivacyTextAlignment':
          _$iOSTextAlignmentEnumMap[instance.setAppPrivacyTextAlignment],
      'setPrivacySmhHidden': instance.setPrivacySmhHidden,
      'setAppPrivacyLineSpacing': instance.setAppPrivacyLineSpacing,
      'setAppPrivacyNeedSizeToFit': instance.setAppPrivacyNeedSizeToFit,
      'setAppPrivacyLineFragmentPadding':
          instance.setAppPrivacyLineFragmentPadding,
      'setAppPrivacyAbbreviatedName': instance.setAppPrivacyAbbreviatedName,
      'setAppPrivacyFirst': instance.setAppPrivacyFirst,
      'setAppPrivacySecond': instance.setAppPrivacySecond,
      'setAppPrivacyThird': instance.setAppPrivacyThird,
      'setAppPrivacyNormalDesTextFirst':
          instance.setAppPrivacyNormalDesTextFirst,
      'setAppPrivacyNormalDesTextSecond':
          instance.setAppPrivacyNormalDesTextSecond,
      'setAppPrivacyNormalDesTextThird':
          instance.setAppPrivacyNormalDesTextThird,
      'setAppPrivacyNormalDesTextFourth':
          instance.setAppPrivacyNormalDesTextFourth,
      'setAppPrivacyNormalDesTextLast': instance.setAppPrivacyNormalDesTextLast,
      'setOperatorPrivacyAtLast': instance.setOperatorPrivacyAtLast,
      'setPrivacyNavTextColor': instance.setPrivacyNavTextColor,
      'setPrivacyNavTextSize': instance.setPrivacyNavTextSize,
      'setPrivacyNavReturnImgPath': instance.setPrivacyNavReturnImgPath,
      'setAppPrivacyWebPreferredStatusBarStyle': _$iOSStatusBarStyleEnumMap[
          instance.setAppPrivacyWebPreferredStatusBarStyle],
      'setAppPrivacyWebNavigationBarStyle':
          _$iOSBarStyleEnumMap[instance.setAppPrivacyWebNavigationBarStyle],
      'setAppPrivacyWebNavigationTintColor':
          instance.setAppPrivacyWebNavigationTintColor,
      'setAppPrivacyWebNavigationBarTintColor':
          instance.setAppPrivacyWebNavigationBarTintColor,
      'setAppPrivacyWebNavigationBackgroundImage':
          instance.setAppPrivacyWebNavigationBackgroundImage,
      'setAppPrivacyWebNavigationShadowImage':
          instance.setAppPrivacyWebNavigationShadowImage,
      'setSloganTextSize': instance.setSloganTextSize,
      'setSloganTextBold': instance.setSloganTextBold,
      'setSloganTextColor': instance.setSloganTextColor,
      'setSlogaTextAlignment':
          _$iOSTextAlignmentEnumMap[instance.setSlogaTextAlignment],
      'setShanYanSloganTextSize': instance.setShanYanSloganTextSize,
      'setShanYanSloganTextBold': instance.setShanYanSloganTextBold,
      'setShanYanSloganTextColor': instance.setShanYanSloganTextColor,
      'setShanYanSlogaTextAlignment':
          _$iOSTextAlignmentEnumMap[instance.setShanYanSlogaTextAlignment],
      'setShanYanSloganHidden': instance.setShanYanSloganHidden,
      'setCheckBoxHidden': instance.setCheckBoxHidden,
      'setPrivacyState': instance.setPrivacyState,
      'setCheckBoxWH': instance.setCheckBoxWH,
      'setCheckBoxImageEdgeInsets': instance.setCheckBoxImageEdgeInsets,
      'setCheckBoxVerticalAlignmentToAppPrivacyTop':
          instance.setCheckBoxVerticalAlignmentToAppPrivacyTop,
      'setCheckBoxVerticalAlignmentToAppPrivacyCenterY':
          instance.setCheckBoxVerticalAlignmentToAppPrivacyCenterY,
      'setUncheckedImgPath': instance.setUncheckedImgPath,
      'setCheckedImgPath': instance.setCheckedImgPath,
      'setLoadingCornerRadius': instance.setLoadingCornerRadius,
      'setLoadingBackgroundColor': instance.setLoadingBackgroundColor,
      'setLoadingTintColor': instance.setLoadingTintColor,
      'setShouldAutorotate': instance.setShouldAutorotate,
      'supportedInterfaceOrientations': _$iOSInterfaceOrientationMaskEnumMap[
          instance.supportedInterfaceOrientations],
      'preferredInterfaceOrientationForPresentation':
          _$iOSInterfaceOrientationEnumMap[
              instance.preferredInterfaceOrientationForPresentation],
      'setAuthTypeUseWindow': instance.setAuthTypeUseWindow,
      'setAuthWindowCornerRadius': instance.setAuthWindowCornerRadius,
      'setAuthWindowModalTransitionStyle': _$iOSModalTransitionStyleEnumMap[
          instance.setAuthWindowModalTransitionStyle],
      'setAuthWindowModalPresentationStyle': _$iOSModalPresentationStyleEnumMap[
          instance.setAuthWindowModalPresentationStyle],
      'setAppPrivacyWebModalPresentationStyle':
          _$iOSModalPresentationStyleEnumMap[
              instance.setAppPrivacyWebModalPresentationStyle],
      'setAuthWindowOverrideUserInterfaceStyle': _$iOSUserInterfaceStyleEnumMap[
          instance.setAuthWindowOverrideUserInterfaceStyle],
      'setAuthWindowPresentingAnimate': instance.setAuthWindowPresentingAnimate,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$iOSStatusBarStyleEnumMap = {
  iOSStatusBarStyle.styleDefault: 'styleDefault',
  iOSStatusBarStyle.styleLightContent: 'styleLightContent',
  iOSStatusBarStyle.styleDarkContent: 'styleDarkContent',
};

const _$iOSBarStyleEnumMap = {
  iOSBarStyle.styleDefault: 'styleDefault',
  iOSBarStyle.styleBlack: 'styleBlack',
};

const _$iOSTextAlignmentEnumMap = {
  iOSTextAlignment.center: 'center',
  iOSTextAlignment.left: 'left',
  iOSTextAlignment.right: 'right',
  iOSTextAlignment.justified: 'justified',
  iOSTextAlignment.natural: 'natural',
};

const _$iOSInterfaceOrientationMaskEnumMap = {
  iOSInterfaceOrientationMask.portrait: 'portrait',
  iOSInterfaceOrientationMask.landscapeLeft: 'landscapeLeft',
  iOSInterfaceOrientationMask.landscapeRight: 'landscapeRight',
  iOSInterfaceOrientationMask.portraitUpsideDown: 'portraitUpsideDown',
  iOSInterfaceOrientationMask.landscape: 'landscape',
  iOSInterfaceOrientationMask.all: 'all',
  iOSInterfaceOrientationMask.allButUpsideDown: 'allButUpsideDown',
};

const _$iOSInterfaceOrientationEnumMap = {
  iOSInterfaceOrientation.portrait: 'portrait',
  iOSInterfaceOrientation.portraitUpsideDown: 'portraitUpsideDown',
  iOSInterfaceOrientation.landscapeLeft: 'landscapeLeft',
  iOSInterfaceOrientation.landscapeRight: 'landscapeRight',
  iOSInterfaceOrientation.unknown: 'unknown',
};

const _$iOSModalTransitionStyleEnumMap = {
  iOSModalTransitionStyle.coverVertical: 'coverVertical',
  iOSModalTransitionStyle.flipHorizontal: 'flipHorizontal',
  iOSModalTransitionStyle.crossDissolve: 'crossDissolve',
};

const _$iOSModalPresentationStyleEnumMap = {
  iOSModalPresentationStyle.fullScreen: 'fullScreen',
  iOSModalPresentationStyle.overFullScreen: 'overFullScreen',
  iOSModalPresentationStyle.automatic: 'automatic',
};

const _$iOSUserInterfaceStyleEnumMap = {
  iOSUserInterfaceStyle.unspecified: 'unspecified',
  iOSUserInterfaceStyle.light: 'light',
  iOSUserInterfaceStyle.dark: 'dark',
};

ClOrientationLayOutIOS _$ClOrientationLayOutIOSFromJson(
    Map<String, dynamic> json) {
  return ClOrientationLayOutIOS()
    ..setLogoWidth = json['setLogoWidth'] as num
    ..setLogoHeight = json['setLogoHeight'] as num
    ..setLogoLeft = json['setLogoLeft'] as num
    ..setLogoRight = json['setLogoRight'] as num
    ..setLogoTop = json['setLogoTop'] as num
    ..setLogoBottom = json['setLogoBottom'] as num
    ..setLogoCenterX = json['setLogoCenterX'] as num
    ..setLogoCenterY = json['setLogoCenterY'] as num
    ..setNumFieldWidth = json['setNumFieldWidth'] as num
    ..setNumFieldHeight = json['setNumFieldHeight'] as num
    ..setNumFieldLeft = json['setNumFieldLeft'] as num
    ..setNumFieldRight = json['setNumFieldRight'] as num
    ..setNumFieldTop = json['setNumFieldTop'] as num
    ..setNumFieldBottom = json['setNumFieldBottom'] as num
    ..setNumFieldCenterX = json['setNumFieldCenterX'] as num
    ..setNumFieldCenterY = json['setNumFieldCenterY'] as num
    ..setLogBtnHeight = json['setLogBtnHeight'] as num
    ..setLogBtnWidth = json['setLogBtnWidth'] as num
    ..setLogBtnLeft = json['setLogBtnLeft'] as num
    ..setLogBtnRight = json['setLogBtnRight'] as num
    ..setLogBtnTop = json['setLogBtnTop'] as num
    ..setLogBtnBottom = json['setLogBtnBottom'] as num
    ..setLogBtnCenterX = json['setLogBtnCenterX'] as num
    ..setLogBtnCenterY = json['setLogBtnCenterY'] as num
    ..setPrivacyHeight = json['setPrivacyHeight'] as num
    ..setPrivacyWidth = json['setPrivacyWidth'] as num
    ..setPrivacyLeft = json['setPrivacyLeft'] as num
    ..setPrivacyRight = json['setPrivacyRight'] as num
    ..setPrivacyTop = json['setPrivacyTop'] as num
    ..setPrivacyBottom = json['setPrivacyBottom'] as num
    ..setPrivacyCenterX = json['setPrivacyCenterX'] as num
    ..setPrivacyCenterY = json['setPrivacyCenterY'] as num
    ..setSloganHeight = json['setSloganHeight'] as num
    ..setSloganWidth = json['setSloganWidth'] as num
    ..setSloganLeft = json['setSloganLeft'] as num
    ..setSloganRight = json['setSloganRight'] as num
    ..setSloganTop = json['setSloganTop'] as num
    ..setSloganBottom = json['setSloganBottom'] as num
    ..setSloganCenterX = json['setSloganCenterX'] as num
    ..setSloganCenterY = json['setSloganCenterY'] as num
    ..setShanYanSloganHeight = json['setShanYanSloganHeight'] as num
    ..setShanYanSloganWidth = json['setShanYanSloganWidth'] as num
    ..setShanYanSloganLeft = json['setShanYanSloganLeft'] as num
    ..setShanYanSloganRight = json['setShanYanSloganRight'] as num
    ..setShanYanSloganTop = json['setShanYanSloganTop'] as num
    ..setShanYanSloganBottom = json['setShanYanSloganBottom'] as num
    ..setShanYanSloganCenterX = json['setShanYanSloganCenterX'] as num
    ..setShanYanSloganCenterY = json['setShanYanSloganCenterY'] as num;
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
