// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shanYanUIConfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShanYanUIConfig _$ShanYanUIConfigFromJson(Map<String, dynamic> json) =>
    ShanYanUIConfig()
      ..ios = ShanYanUIConfigIOS.fromJson(json['ios'] as Map<String, dynamic>)
      ..androidPortrait = ShanYanUIConfigAndroid.fromJson(
          json['androidPortrait'] as Map<String, dynamic>)
      ..androidLandscape = ShanYanUIConfigAndroid.fromJson(
          json['androidLandscape'] as Map<String, dynamic>);

Map<String, dynamic> _$ShanYanUIConfigToJson(ShanYanUIConfig instance) =>
    <String, dynamic>{
      'ios': instance.ios.toJson(),
      'androidPortrait': instance.androidPortrait.toJson(),
      'androidLandscape': instance.androidLandscape.toJson(),
    };

ShanYanUIConfigIOS _$ShanYanUIConfigIOSFromJson(Map<String, dynamic> json) =>
    ShanYanUIConfigIOS()
      ..isFinish = json['isFinish'] as bool?
      ..setAuthBGImgPath = json['setAuthBGImgPath'] as String?
      ..setAuthBGVedioPath = json['setAuthBGVedioPath'] as String?
      ..setPreferredStatusBarStyle = $enumDecodeNullable(
          _$iOSStatusBarStyleEnumMap, json['setPreferredStatusBarStyle'])
      ..setStatusBarHidden = json['setStatusBarHidden'] as bool?
      ..setAuthNavHidden = json['setAuthNavHidden'] as bool?
      ..setNavigationBarStyle = $enumDecodeNullable(
          _$iOSBarStyleEnumMap, json['setNavigationBarStyle'])
      ..setAuthNavTransparent = json['setAuthNavTransparent'] as bool?
      ..setNavText = json['setNavText'] as String?
      ..setNavTextColor = json['setNavTextColor'] as String?
      ..setNavTextSize = (json['setNavTextSize'] as num?)?.toInt()
      ..setNavReturnImgPath = json['setNavReturnImgPath'] as String?
      ..setNavReturnImgHidden = json['setNavReturnImgHidden'] as bool?
      ..setBackPressedAvailable = json['setBackPressedAvailable'] as bool?
      ..setFitsSystemWindows = json['setFitsSystemWindows'] as bool?
      ..setNavBackBtnAlimentRight = json['setNavBackBtnAlimentRight'] as bool?
      ..setNavigationBottomLineHidden =
          json['setNavigationBottomLineHidden'] as bool?
      ..setNavigationTintColor = json['setNavigationTintColor'] as String?
      ..setNavigationBarTintColor = json['setNavigationBarTintColor'] as String?
      ..setNavigationBackgroundImage =
          json['setNavigationBackgroundImage'] as String?
      ..setNavigationShadowImage = json['setNavigationShadowImage'] as String?
      ..setLogoImgPath = json['setLogoImgPath'] as String?
      ..setLogoCornerRadius = json['setLogoCornerRadius'] as num?
      ..setLogoHidden = json['setLogoHidden'] as bool?
      ..setNumberColor = json['setNumberColor'] as String?
      ..setNumberSize = json['setNumberSize'] as num?
      ..setNumberBold = json['setNumberBold'] as bool?
      ..setNumberTextAlignment = $enumDecodeNullable(
          _$iOSTextAlignmentEnumMap, json['setNumberTextAlignment'])
      ..setLogBtnText = json['setLogBtnText'] as String?
      ..setLogBtnTextColor = json['setLogBtnTextColor'] as String?
      ..setLoginBtnTextSize = json['setLoginBtnTextSize'] as num?
      ..setLoginBtnTextBold = json['setLoginBtnTextBold'] as bool?
      ..setLoginBtnBgColor = json['setLoginBtnBgColor'] as String?
      ..setLoginBtnNormalBgImage = json['setLoginBtnNormalBgImage'] as String?
      ..setLoginBtnHightLightBgImage =
          json['setLoginBtnHightLightBgImage'] as String?
      ..setLoginBtnDisabledBgImage =
          json['setLoginBtnDisabledBgImage'] as String?
      ..setLoginBtnBorderColor = json['setLoginBtnBorderColor'] as String?
      ..setLoginBtnCornerRadius = json['setLoginBtnCornerRadius'] as num?
      ..setLoginBtnBorderWidth = json['setLoginBtnBorderWidth'] as num?
      ..setAppPrivacyColor = (json['setAppPrivacyColor'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setPrivacyTextSize = json['setPrivacyTextSize'] as num?
      ..setPrivacyWidth = json['setPrivacyWidth'] as num?
      ..setPrivacyTextBold = json['setPrivacyTextBold'] as bool?
      ..setAppPrivacyTextAlignment = $enumDecodeNullable(
          _$iOSTextAlignmentEnumMap, json['setAppPrivacyTextAlignment'])
      ..setPrivacySmhHidden = json['setPrivacySmhHidden'] as bool?
      ..setAppPrivacyLineSpacing = json['setAppPrivacyLineSpacing'] as num?
      ..setAppPrivacyNeedSizeToFit = json['setAppPrivacyNeedSizeToFit'] as bool?
      ..setAppPrivacyAbbreviatedName =
          json['setAppPrivacyAbbreviatedName'] as String?
      ..setAppPrivacyFirst = (json['setAppPrivacyFirst'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setAppPrivacySecond = (json['setAppPrivacySecond'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setAppPrivacyThird = (json['setAppPrivacyThird'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setAppPrivacyNormalDesTextFirst =
          json['setAppPrivacyNormalDesTextFirst'] as String?
      ..setAppPrivacyNormalDesTextSecond =
          json['setAppPrivacyNormalDesTextSecond'] as String?
      ..setAppPrivacyNormalDesTextThird =
          json['setAppPrivacyNormalDesTextThird'] as String?
      ..setAppPrivacyNormalDesTextFourth =
          json['setAppPrivacyNormalDesTextFourth'] as String?
      ..setAppPrivacyNormalDesTextLast =
          json['setAppPrivacyNormalDesTextLast'] as String?
      ..morePrivacy = (json['morePrivacy'] as List<dynamic>?)
          ?.map((e) => ConfigPrivacyBean.fromJson(e as Map<String, dynamic>))
          .toList()
      ..setCheckBoxTipMsg = json['setCheckBoxTipMsg'] as String?
      ..setCheckBoxTipDisable = json['setCheckBoxTipDisable'] as bool?
      ..setOperatorPrivacyAtLast = json['setOperatorPrivacyAtLast'] as bool?
      ..setPrivacyNameUnderline = json['setPrivacyNameUnderline'] as bool?
      ..setPrivacyActivityEnabled = json['setPrivacyActivityEnabled'] as bool?
      ..setPrivacyGravityHorizontalCenter =
          json['setPrivacyGravityHorizontalCenter'] as bool?
      ..setPrivacyNavTextColor = json['setPrivacyNavTextColor'] as String?
      ..setPrivacyNavTextSize = json['setPrivacyNavTextSize'] as num?
      ..setPrivacyNavReturnImgPath =
          json['setPrivacyNavReturnImgPath'] as String?
      ..setAppPrivacyWebPreferredStatusBarStyle = $enumDecodeNullable(
          _$iOSStatusBarStyleEnumMap,
          json['setAppPrivacyWebPreferredStatusBarStyle'])
      ..setAppPrivacyWebNavigationBarStyle = $enumDecodeNullable(
          _$iOSBarStyleEnumMap, json['setAppPrivacyWebNavigationBarStyle'])
      ..setAppPrivacyWebNavigationTintColor =
          json['setAppPrivacyWebNavigationTintColor'] as String?
      ..setAppPrivacyWebNavigationBarTintColor =
          json['setAppPrivacyWebNavigationBarTintColor'] as String?
      ..setAppPrivacyWebNavigationBackgroundImage =
          json['setAppPrivacyWebNavigationBackgroundImage'] as String?
      ..setAppPrivacyWebNavigationShadowImage =
          json['setAppPrivacyWebNavigationShadowImage'] as String?
      ..setSloganTextSize = json['setSloganTextSize'] as num?
      ..setSloganTextBold = json['setSloganTextBold'] as bool?
      ..setSloganTextColor = json['setSloganTextColor'] as String?
      ..setSloganTextAlignment = $enumDecodeNullable(
          _$iOSTextAlignmentEnumMap, json['setSloganTextAlignment'])
      ..setSloganTextHidden = json['setSloganTextHidden'] as bool?
      ..setShanYanSloganTextSize = json['setShanYanSloganTextSize'] as num?
      ..setShanYanSloganTextBold = json['setShanYanSloganTextBold'] as bool?
      ..setShanYanSloganTextColor = json['setShanYanSloganTextColor'] as String?
      ..setShanYanSloganTextAlignment = $enumDecodeNullable(
          _$iOSTextAlignmentEnumMap, json['setShanYanSloganTextAlignment'])
      ..setShanYanSloganHidden = json['setShanYanSloganHidden'] as bool?
      ..setCheckBoxHidden = json['setCheckBoxHidden'] as bool?
      ..setPrivacyState = json['setPrivacyState'] as bool?
      ..setCheckBoxWH = (json['setCheckBoxWH'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList()
      ..setCheckBoxImageEdgeInsets =
          (json['setCheckBoxImageEdgeInsets'] as List<dynamic>?)
              ?.map((e) => e as num)
              .toList()
      ..setCheckBoxVerticalAlignmentToAppPrivacyTop =
          json['setCheckBoxVerticalAlignmentToAppPrivacyTop'] as bool?
      ..setCheckBoxVerticalAlignmentToAppPrivacyCenterY =
          json['setCheckBoxVerticalAlignmentToAppPrivacyCenterY'] as bool?
      ..setUncheckedImgPath = json['setUncheckedImgPath'] as String?
      ..setCheckedImgPath = json['setCheckedImgPath'] as String?
      ..setLoadingSize = (json['setLoadingSize'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList()
      ..setLoadingCornerRadius = json['setLoadingCornerRadius'] as num?
      ..setLoadingBackgroundColor = json['setLoadingBackgroundColor'] as String?
      ..setLoadingTintColor = json['setLoadingTintColor'] as String?
      ..widgets = (json['widgets'] as List<dynamic>?)
          ?.map(
              (e) => ShanYanCustomWidgetIOS.fromJson(e as Map<String, dynamic>))
          .toList()
      ..setShouldAutorotate = json['setShouldAutorotate'] as bool?
      ..supportedInterfaceOrientations = $enumDecodeNullable(
          _$iOSInterfaceOrientationMaskEnumMap,
          json['supportedInterfaceOrientations'])
      ..preferredInterfaceOrientationForPresentation = $enumDecodeNullable(
          _$iOSInterfaceOrientationEnumMap,
          json['preferredInterfaceOrientationForPresentation'])
      ..setAuthTypeUseWindow = json['setAuthTypeUseWindow'] as bool?
      ..setAuthWindowCornerRadius = json['setAuthWindowCornerRadius'] as num?
      ..setAuthWindowModalTransitionStyle = $enumDecodeNullable(
          _$iOSModalTransitionStyleEnumMap,
          json['setAuthWindowModalTransitionStyle'])
      ..setAuthWindowModalPresentationStyle = $enumDecodeNullable(
          _$iOSModalPresentationStyleEnumMap,
          json['setAuthWindowModalPresentationStyle'])
      ..setAppPrivacyWebModalPresentationStyle = $enumDecodeNullable(
          _$iOSModalPresentationStyleEnumMap,
          json['setAppPrivacyWebModalPresentationStyle'])
      ..setAuthWindowOverrideUserInterfaceStyle = $enumDecodeNullable(
          _$iOSUserInterfaceStyleEnumMap,
          json['setAuthWindowOverrideUserInterfaceStyle'])
      ..setAuthWindowPresentingAnimate =
          json['setAuthWindowPresentingAnimate'] as bool?
      ..layOutPortrait = ClOrientationLayOutIOS.fromJson(
          json['layOutPortrait'] as Map<String, dynamic>)
      ..layOutLandscape = ClOrientationLayOutIOS.fromJson(
          json['layOutLandscape'] as Map<String, dynamic>);

Map<String, dynamic> _$ShanYanUIConfigIOSToJson(ShanYanUIConfigIOS instance) =>
    <String, dynamic>{
      if (instance.isFinish case final value?) 'isFinish': value,
      if (instance.setAuthBGImgPath case final value?)
        'setAuthBGImgPath': value,
      if (instance.setAuthBGVedioPath case final value?)
        'setAuthBGVedioPath': value,
      if (_$iOSStatusBarStyleEnumMap[instance.setPreferredStatusBarStyle]
          case final value?)
        'setPreferredStatusBarStyle': value,
      if (instance.setStatusBarHidden case final value?)
        'setStatusBarHidden': value,
      if (instance.setAuthNavHidden case final value?)
        'setAuthNavHidden': value,
      if (_$iOSBarStyleEnumMap[instance.setNavigationBarStyle]
          case final value?)
        'setNavigationBarStyle': value,
      if (instance.setAuthNavTransparent case final value?)
        'setAuthNavTransparent': value,
      if (instance.setNavText case final value?) 'setNavText': value,
      if (instance.setNavTextColor case final value?) 'setNavTextColor': value,
      if (instance.setNavTextSize case final value?) 'setNavTextSize': value,
      if (instance.setNavReturnImgPath case final value?)
        'setNavReturnImgPath': value,
      if (instance.setNavReturnImgHidden case final value?)
        'setNavReturnImgHidden': value,
      if (instance.setBackPressedAvailable case final value?)
        'setBackPressedAvailable': value,
      if (instance.setFitsSystemWindows case final value?)
        'setFitsSystemWindows': value,
      if (instance.setNavBackBtnAlimentRight case final value?)
        'setNavBackBtnAlimentRight': value,
      if (instance.setNavigationBottomLineHidden case final value?)
        'setNavigationBottomLineHidden': value,
      if (instance.setNavigationTintColor case final value?)
        'setNavigationTintColor': value,
      if (instance.setNavigationBarTintColor case final value?)
        'setNavigationBarTintColor': value,
      if (instance.setNavigationBackgroundImage case final value?)
        'setNavigationBackgroundImage': value,
      if (instance.setNavigationShadowImage case final value?)
        'setNavigationShadowImage': value,
      if (instance.setLogoImgPath case final value?) 'setLogoImgPath': value,
      if (instance.setLogoCornerRadius case final value?)
        'setLogoCornerRadius': value,
      if (instance.setLogoHidden case final value?) 'setLogoHidden': value,
      if (instance.setNumberColor case final value?) 'setNumberColor': value,
      if (instance.setNumberSize case final value?) 'setNumberSize': value,
      if (instance.setNumberBold case final value?) 'setNumberBold': value,
      if (_$iOSTextAlignmentEnumMap[instance.setNumberTextAlignment]
          case final value?)
        'setNumberTextAlignment': value,
      if (instance.setLogBtnText case final value?) 'setLogBtnText': value,
      if (instance.setLogBtnTextColor case final value?)
        'setLogBtnTextColor': value,
      if (instance.setLoginBtnTextSize case final value?)
        'setLoginBtnTextSize': value,
      if (instance.setLoginBtnTextBold case final value?)
        'setLoginBtnTextBold': value,
      if (instance.setLoginBtnBgColor case final value?)
        'setLoginBtnBgColor': value,
      if (instance.setLoginBtnNormalBgImage case final value?)
        'setLoginBtnNormalBgImage': value,
      if (instance.setLoginBtnHightLightBgImage case final value?)
        'setLoginBtnHightLightBgImage': value,
      if (instance.setLoginBtnDisabledBgImage case final value?)
        'setLoginBtnDisabledBgImage': value,
      if (instance.setLoginBtnBorderColor case final value?)
        'setLoginBtnBorderColor': value,
      if (instance.setLoginBtnCornerRadius case final value?)
        'setLoginBtnCornerRadius': value,
      if (instance.setLoginBtnBorderWidth case final value?)
        'setLoginBtnBorderWidth': value,
      if (instance.setAppPrivacyColor case final value?)
        'setAppPrivacyColor': value,
      if (instance.setPrivacyTextSize case final value?)
        'setPrivacyTextSize': value,
      if (instance.setPrivacyWidth case final value?) 'setPrivacyWidth': value,
      if (instance.setPrivacyTextBold case final value?)
        'setPrivacyTextBold': value,
      if (_$iOSTextAlignmentEnumMap[instance.setAppPrivacyTextAlignment]
          case final value?)
        'setAppPrivacyTextAlignment': value,
      if (instance.setPrivacySmhHidden case final value?)
        'setPrivacySmhHidden': value,
      if (instance.setAppPrivacyLineSpacing case final value?)
        'setAppPrivacyLineSpacing': value,
      if (instance.setAppPrivacyNeedSizeToFit case final value?)
        'setAppPrivacyNeedSizeToFit': value,
      if (instance.setAppPrivacyAbbreviatedName case final value?)
        'setAppPrivacyAbbreviatedName': value,
      if (instance.setAppPrivacyFirst case final value?)
        'setAppPrivacyFirst': value,
      if (instance.setAppPrivacySecond case final value?)
        'setAppPrivacySecond': value,
      if (instance.setAppPrivacyThird case final value?)
        'setAppPrivacyThird': value,
      if (instance.setAppPrivacyNormalDesTextFirst case final value?)
        'setAppPrivacyNormalDesTextFirst': value,
      if (instance.setAppPrivacyNormalDesTextSecond case final value?)
        'setAppPrivacyNormalDesTextSecond': value,
      if (instance.setAppPrivacyNormalDesTextThird case final value?)
        'setAppPrivacyNormalDesTextThird': value,
      if (instance.setAppPrivacyNormalDesTextFourth case final value?)
        'setAppPrivacyNormalDesTextFourth': value,
      if (instance.setAppPrivacyNormalDesTextLast case final value?)
        'setAppPrivacyNormalDesTextLast': value,
      if (instance.morePrivacy?.map((e) => e.toJson()).toList()
          case final value?)
        'morePrivacy': value,
      if (instance.setCheckBoxTipMsg case final value?)
        'setCheckBoxTipMsg': value,
      if (instance.setCheckBoxTipDisable case final value?)
        'setCheckBoxTipDisable': value,
      if (instance.setOperatorPrivacyAtLast case final value?)
        'setOperatorPrivacyAtLast': value,
      if (instance.setPrivacyNameUnderline case final value?)
        'setPrivacyNameUnderline': value,
      if (instance.setPrivacyActivityEnabled case final value?)
        'setPrivacyActivityEnabled': value,
      if (instance.setPrivacyGravityHorizontalCenter case final value?)
        'setPrivacyGravityHorizontalCenter': value,
      if (instance.setPrivacyNavTextColor case final value?)
        'setPrivacyNavTextColor': value,
      if (instance.setPrivacyNavTextSize case final value?)
        'setPrivacyNavTextSize': value,
      if (instance.setPrivacyNavReturnImgPath case final value?)
        'setPrivacyNavReturnImgPath': value,
      if (_$iOSStatusBarStyleEnumMap[
              instance.setAppPrivacyWebPreferredStatusBarStyle]
          case final value?)
        'setAppPrivacyWebPreferredStatusBarStyle': value,
      if (_$iOSBarStyleEnumMap[instance.setAppPrivacyWebNavigationBarStyle]
          case final value?)
        'setAppPrivacyWebNavigationBarStyle': value,
      if (instance.setAppPrivacyWebNavigationTintColor case final value?)
        'setAppPrivacyWebNavigationTintColor': value,
      if (instance.setAppPrivacyWebNavigationBarTintColor case final value?)
        'setAppPrivacyWebNavigationBarTintColor': value,
      if (instance.setAppPrivacyWebNavigationBackgroundImage case final value?)
        'setAppPrivacyWebNavigationBackgroundImage': value,
      if (instance.setAppPrivacyWebNavigationShadowImage case final value?)
        'setAppPrivacyWebNavigationShadowImage': value,
      if (instance.setSloganTextSize case final value?)
        'setSloganTextSize': value,
      if (instance.setSloganTextBold case final value?)
        'setSloganTextBold': value,
      if (instance.setSloganTextColor case final value?)
        'setSloganTextColor': value,
      if (_$iOSTextAlignmentEnumMap[instance.setSloganTextAlignment]
          case final value?)
        'setSloganTextAlignment': value,
      if (instance.setSloganTextHidden case final value?)
        'setSloganTextHidden': value,
      if (instance.setShanYanSloganTextSize case final value?)
        'setShanYanSloganTextSize': value,
      if (instance.setShanYanSloganTextBold case final value?)
        'setShanYanSloganTextBold': value,
      if (instance.setShanYanSloganTextColor case final value?)
        'setShanYanSloganTextColor': value,
      if (_$iOSTextAlignmentEnumMap[instance.setShanYanSloganTextAlignment]
          case final value?)
        'setShanYanSloganTextAlignment': value,
      if (instance.setShanYanSloganHidden case final value?)
        'setShanYanSloganHidden': value,
      if (instance.setCheckBoxHidden case final value?)
        'setCheckBoxHidden': value,
      if (instance.setPrivacyState case final value?) 'setPrivacyState': value,
      if (instance.setCheckBoxWH case final value?) 'setCheckBoxWH': value,
      if (instance.setCheckBoxImageEdgeInsets case final value?)
        'setCheckBoxImageEdgeInsets': value,
      if (instance.setCheckBoxVerticalAlignmentToAppPrivacyTop
          case final value?)
        'setCheckBoxVerticalAlignmentToAppPrivacyTop': value,
      if (instance.setCheckBoxVerticalAlignmentToAppPrivacyCenterY
          case final value?)
        'setCheckBoxVerticalAlignmentToAppPrivacyCenterY': value,
      if (instance.setUncheckedImgPath case final value?)
        'setUncheckedImgPath': value,
      if (instance.setCheckedImgPath case final value?)
        'setCheckedImgPath': value,
      if (instance.setLoadingSize case final value?) 'setLoadingSize': value,
      if (instance.setLoadingCornerRadius case final value?)
        'setLoadingCornerRadius': value,
      if (instance.setLoadingBackgroundColor case final value?)
        'setLoadingBackgroundColor': value,
      if (instance.setLoadingTintColor case final value?)
        'setLoadingTintColor': value,
      if (instance.widgets?.map((e) => e.toJson()).toList() case final value?)
        'widgets': value,
      if (instance.setShouldAutorotate case final value?)
        'setShouldAutorotate': value,
      if (_$iOSInterfaceOrientationMaskEnumMap[
              instance.supportedInterfaceOrientations]
          case final value?)
        'supportedInterfaceOrientations': value,
      if (_$iOSInterfaceOrientationEnumMap[
              instance.preferredInterfaceOrientationForPresentation]
          case final value?)
        'preferredInterfaceOrientationForPresentation': value,
      if (instance.setAuthTypeUseWindow case final value?)
        'setAuthTypeUseWindow': value,
      if (instance.setAuthWindowCornerRadius case final value?)
        'setAuthWindowCornerRadius': value,
      if (_$iOSModalTransitionStyleEnumMap[
              instance.setAuthWindowModalTransitionStyle]
          case final value?)
        'setAuthWindowModalTransitionStyle': value,
      if (_$iOSModalPresentationStyleEnumMap[
              instance.setAuthWindowModalPresentationStyle]
          case final value?)
        'setAuthWindowModalPresentationStyle': value,
      if (_$iOSModalPresentationStyleEnumMap[
              instance.setAppPrivacyWebModalPresentationStyle]
          case final value?)
        'setAppPrivacyWebModalPresentationStyle': value,
      if (_$iOSUserInterfaceStyleEnumMap[
              instance.setAuthWindowOverrideUserInterfaceStyle]
          case final value?)
        'setAuthWindowOverrideUserInterfaceStyle': value,
      if (instance.setAuthWindowPresentingAnimate case final value?)
        'setAuthWindowPresentingAnimate': value,
      'layOutPortrait': instance.layOutPortrait.toJson(),
      'layOutLandscape': instance.layOutLandscape.toJson(),
    };

const _$iOSStatusBarStyleEnumMap = {
  iOSStatusBarStyle.styleDefault: 0,
  iOSStatusBarStyle.styleLightContent: 1,
  iOSStatusBarStyle.styleDarkContent: 2,
};

const _$iOSBarStyleEnumMap = {
  iOSBarStyle.styleDefault: 0,
  iOSBarStyle.styleBlack: 1,
};

const _$iOSTextAlignmentEnumMap = {
  iOSTextAlignment.center: 0,
  iOSTextAlignment.left: 1,
  iOSTextAlignment.right: 2,
  iOSTextAlignment.justified: 3,
  iOSTextAlignment.natural: 4,
};

const _$iOSInterfaceOrientationMaskEnumMap = {
  iOSInterfaceOrientationMask.portrait: 0,
  iOSInterfaceOrientationMask.landscapeLeft: 1,
  iOSInterfaceOrientationMask.landscapeRight: 2,
  iOSInterfaceOrientationMask.portraitUpsideDown: 3,
  iOSInterfaceOrientationMask.landscape: 4,
  iOSInterfaceOrientationMask.all: 5,
  iOSInterfaceOrientationMask.allButUpsideDown: 6,
};

const _$iOSInterfaceOrientationEnumMap = {
  iOSInterfaceOrientation.portrait: 0,
  iOSInterfaceOrientation.portraitUpsideDown: 1,
  iOSInterfaceOrientation.landscapeLeft: 2,
  iOSInterfaceOrientation.landscapeRight: 3,
  iOSInterfaceOrientation.unknown: 4,
};

const _$iOSModalTransitionStyleEnumMap = {
  iOSModalTransitionStyle.coverVertical: 0,
  iOSModalTransitionStyle.flipHorizontal: 1,
  iOSModalTransitionStyle.crossDissolve: 2,
};

const _$iOSModalPresentationStyleEnumMap = {
  iOSModalPresentationStyle.fullScreen: 0,
  iOSModalPresentationStyle.overFullScreen: 1,
  iOSModalPresentationStyle.automatic: 2,
};

const _$iOSUserInterfaceStyleEnumMap = {
  iOSUserInterfaceStyle.unspecified: 0,
  iOSUserInterfaceStyle.light: 1,
  iOSUserInterfaceStyle.dark: 2,
};

ClOrientationLayOutIOS _$ClOrientationLayOutIOSFromJson(
        Map<String, dynamic> json) =>
    ClOrientationLayOutIOS()
      ..setLogoWidth = json['setLogoWidth'] as num?
      ..setLogoHeight = json['setLogoHeight'] as num?
      ..setLogoLeft = json['setLogoLeft'] as num?
      ..setLogoRight = json['setLogoRight'] as num?
      ..setLogoTop = json['setLogoTop'] as num?
      ..setLogoBottom = json['setLogoBottom'] as num?
      ..setLogoCenterX = json['setLogoCenterX'] as num?
      ..setLogoCenterY = json['setLogoCenterY'] as num?
      ..setNumFieldWidth = json['setNumFieldWidth'] as num?
      ..setNumFieldHeight = json['setNumFieldHeight'] as num?
      ..setNumFieldLeft = json['setNumFieldLeft'] as num?
      ..setNumFieldRight = json['setNumFieldRight'] as num?
      ..setNumFieldTop = json['setNumFieldTop'] as num?
      ..setNumFieldBottom = json['setNumFieldBottom'] as num?
      ..setNumFieldCenterX = json['setNumFieldCenterX'] as num?
      ..setNumFieldCenterY = json['setNumFieldCenterY'] as num?
      ..setLogBtnHeight = json['setLogBtnHeight'] as num?
      ..setLogBtnWidth = json['setLogBtnWidth'] as num?
      ..setLogBtnLeft = json['setLogBtnLeft'] as num?
      ..setLogBtnRight = json['setLogBtnRight'] as num?
      ..setLogBtnTop = json['setLogBtnTop'] as num?
      ..setLogBtnBottom = json['setLogBtnBottom'] as num?
      ..setLogBtnCenterX = json['setLogBtnCenterX'] as num?
      ..setLogBtnCenterY = json['setLogBtnCenterY'] as num?
      ..setPrivacyHeight = json['setPrivacyHeight'] as num?
      ..setPrivacyWidth = json['setPrivacyWidth'] as num?
      ..setPrivacyLeft = json['setPrivacyLeft'] as num?
      ..setPrivacyRight = json['setPrivacyRight'] as num?
      ..setPrivacyTop = json['setPrivacyTop'] as num?
      ..setPrivacyBottom = json['setPrivacyBottom'] as num?
      ..setPrivacyCenterX = json['setPrivacyCenterX'] as num?
      ..setPrivacyCenterY = json['setPrivacyCenterY'] as num?
      ..setSloganHeight = json['setSloganHeight'] as num?
      ..setSloganWidth = json['setSloganWidth'] as num?
      ..setSloganLeft = json['setSloganLeft'] as num?
      ..setSloganRight = json['setSloganRight'] as num?
      ..setSloganTop = json['setSloganTop'] as num?
      ..setSloganBottom = json['setSloganBottom'] as num?
      ..setSloganCenterX = json['setSloganCenterX'] as num?
      ..setSloganCenterY = json['setSloganCenterY'] as num?
      ..setShanYanSloganHeight = json['setShanYanSloganHeight'] as num?
      ..setShanYanSloganWidth = json['setShanYanSloganWidth'] as num?
      ..setShanYanSloganLeft = json['setShanYanSloganLeft'] as num?
      ..setShanYanSloganRight = json['setShanYanSloganRight'] as num?
      ..setShanYanSloganTop = json['setShanYanSloganTop'] as num?
      ..setShanYanSloganBottom = json['setShanYanSloganBottom'] as num?
      ..setShanYanSloganCenterX = json['setShanYanSloganCenterX'] as num?
      ..setShanYanSloganCenterY = json['setShanYanSloganCenterY'] as num?
      ..setAuthWindowOrientationCenterX =
          json['setAuthWindowOrientationCenterX'] as num?
      ..setAuthWindowOrientationCenterY =
          json['setAuthWindowOrientationCenterY'] as num?
      ..setAuthWindowOrientationOriginX =
          json['setAuthWindowOrientationOriginX'] as num?
      ..setAuthWindowOrientationOriginY =
          json['setAuthWindowOrientationOriginY'] as num?
      ..setAuthWindowOrientationWidth =
          json['setAuthWindowOrientationWidth'] as num?
      ..setAuthWindowOrientationHeight =
          json['setAuthWindowOrientationHeight'] as num?;

Map<String, dynamic> _$ClOrientationLayOutIOSToJson(
        ClOrientationLayOutIOS instance) =>
    <String, dynamic>{
      if (instance.setLogoWidth case final value?) 'setLogoWidth': value,
      if (instance.setLogoHeight case final value?) 'setLogoHeight': value,
      if (instance.setLogoLeft case final value?) 'setLogoLeft': value,
      if (instance.setLogoRight case final value?) 'setLogoRight': value,
      if (instance.setLogoTop case final value?) 'setLogoTop': value,
      if (instance.setLogoBottom case final value?) 'setLogoBottom': value,
      if (instance.setLogoCenterX case final value?) 'setLogoCenterX': value,
      if (instance.setLogoCenterY case final value?) 'setLogoCenterY': value,
      if (instance.setNumFieldWidth case final value?)
        'setNumFieldWidth': value,
      if (instance.setNumFieldHeight case final value?)
        'setNumFieldHeight': value,
      if (instance.setNumFieldLeft case final value?) 'setNumFieldLeft': value,
      if (instance.setNumFieldRight case final value?)
        'setNumFieldRight': value,
      if (instance.setNumFieldTop case final value?) 'setNumFieldTop': value,
      if (instance.setNumFieldBottom case final value?)
        'setNumFieldBottom': value,
      if (instance.setNumFieldCenterX case final value?)
        'setNumFieldCenterX': value,
      if (instance.setNumFieldCenterY case final value?)
        'setNumFieldCenterY': value,
      if (instance.setLogBtnHeight case final value?) 'setLogBtnHeight': value,
      if (instance.setLogBtnWidth case final value?) 'setLogBtnWidth': value,
      if (instance.setLogBtnLeft case final value?) 'setLogBtnLeft': value,
      if (instance.setLogBtnRight case final value?) 'setLogBtnRight': value,
      if (instance.setLogBtnTop case final value?) 'setLogBtnTop': value,
      if (instance.setLogBtnBottom case final value?) 'setLogBtnBottom': value,
      if (instance.setLogBtnCenterX case final value?)
        'setLogBtnCenterX': value,
      if (instance.setLogBtnCenterY case final value?)
        'setLogBtnCenterY': value,
      if (instance.setPrivacyHeight case final value?)
        'setPrivacyHeight': value,
      if (instance.setPrivacyWidth case final value?) 'setPrivacyWidth': value,
      if (instance.setPrivacyLeft case final value?) 'setPrivacyLeft': value,
      if (instance.setPrivacyRight case final value?) 'setPrivacyRight': value,
      if (instance.setPrivacyTop case final value?) 'setPrivacyTop': value,
      if (instance.setPrivacyBottom case final value?)
        'setPrivacyBottom': value,
      if (instance.setPrivacyCenterX case final value?)
        'setPrivacyCenterX': value,
      if (instance.setPrivacyCenterY case final value?)
        'setPrivacyCenterY': value,
      if (instance.setSloganHeight case final value?) 'setSloganHeight': value,
      if (instance.setSloganWidth case final value?) 'setSloganWidth': value,
      if (instance.setSloganLeft case final value?) 'setSloganLeft': value,
      if (instance.setSloganRight case final value?) 'setSloganRight': value,
      if (instance.setSloganTop case final value?) 'setSloganTop': value,
      if (instance.setSloganBottom case final value?) 'setSloganBottom': value,
      if (instance.setSloganCenterX case final value?)
        'setSloganCenterX': value,
      if (instance.setSloganCenterY case final value?)
        'setSloganCenterY': value,
      if (instance.setShanYanSloganHeight case final value?)
        'setShanYanSloganHeight': value,
      if (instance.setShanYanSloganWidth case final value?)
        'setShanYanSloganWidth': value,
      if (instance.setShanYanSloganLeft case final value?)
        'setShanYanSloganLeft': value,
      if (instance.setShanYanSloganRight case final value?)
        'setShanYanSloganRight': value,
      if (instance.setShanYanSloganTop case final value?)
        'setShanYanSloganTop': value,
      if (instance.setShanYanSloganBottom case final value?)
        'setShanYanSloganBottom': value,
      if (instance.setShanYanSloganCenterX case final value?)
        'setShanYanSloganCenterX': value,
      if (instance.setShanYanSloganCenterY case final value?)
        'setShanYanSloganCenterY': value,
      if (instance.setAuthWindowOrientationCenterX case final value?)
        'setAuthWindowOrientationCenterX': value,
      if (instance.setAuthWindowOrientationCenterY case final value?)
        'setAuthWindowOrientationCenterY': value,
      if (instance.setAuthWindowOrientationOriginX case final value?)
        'setAuthWindowOrientationOriginX': value,
      if (instance.setAuthWindowOrientationOriginY case final value?)
        'setAuthWindowOrientationOriginY': value,
      if (instance.setAuthWindowOrientationWidth case final value?)
        'setAuthWindowOrientationWidth': value,
      if (instance.setAuthWindowOrientationHeight case final value?)
        'setAuthWindowOrientationHeight': value,
    };

ShanYanUIConfigAndroid _$ShanYanUIConfigAndroidFromJson(
        Map<String, dynamic> json) =>
    ShanYanUIConfigAndroid(
      isFinish: json['isFinish'] as bool? ?? false,
    )
      ..setAuthBGImgPath = json['setAuthBGImgPath'] as String?
      ..setAuthBgGifPath = json['setAuthBgGifPath'] as String?
      ..setAuthBgVideoPath = json['setAuthBgVideoPath'] as String?
      ..setStatusBarHidden = json['setStatusBarHidden'] as bool?
      ..setStatusBarColor = json['setStatusBarColor'] as String?
      ..setLogBtnBackgroundColor = json['setLogBtnBackgroundColor'] as String?
      ..setLightColor = json['setLightColor'] as bool?
      ..setVirtualKeyTransparent = json['setVirtualKeyTransparent'] as bool?
      ..setAuthFlagSecureEnable = json['setAuthFlagSecureEnable'] as bool?
      ..setPrivacyFlagSecureEnable = json['setPrivacyFlagSecureEnable'] as bool?
      ..setFullScreen = json['setFullScreen'] as bool?
      ..setNavReturnBtnWidth = (json['setNavReturnBtnWidth'] as num?)?.toInt()
      ..setNavReturnBtnHeight = (json['setNavReturnBtnHeight'] as num?)?.toInt()
      ..setNavReturnBtnOffsetRightX =
          (json['setNavReturnBtnOffsetRightX'] as num?)?.toInt()
      ..setNavReturnBtnOffsetX =
          (json['setNavReturnBtnOffsetX'] as num?)?.toInt()
      ..setNavReturnBtnOffsetY =
          (json['setNavReturnBtnOffsetY'] as num?)?.toInt()
      ..setNavColor = json['setNavColor'] as String?
      ..setNavText = json['setNavText'] as String?
      ..setNavTextColor = json['setNavTextColor'] as String?
      ..setNavTextSize = (json['setNavTextSize'] as num?)?.toInt()
      ..setNavReturnImgPath = json['setNavReturnImgPath'] as String?
      ..setNavReturnImgHidden = json['setNavReturnImgHidden'] as bool?
      ..setBackPressedAvailable = json['setBackPressedAvailable'] as bool?
      ..setFitsSystemWindows = json['setFitsSystemWindows'] as bool?
      ..setAuthNavHidden = json['setAuthNavHidden'] as bool?
      ..setAuthNavTransparent = json['setAuthNavTransparent'] as bool?
      ..setNavTextBold = json['setNavTextBold'] as bool?
      ..setLogoImgPath = json['setLogoImgPath'] as String?
      ..setLogoHidden = json['setLogoHidden'] as bool?
      ..setLogoOffsetY = (json['setLogoOffsetY'] as num?)?.toInt()
      ..setLogoOffsetBottomY = (json['setLogoOffsetBottomY'] as num?)?.toInt()
      ..setLogoOffsetX = (json['setLogoOffsetX'] as num?)?.toInt()
      ..setLogoWidth = (json['setLogoWidth'] as num?)?.toInt()
      ..setLogoHeight = (json['setLogoHeight'] as num?)?.toInt()
      ..setNumFieldOffsetY = (json['setNumFieldOffsetY'] as num?)?.toInt()
      ..setNumFieldOffsetBottomY =
          (json['setNumFieldOffsetBottomY'] as num?)?.toInt()
      ..setNumberSize = (json['setNumberSize'] as num?)?.toInt()
      ..setNumFieldOffsetX = (json['setNumFieldOffsetX'] as num?)?.toInt()
      ..setNumFieldWidth = (json['setNumFieldWidth'] as num?)?.toInt()
      ..setNumFieldHeight = (json['setNumFieldHeight'] as num?)?.toInt()
      ..setNumberColor = json['setNumberColor'] as String?
      ..setNumberBold = json['setNumberBold'] as bool?
      ..setLogBtnOffsetY = (json['setLogBtnOffsetY'] as num?)?.toInt()
      ..setLogBtnOffsetBottomY =
          (json['setLogBtnOffsetBottomY'] as num?)?.toInt()
      ..setLogBtnTextSize = (json['setLogBtnTextSize'] as num?)?.toInt()
      ..setLogBtnOffsetX = (json['setLogBtnOffsetX'] as num?)?.toInt()
      ..setLogBtnHeight = (json['setLogBtnHeight'] as num?)?.toInt()
      ..setLogBtnWidth = (json['setLogBtnWidth'] as num?)?.toInt()
      ..setLogBtnText = json['setLogBtnText'] as String?
      ..setLogBtnTextColor = json['setLogBtnTextColor'] as String?
      ..setLogBtnImgPath = json['setLogBtnImgPath'] as String?
      ..setLogBtnTextBold = json['setLogBtnTextBold'] as bool?
      ..setPrivacyOffsetBottomY =
          (json['setPrivacyOffsetBottomY'] as num?)?.toInt()
      ..setPrivacyOffsetY = (json['setPrivacyOffsetY'] as num?)?.toInt()
      ..setPrivacyOffsetX = (json['setPrivacyOffsetX'] as num?)?.toInt()
      ..setAppPrivacyOne = (json['setAppPrivacyOne'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setAppPrivacyTwo = (json['setAppPrivacyTwo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setAppPrivacyThree = (json['setAppPrivacyThree'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setPrivacySmhHidden = json['setPrivacySmhHidden'] as bool?
      ..setPrivacyTextSize = (json['setPrivacyTextSize'] as num?)?.toInt()
      ..setPrivacyWidth = (json['setPrivacyWidth'] as num?)?.toInt()
      ..setAppPrivacyColor = (json['setAppPrivacyColor'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setPrivacyOffsetGravityLeft =
          json['setPrivacyOffsetGravityLeft'] as bool?
      ..setPrivacyState = json['setPrivacyState'] as bool?
      ..setUncheckedImgPath = json['setUncheckedImgPath'] as String?
      ..setCheckedImgPath = json['setCheckedImgPath'] as String?
      ..setCheckBoxHidden = json['setCheckBoxHidden'] as bool?
      ..setCheckBoxWH = (json['setCheckBoxWH'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList()
      ..setCheckBoxOffsetXY = (json['setCheckBoxOffsetXY'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList()
      ..setCheckBoxMargin = (json['setCheckBoxMargin'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList()
      ..setPrivacyText = (json['setPrivacyText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setPrivacyTextBold = json['setPrivacyTextBold'] as bool?
      ..setCheckBoxTipDisable = json['setCheckBoxTipDisable'] as bool?
      ..setPrivacyCustomToastText = json['setPrivacyCustomToastText'] as String?
      ..setPrivacyNameUnderline = json['setPrivacyNameUnderline'] as bool?
      ..setOperatorPrivacyAtLast = json['setOperatorPrivacyAtLast'] as bool?
      ..setPrivacyGravityHorizontalCenter =
          json['setPrivacyGravityHorizontalCenter'] as bool?
      ..setPrivacyActivityEnabled = json['setPrivacyActivityEnabled'] as bool?
      ..setSloganOffsetY = (json['setSloganOffsetY'] as num?)?.toInt()
      ..setSloganOffsetBottomY =
          (json['setSloganOffsetBottomY'] as num?)?.toInt()
      ..setSloganOffsetX = (json['setSloganOffsetX'] as num?)?.toInt()
      ..setSloganTextColor = json['setSloganTextColor'] as String?
      ..setSloganTextSize = (json['setSloganTextSize'] as num?)?.toInt()
      ..setSloganHidden = json['setSloganHidden'] as bool?
      ..setSloganTextBold = json['setSloganTextBold'] as bool?
      ..setShanYanSloganOffsetY =
          (json['setShanYanSloganOffsetY'] as num?)?.toInt()
      ..setShanYanSloganOffsetBottomY =
          (json['setShanYanSloganOffsetBottomY'] as num?)?.toInt()
      ..setShanYanSloganOffsetX =
          (json['setShanYanSloganOffsetX'] as num?)?.toInt()
      ..setShanYanSloganTextColor = json['setShanYanSloganTextColor'] as String?
      ..setShanYanSloganTextSize =
          (json['setShanYanSloganTextSize'] as num?)?.toInt()
      ..setShanYanSloganHidden = json['setShanYanSloganHidden'] as bool?
      ..setShanYanSloganTextBold = json['setShanYanSloganTextBold'] as bool?
      ..setPrivacyNavColor = json['setPrivacyNavColor'] as String?
      ..setPrivacyNavTextBold = json['setPrivacyNavTextBold'] as bool?
      ..setPrivacyNavTextColor = json['setPrivacyNavTextColor'] as String?
      ..setPrivacyNavTextSize = (json['setPrivacyNavTextSize'] as num?)?.toInt()
      ..setPrivacyNavReturnImgPath =
          json['setPrivacyNavReturnImgPath'] as String?
      ..setPrivacyNavReturnImgHidden =
          json['setPrivacyNavReturnImgHidden'] as bool?
      ..setPrivacyNavReturnBtnWidth =
          (json['setPrivacyNavReturnBtnWidth'] as num?)?.toInt()
      ..setPrivacyNavReturnBtnHeight =
          (json['setPrivacyNavReturnBtnHeight'] as num?)?.toInt()
      ..setPrivacyNavReturnBtnOffsetRightX =
          (json['setPrivacyNavReturnBtnOffsetRightX'] as num?)?.toInt()
      ..setPrivacyNavReturnBtnOffsetX =
          (json['setPrivacyNavReturnBtnOffsetX'] as num?)?.toInt()
      ..setPrivacyNavReturnBtnOffsetY =
          (json['setPrivacyNavReturnBtnOffsetY'] as num?)?.toInt()
      ..setLoadingView = json['setLoadingView'] as String?
      ..setDialogTheme = (json['setDialogTheme'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..setActivityTranslateAnim =
          (json['setActivityTranslateAnim'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList()
      ..widgetLayouts = (json['widgetLayouts'] as List<dynamic>?)
          ?.map((e) =>
              ShanYanCustomWidgetLayout.fromJson(e as Map<String, dynamic>))
          .toList()
      ..widgets = (json['widgets'] as List<dynamic>?)
          ?.map((e) => ShanYanCustomWidget.fromJson(e as Map<String, dynamic>))
          .toList()
      ..morePrivacy = (json['morePrivacy'] as List<dynamic>?)
          ?.map((e) => ConfigPrivacyBean.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ShanYanUIConfigAndroidToJson(
        ShanYanUIConfigAndroid instance) =>
    <String, dynamic>{
      'isFinish': instance.isFinish,
      if (instance.setAuthBGImgPath case final value?)
        'setAuthBGImgPath': value,
      if (instance.setAuthBgGifPath case final value?)
        'setAuthBgGifPath': value,
      if (instance.setAuthBgVideoPath case final value?)
        'setAuthBgVideoPath': value,
      if (instance.setStatusBarHidden case final value?)
        'setStatusBarHidden': value,
      if (instance.setStatusBarColor case final value?)
        'setStatusBarColor': value,
      if (instance.setLogBtnBackgroundColor case final value?)
        'setLogBtnBackgroundColor': value,
      if (instance.setLightColor case final value?) 'setLightColor': value,
      if (instance.setVirtualKeyTransparent case final value?)
        'setVirtualKeyTransparent': value,
      if (instance.setAuthFlagSecureEnable case final value?)
        'setAuthFlagSecureEnable': value,
      if (instance.setPrivacyFlagSecureEnable case final value?)
        'setPrivacyFlagSecureEnable': value,
      if (instance.setFullScreen case final value?) 'setFullScreen': value,
      if (instance.setNavReturnBtnWidth case final value?)
        'setNavReturnBtnWidth': value,
      if (instance.setNavReturnBtnHeight case final value?)
        'setNavReturnBtnHeight': value,
      if (instance.setNavReturnBtnOffsetRightX case final value?)
        'setNavReturnBtnOffsetRightX': value,
      if (instance.setNavReturnBtnOffsetX case final value?)
        'setNavReturnBtnOffsetX': value,
      if (instance.setNavReturnBtnOffsetY case final value?)
        'setNavReturnBtnOffsetY': value,
      if (instance.setNavColor case final value?) 'setNavColor': value,
      if (instance.setNavText case final value?) 'setNavText': value,
      if (instance.setNavTextColor case final value?) 'setNavTextColor': value,
      if (instance.setNavTextSize case final value?) 'setNavTextSize': value,
      if (instance.setNavReturnImgPath case final value?)
        'setNavReturnImgPath': value,
      if (instance.setNavReturnImgHidden case final value?)
        'setNavReturnImgHidden': value,
      if (instance.setBackPressedAvailable case final value?)
        'setBackPressedAvailable': value,
      if (instance.setFitsSystemWindows case final value?)
        'setFitsSystemWindows': value,
      if (instance.setAuthNavHidden case final value?)
        'setAuthNavHidden': value,
      if (instance.setAuthNavTransparent case final value?)
        'setAuthNavTransparent': value,
      if (instance.setNavTextBold case final value?) 'setNavTextBold': value,
      if (instance.setLogoImgPath case final value?) 'setLogoImgPath': value,
      if (instance.setLogoHidden case final value?) 'setLogoHidden': value,
      if (instance.setLogoOffsetY case final value?) 'setLogoOffsetY': value,
      if (instance.setLogoOffsetBottomY case final value?)
        'setLogoOffsetBottomY': value,
      if (instance.setLogoOffsetX case final value?) 'setLogoOffsetX': value,
      if (instance.setLogoWidth case final value?) 'setLogoWidth': value,
      if (instance.setLogoHeight case final value?) 'setLogoHeight': value,
      if (instance.setNumFieldOffsetY case final value?)
        'setNumFieldOffsetY': value,
      if (instance.setNumFieldOffsetBottomY case final value?)
        'setNumFieldOffsetBottomY': value,
      if (instance.setNumberSize case final value?) 'setNumberSize': value,
      if (instance.setNumFieldOffsetX case final value?)
        'setNumFieldOffsetX': value,
      if (instance.setNumFieldWidth case final value?)
        'setNumFieldWidth': value,
      if (instance.setNumFieldHeight case final value?)
        'setNumFieldHeight': value,
      if (instance.setNumberColor case final value?) 'setNumberColor': value,
      if (instance.setNumberBold case final value?) 'setNumberBold': value,
      if (instance.setLogBtnOffsetY case final value?)
        'setLogBtnOffsetY': value,
      if (instance.setLogBtnOffsetBottomY case final value?)
        'setLogBtnOffsetBottomY': value,
      if (instance.setLogBtnTextSize case final value?)
        'setLogBtnTextSize': value,
      if (instance.setLogBtnOffsetX case final value?)
        'setLogBtnOffsetX': value,
      if (instance.setLogBtnHeight case final value?) 'setLogBtnHeight': value,
      if (instance.setLogBtnWidth case final value?) 'setLogBtnWidth': value,
      if (instance.setLogBtnText case final value?) 'setLogBtnText': value,
      if (instance.setLogBtnTextColor case final value?)
        'setLogBtnTextColor': value,
      if (instance.setLogBtnImgPath case final value?)
        'setLogBtnImgPath': value,
      if (instance.setLogBtnTextBold case final value?)
        'setLogBtnTextBold': value,
      if (instance.setPrivacyOffsetBottomY case final value?)
        'setPrivacyOffsetBottomY': value,
      if (instance.setPrivacyOffsetY case final value?)
        'setPrivacyOffsetY': value,
      if (instance.setPrivacyOffsetX case final value?)
        'setPrivacyOffsetX': value,
      if (instance.setAppPrivacyOne case final value?)
        'setAppPrivacyOne': value,
      if (instance.setAppPrivacyTwo case final value?)
        'setAppPrivacyTwo': value,
      if (instance.setAppPrivacyThree case final value?)
        'setAppPrivacyThree': value,
      if (instance.setPrivacySmhHidden case final value?)
        'setPrivacySmhHidden': value,
      if (instance.setPrivacyTextSize case final value?)
        'setPrivacyTextSize': value,
      if (instance.setPrivacyWidth case final value?) 'setPrivacyWidth': value,
      if (instance.setAppPrivacyColor case final value?)
        'setAppPrivacyColor': value,
      if (instance.setPrivacyOffsetGravityLeft case final value?)
        'setPrivacyOffsetGravityLeft': value,
      if (instance.setPrivacyState case final value?) 'setPrivacyState': value,
      if (instance.setUncheckedImgPath case final value?)
        'setUncheckedImgPath': value,
      if (instance.setCheckedImgPath case final value?)
        'setCheckedImgPath': value,
      if (instance.setCheckBoxHidden case final value?)
        'setCheckBoxHidden': value,
      if (instance.setCheckBoxWH case final value?) 'setCheckBoxWH': value,
      if (instance.setCheckBoxOffsetXY case final value?)
        'setCheckBoxOffsetXY': value,
      if (instance.setCheckBoxMargin case final value?)
        'setCheckBoxMargin': value,
      if (instance.setPrivacyText case final value?) 'setPrivacyText': value,
      if (instance.setPrivacyTextBold case final value?)
        'setPrivacyTextBold': value,
      if (instance.setCheckBoxTipDisable case final value?)
        'setCheckBoxTipDisable': value,
      if (instance.setPrivacyCustomToastText case final value?)
        'setPrivacyCustomToastText': value,
      if (instance.setPrivacyNameUnderline case final value?)
        'setPrivacyNameUnderline': value,
      if (instance.setOperatorPrivacyAtLast case final value?)
        'setOperatorPrivacyAtLast': value,
      if (instance.setPrivacyGravityHorizontalCenter case final value?)
        'setPrivacyGravityHorizontalCenter': value,
      if (instance.setPrivacyActivityEnabled case final value?)
        'setPrivacyActivityEnabled': value,
      if (instance.setSloganOffsetY case final value?)
        'setSloganOffsetY': value,
      if (instance.setSloganOffsetBottomY case final value?)
        'setSloganOffsetBottomY': value,
      if (instance.setSloganOffsetX case final value?)
        'setSloganOffsetX': value,
      if (instance.setSloganTextColor case final value?)
        'setSloganTextColor': value,
      if (instance.setSloganTextSize case final value?)
        'setSloganTextSize': value,
      if (instance.setSloganHidden case final value?) 'setSloganHidden': value,
      if (instance.setSloganTextBold case final value?)
        'setSloganTextBold': value,
      if (instance.setShanYanSloganOffsetY case final value?)
        'setShanYanSloganOffsetY': value,
      if (instance.setShanYanSloganOffsetBottomY case final value?)
        'setShanYanSloganOffsetBottomY': value,
      if (instance.setShanYanSloganOffsetX case final value?)
        'setShanYanSloganOffsetX': value,
      if (instance.setShanYanSloganTextColor case final value?)
        'setShanYanSloganTextColor': value,
      if (instance.setShanYanSloganTextSize case final value?)
        'setShanYanSloganTextSize': value,
      if (instance.setShanYanSloganHidden case final value?)
        'setShanYanSloganHidden': value,
      if (instance.setShanYanSloganTextBold case final value?)
        'setShanYanSloganTextBold': value,
      if (instance.setPrivacyNavColor case final value?)
        'setPrivacyNavColor': value,
      if (instance.setPrivacyNavTextBold case final value?)
        'setPrivacyNavTextBold': value,
      if (instance.setPrivacyNavTextColor case final value?)
        'setPrivacyNavTextColor': value,
      if (instance.setPrivacyNavTextSize case final value?)
        'setPrivacyNavTextSize': value,
      if (instance.setPrivacyNavReturnImgPath case final value?)
        'setPrivacyNavReturnImgPath': value,
      if (instance.setPrivacyNavReturnImgHidden case final value?)
        'setPrivacyNavReturnImgHidden': value,
      if (instance.setPrivacyNavReturnBtnWidth case final value?)
        'setPrivacyNavReturnBtnWidth': value,
      if (instance.setPrivacyNavReturnBtnHeight case final value?)
        'setPrivacyNavReturnBtnHeight': value,
      if (instance.setPrivacyNavReturnBtnOffsetRightX case final value?)
        'setPrivacyNavReturnBtnOffsetRightX': value,
      if (instance.setPrivacyNavReturnBtnOffsetX case final value?)
        'setPrivacyNavReturnBtnOffsetX': value,
      if (instance.setPrivacyNavReturnBtnOffsetY case final value?)
        'setPrivacyNavReturnBtnOffsetY': value,
      if (instance.setLoadingView case final value?) 'setLoadingView': value,
      if (instance.setDialogTheme case final value?) 'setDialogTheme': value,
      if (instance.setActivityTranslateAnim case final value?)
        'setActivityTranslateAnim': value,
      if (instance.widgetLayouts?.map((e) => e.toJson()).toList()
          case final value?)
        'widgetLayouts': value,
      if (instance.widgets?.map((e) => e.toJson()).toList() case final value?)
        'widgets': value,
      if (instance.morePrivacy?.map((e) => e.toJson()).toList()
          case final value?)
        'morePrivacy': value,
    };

ShanYanCustomWidgetLayout _$ShanYanCustomWidgetLayoutFromJson(
        Map<String, dynamic> json) =>
    ShanYanCustomWidgetLayout(
      json['widgetLayoutName'] as String,
      $enumDecode(_$ShanYanCustomWidgetLayoutTypeEnumMap, json['type']),
    )
      ..widgetLayoutId = (json['widgetLayoutId'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..left = (json['left'] as num).toInt()
      ..top = (json['top'] as num).toInt()
      ..right = (json['right'] as num).toInt()
      ..bottom = (json['bottom'] as num).toInt()
      ..width = (json['width'] as num).toInt()
      ..height = (json['height'] as num).toInt();

Map<String, dynamic> _$ShanYanCustomWidgetLayoutToJson(
        ShanYanCustomWidgetLayout instance) =>
    <String, dynamic>{
      'widgetLayoutName': instance.widgetLayoutName,
      'widgetLayoutId': instance.widgetLayoutId,
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
      'width': instance.width,
      'height': instance.height,
      'type': _$ShanYanCustomWidgetLayoutTypeEnumMap[instance.type]!,
    };

const _$ShanYanCustomWidgetLayoutTypeEnumMap = {
  ShanYanCustomWidgetLayoutType.RelativeLayout: 'RelativeLayout',
};

ConfigPrivacyBean _$ConfigPrivacyBeanFromJson(Map<String, dynamic> json) =>
    ConfigPrivacyBean(
      json['name'] as String?,
      json['url'] as String?,
    )
      ..color = json['color'] as String?
      ..midStr = json['midStr'] as String?
      ..title = json['title'] as String?;

Map<String, dynamic> _$ConfigPrivacyBeanToJson(ConfigPrivacyBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'color': instance.color,
      'midStr': instance.midStr,
      'title': instance.title,
    };

ShanYanCustomWidget _$ShanYanCustomWidgetFromJson(Map<String, dynamic> json) =>
    ShanYanCustomWidget(
      json['widgetId'] as String,
      $enumDecodeNullable(_$ShanYanCustomWidgetTypeEnumMap, json['type']),
    )
      ..left = (json['left'] as num).toInt()
      ..top = (json['top'] as num).toInt()
      ..right = (json['right'] as num).toInt()
      ..bottom = (json['bottom'] as num).toInt()
      ..width = (json['width'] as num).toInt()
      ..height = (json['height'] as num).toInt()
      ..textContent = json['textContent'] as String
      ..textFont = (json['textFont'] as num).toDouble()
      ..textColor = json['textColor'] as String
      ..backgroundColor = json['backgroundColor'] as String?
      ..backgroundImgPath = json['backgroundImgPath'] as String?
      ..textAlignment = $enumDecode(
          _$ShanYanCustomWidgetGravityTypeEnumMap, json['textAlignment'])
      ..isFinish = json['isFinish'] as bool;

Map<String, dynamic> _$ShanYanCustomWidgetToJson(
        ShanYanCustomWidget instance) =>
    <String, dynamic>{
      'widgetId': instance.widgetId,
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
      'width': instance.width,
      'height': instance.height,
      'textContent': instance.textContent,
      'textFont': instance.textFont,
      'textColor': instance.textColor,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (instance.backgroundImgPath case final value?)
        'backgroundImgPath': value,
      'textAlignment':
          _$ShanYanCustomWidgetGravityTypeEnumMap[instance.textAlignment]!,
      if (_$ShanYanCustomWidgetTypeEnumMap[instance.type] case final value?)
        'type': value,
      'isFinish': instance.isFinish,
    };

const _$ShanYanCustomWidgetTypeEnumMap = {
  ShanYanCustomWidgetType.TextView: 'TextView',
  ShanYanCustomWidgetType.Button: 'Button',
  ShanYanCustomWidgetType.ImageView: 'ImageView',
};

const _$ShanYanCustomWidgetGravityTypeEnumMap = {
  ShanYanCustomWidgetGravityType.left: 'left',
  ShanYanCustomWidgetGravityType.right: 'right',
  ShanYanCustomWidgetGravityType.center: 'center',
};

ShanYanCustomWidgetIOS _$ShanYanCustomWidgetIOSFromJson(
        Map<String, dynamic> json) =>
    ShanYanCustomWidgetIOS(
      json['widgetId'] as String,
      $enumDecodeNullable(_$ShanYanCustomWidgetTypeEnumMap, json['type']),
    )
      ..left = json['left'] as num?
      ..top = json['top'] as num?
      ..right = json['right'] as num?
      ..bottom = json['bottom'] as num?
      ..width = json['width'] as num?
      ..height = json['height'] as num?
      ..centerX = json['centerX'] as num?
      ..centerY = json['centerY'] as num?
      ..cornerRadius = json['cornerRadius'] as num?
      ..borderWidth = json['borderWidth'] as num?
      ..borderColor = json['borderColor'] as String?
      ..textContent = json['textContent'] as String?
      ..textFont = (json['textFont'] as num?)?.toDouble()
      ..textColor = json['textColor'] as String?
      ..backgroundColor = json['backgroundColor'] as String?
      ..image = json['image'] as String?
      ..backgroundImgPath = json['backgroundImgPath'] as String?
      ..textAlignment =
          $enumDecode(_$iOSTextAlignmentEnumMap, json['textAlignment'])
      ..navPosition = $enumDecodeNullable(
          _$ShanYanCustomWidgetiOSNavPositionEnumMap, json['navPosition'])
      ..isFinish = json['isFinish'] as bool;

Map<String, dynamic> _$ShanYanCustomWidgetIOSToJson(
        ShanYanCustomWidgetIOS instance) =>
    <String, dynamic>{
      'widgetId': instance.widgetId,
      if (instance.left case final value?) 'left': value,
      if (instance.top case final value?) 'top': value,
      if (instance.right case final value?) 'right': value,
      if (instance.bottom case final value?) 'bottom': value,
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.centerX case final value?) 'centerX': value,
      if (instance.centerY case final value?) 'centerY': value,
      if (instance.cornerRadius case final value?) 'cornerRadius': value,
      if (instance.borderWidth case final value?) 'borderWidth': value,
      if (instance.borderColor case final value?) 'borderColor': value,
      if (instance.textContent case final value?) 'textContent': value,
      if (instance.textFont case final value?) 'textFont': value,
      if (instance.textColor case final value?) 'textColor': value,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (instance.image case final value?) 'image': value,
      if (instance.backgroundImgPath case final value?)
        'backgroundImgPath': value,
      'textAlignment': _$iOSTextAlignmentEnumMap[instance.textAlignment]!,
      if (_$ShanYanCustomWidgetTypeEnumMap[instance.type] case final value?)
        'type': value,
      if (_$ShanYanCustomWidgetiOSNavPositionEnumMap[instance.navPosition]
          case final value?)
        'navPosition': value,
      'isFinish': instance.isFinish,
    };

const _$ShanYanCustomWidgetiOSNavPositionEnumMap = {
  ShanYanCustomWidgetiOSNavPosition.navleft: 'navleft',
  ShanYanCustomWidgetiOSNavPosition.navright: 'navright',
};
