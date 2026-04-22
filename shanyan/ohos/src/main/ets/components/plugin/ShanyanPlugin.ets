import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import {CLAuthLoginCallBack, CLResult, CLSDKManager, CLUIConfigure ,PrivacyEntity,CLLoginDialogOptions} from '@shanyan/shanyansdk'
import common from '@ohos.app.ability.common';
import { BusinessError, deviceInfo } from '@kit.BasicServicesKit';
import { LevelMode, window } from '@kit.ArkUI';


class WidgetEvent {
  list?:FlutterWidget[];
  onclick:(item:FlutterWidget)=>void = (item:FlutterWidget)=>{}

  private static instance:WidgetEvent | null = null
  static getInstance(){
    if (WidgetEvent.instance == null) {
      WidgetEvent.instance = new WidgetEvent()
    }
    return WidgetEvent.instance
  }
}

/** ShanyanPlugin **/
export default class ShanyanPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private context:Context | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "ShanyanPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "shanyan");
    this.context = binding.getApplicationContext()
    this.channel.setMethodCallHandler(this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "getPlatformVersion") {
      result.success("OpenHarmony ^ ^ ")
    }else if (call.method == "init"){
       this.init(call,result)
    }else if (call.method == 'getPhoneInfo'){
       this.preGetPhonenumber(result)
    }else if (call.method == 'openLoginAuth'){
       this.quickAuthLoginWithConfigure(call,result)
    }else if (call.method == 'finishAuthControllerCompletion'){
       this.finishAuthControllerCompletion(result)
    }else if (call.method == 'clearScripCache'){
       this.clearScripCache()
    }else if (call.method == 'setInitDebug'){
      this.setInitDebug(call)
    }else if (call.method == 'startAuthentication'){
      this.mobileCheckWithLocalPhoneNumberComplete(call,result)
    }else if (call.method == 'setTimeOutForPreLogin'){
      this.setPreGetPhonenumberTimeOut(call)
    }
    else {
      result.notImplemented()
    }
  }

  // 初始化
    async init(call:MethodCall,result: MethodResult){
      CLSDKManager.printConsoleEnable(true)
      let arg:Map<string,ESObject> = call.args as Map<string,ESObject>
      let context = this.context
      let appId = arg.get('appId') as string
      const res:CLResult = await CLSDKManager.init(context,appId)
      result.success(this.completeResultToJson(res))
    }

    // 预取号
    async preGetPhonenumber(result:MethodResult){
      const res:CLResult = await CLSDKManager.preGetPhoneNumber()
      result.success(this.completeResultToJson(res))
    }

    async quickAuthLoginWithConfigure(call:MethodCall,callResult:MethodResult){
      let pathStack = AppStorage.get<NavPathStack>('navPathStack')
      let arg:Map<string,ESObject> = call.args as Map<string,ESObject>
      let configure = this.configureWithConfig(arg)
      CLSDKManager.registNavigation(pathStack)
      const res:CLResult = await CLSDKManager.quickAuthLoginWithConfigure(configure, async (result:CLResult)=>{
        this.channel?.invokeMethod("onReceiveAuthPageEvent",this.completeResultToJson(result))
      })
      if (res) {
        callResult.success(this.completeResultToJson(res))
      }
    }

    // 关闭授权页
    async finishAuthControllerCompletion(result:MethodResult){
      CLSDKManager.closeAuthLoginPage()
    }

    async clearScripCache(){
      CLSDKManager.clearScripCache()
    }

    setInitDebug(call:MethodCall){
      let arg:Map<string,ESObject> = call.args as Map<string,ESObject>
      let enable = arg.get('initDebug') as boolean
      CLSDKManager.printConsoleEnable(enable)
    }
    async mobileCheckWithLocalPhoneNumberComplete(call:MethodCall,callResult:MethodResult){
      const result:CLResult = await CLSDKManager.mobileCheckWithLocalPhoneNumberComplete()
      if (result) {
         callResult.success(this.completeResultToJson(result))
      }else {
         callResult.error('2010','本机号认证获取token出错','')
      }
    }

    setPreGetPhonenumberTimeOut(call:MethodCall){
      let arg:Map<string,ESObject> = call.args as Map<string,ESObject>
      let timeout = arg.get('timeOut') as number
      CLSDKManager.setPreGetPhoneNumberTimeOut(timeout)
    }


    configureWithConfig(map:Map<string,ESObject>):CLUIConfigure{
      let configure = new CLUIConfigure()
      try {
        let context = getContext() as common.UIAbilityContext
        configure.uiContext = context.windowStage.getMainWindowSync().getUIContext()

        if (map && map.size > 0) {
          let mapModel = mapToObject(map) as ShanYanUIConfigHarmony
          if (mapModel.windowLayoutFullScreen) {
            if (mapModel.windowLayoutFullScreen===true) {
              let windowStage = context.windowStage
              windowStage.getMainWindowSync().setWindowLayoutFullScreen(true)
            }else {
              let windowStage = context.windowStage
              windowStage.getMainWindowSync().setWindowLayoutFullScreen(false)
            }
          }

          let systemBarProperties: window.SystemBarProperties = {
            statusBarColor:mapModel.statusBarColor,
            isStatusBarLightIcon:mapModel.isStatusBarLightIcon,
            statusBarContentColor:mapModel.statusBarContentColor,
            navigationBarColor:mapModel.navigationBarColor,
            isNavigationBarLightIcon:mapModel.isNavigationBarLightIcon,
            navigationBarContentColor :mapModel.navigationBarContentColor,
            enableStatusBarAnimation :mapModel.enableStatusBarAnimation,
            enableNavigationBarAnimation:mapModel.enableNavigationBarAnimation
          }
          configure.systemBarProperties = systemBarProperties

          configure.navTextSize = mapModel.navTextSize
          configure.navTextColor = mapModel.navTextColor
          configure.navColor = mapModel.navColor
          configure.loginPageGrayScale = mapModel.loginPageGrayScale

          configure.numberSize = mapModel.numberSize
          configure.numberIsBold = mapModel.numberIsBold
          configure.numberColor = mapModel.numberColor

          configure.loginBtnWidth = mapModel.loginBtnWidth;        // 设置号码宽度
          configure.loginBtnHeight = mapModel.loginBtnHeight      // 设置号码高度
          configure.loginBtnText   = mapModel.loginBtnText       // 设置登录按钮文本内容
          configure.loginBtnTextSize = mapModel.loginBtnTextSize     // 设置授权登录文本字体大小
          configure.loginBtnTextColor= mapModel.loginBtnTextColor    // 设置授权登录按钮字体颜色
          configure.loginBtnImgPath = $r(`app.media.${mapModel.loginBtnImgPath}`)      // 设置登录按钮背景图片
          configure.loginBtnColor = mapModel.loginBtnColor        // 设置登录按钮背景颜色
          configure.loginBtnBorderRadius = mapModel.loginBtnBorderRadius // 设置登录按钮圆角


          configure.checkBoxWidth = mapModel.checkBoxWidth  // 设置隐私条款勾选框宽度
          configure.checkBoxHeight = mapModel.checkBoxHeight // 设置隐私条款勾选框高度
          configure.clauseState = mapModel.clauseState    // 设置隐私条款勾选框勾选状态
          configure.checkedImage = $r(`app.media.${mapModel.checkedImage}`)   // 设置 checkbox 勾选和未勾选图片(需同时设置checkedImage、unCheckedImage)
          configure.unCheckedImage = $r(`app.media.${mapModel.unCheckedImage}`) // 设置 checkbox 勾选和未勾选图片(需同时设置checkedImage、unCheckedImage)
          configure.checkedColor = mapModel.checkedColor   // 设置勾选颜色
          configure.clauseNavMarginTop = mapModel.clauseNavMarginTop

          if (mapModel.checkTipText && mapModel.checkTipText.length >0) {
            configure.checkTipText = mapModel.checkTipText
          }else {
            configure.checkTipText = '请勾选协议'
          }
          configure.windowMode = mapModel.windowMode
          //窗口模式配置
          configure.dialogOptions = this.windowToDialogOptions(mapModel)

          if (mapModel.widgets && mapModel.widgets?.length > 0){
            WidgetEvent.getInstance().list = toHamonyWidget(mapModel.widgets)
            // console.log("输出一下当前的" + WidgetEvent.getInstance().list)
            configure.loginPageComponent = FlutterWidgetView
            WidgetEvent.getInstance().onclick = (item:FlutterWidget)=>{
              let map:Record<string,ESObject> = {
                "widgetId":item.widgetId,
                "isFinish":item.isFinish
              }
              this.channel?.invokeMethod("onReceiveClickWidgetEvent",map)
              if (item.isFinish && item.isFinish === true) {
                CLSDKManager.closeAuthLoginPage()
              }
            }
          }else{
            configure.loginPageComponent = FlutterBlankWidgetView
          }

          if (mapModel.isInterceptionLogin && mapModel.isInterceptionLogin === true) {
            const self = this
            configure.authLoginListener = ({
              onAuthLoginListener(context: UIContext, callBack: CLAuthLoginCallBack) {
                const resultHandler: MethodResult = {
                  success: (res: ESObject) => {
                    // console.log('Flutter 返回:', JSON.stringify(res));
                    if (res && res === true) {
                      CLSDKManager.clearScripCache()
                      callBack.onAuthLoginCallBack(true)
                    }else {
                      callBack.onAuthLoginCallBack(false)
                    }
                  },
                  error: (code: string, msg: string, details: ESObject) => {
                    // console.error('Flutter 错误:', code, msg);
                    callBack.onAuthLoginCallBack(false)
                  },
                  notImplemented: () => {
                    console.warn('Flutter 未实现该方法');
                    callBack.onAuthLoginCallBack(false)
                  }
                };
                let res:Record<string,string> = {
                  "res":"点击一键登录"
                }
                self.channel?.invokeMethod("onAuthLoginHarmonyListener",res,resultHandler)
              }
            })
          }

          configure.loginClickListener = ({
            onLoginClickStart(context:UIContext){

            },
            onLoginClickComplete(context:UIContext){
            }
          })

          configure.clauseComponent = clauseComponent

          // configure.loginBtnMargin = {top:30}
          try {
            configure.clauses = toHarmonyPrivacyEntity(mapModel.clauses)

            configure.numberMargin = toHarmonyMargin(mapModel.numberMargin)
            configure.numberAlignRuleOption = toHarmonyAlignRuleOption(mapModel.numberAlignRuleOption)

            configure.loginBtnMargin = toHarmonyMargin(mapModel.loginBtnMargin)
            configure.loginBtnAlignRuleOption = toHarmonyAlignRuleOption(mapModel.loginBtnAlignRuleOption)

            configure.clauseMargin = toHarmonyMargin(mapModel.clauseMargin)
            configure.clauseAlignRuleOption = toHarmonyAlignRuleOption(mapModel.clauseAlignRuleOption)

            configure.checkBoxMargin = toHarmonyMargin(mapModel.checkBoxMargin)
            configure.checkBoxAlignRuleOption = toHarmonyAlignRuleOption(mapModel.checkBoxAlignRuleOption)

          }catch (e) {
            let error = e as BusinessError
            console.log(`configure转化异常:name:${error.name},code=${error.code},message:${error.message},stack:${error.stack}`)
          }
        }
      }catch (e) {
        let error = e as BusinessError
        console.log(`configure转化异常:name:${error.name},code=${error.code},message:${error.message},stack:${error.stack}`)
      }
      return configure
    }

    completeResultToJson(completeResult:CLResult):Record<string,ESObject>{
      let token = ''
      if (completeResult.data && completeResult.data.get('token')) {
        token = completeResult.data.get('token')
      }
      let result: Record<string, ESObject> = {
        "code":completeResult.code,
        "message":completeResult.message,
        "innerCode":completeResult.innerCode,
        "innerDesc":completeResult.innerDesc,
        "token":token
      }
      return result
    }

    windowToDialogOptions(model:ShanYanUIConfigHarmony):CLLoginDialogOptions{
      let alignmentArray = [
        DialogAlignment.Top,DialogAlignment.Center,DialogAlignment.Bottom,
        DialogAlignment.Default,
        DialogAlignment.TopStart,DialogAlignment.TopEnd,
        DialogAlignment.CenterStart,DialogAlignment.CenterEnd,
        DialogAlignment.BottomStart,DialogAlignment.BottomEnd
      ]
      let tmpAlignment = DialogAlignment.Center
      if (model.windowAlignment && model.windowAlignment >=0 && model.windowAlignment <9) {
        tmpAlignment = alignmentArray[model.windowAlignment]
      }
      let dialogOptions:CLLoginDialogOptions = {
        width:model.windowWidth ?? '70%',
        height:model.windowHeight ??'50%',
        autoCancel:model.windowAutoCancel ?? false,
        maskColor:model.windowMaskColor,
        offset:{dx:model.windowOffsetX ?? 0,dy: model.windowHeight ?? 0},
        showInSubWindow:model.windowShowInSubWindow,
        isModal:model.windowIsModal,
        alignment:tmpAlignment
      }
      if (deviceInfo.sdkApiVersion >= 15 ) {
        dialogOptions.levelMode = model.windowLevelMode
        dialogOptions.levelUniqueId = model.windowLevelUniqueId
        dialogOptions.immersiveMode = model.windowImmersiveMode
      }
      if (deviceInfo.sdkApiVersion >=14) {
        dialogOptions.enableHoverMode = model.windowEnableHoverMode
        dialogOptions.hoverModeArea = model.windowHoverModeArea
      }
      return dialogOptions
    }

}

function  mapToObject(map: Map<string, ESObject>): Record<string, ESObject> {
  const obj: Record<string, ESObject> = {};
  map.forEach((value: ESObject, key: string) => {
  if (value instanceof Map) {
    // 递归处理嵌套 Map
    obj[key] = mapToObject(value);
  } else {
    obj[key] = value;
  }
});
return obj;
}

/**
 * 将自定义 AlignRuleOption 转成鸿蒙 ArkUI 官方 AlignRuleOption
 */
function toHarmonyAlignRuleOption(custom?: FlutterAlignRuleOption): AlignRuleOption | undefined {
  if (!custom) {
    return undefined
  }
  const mapHorizontal = (align: FLutterHorizontalAlign | FLutterVerticalAlign): HorizontalAlign  => {
    switch (align) {
      case FLutterHorizontalAlign.Start: return HorizontalAlign.Start
      case FLutterHorizontalAlign.Center: return HorizontalAlign.Center
      case FLutterHorizontalAlign.End: return HorizontalAlign.End
      default : return HorizontalAlign.Start
    }
  }
  const mapVertical = (align?: FLutterHorizontalAlign | FLutterVerticalAlign): VerticalAlign => {
    switch (align) {
      case FLutterVerticalAlign.Top: return VerticalAlign.Top
      case FLutterVerticalAlign.Middle: return VerticalAlign.Center
      case FLutterVerticalAlign.Bottom: return VerticalAlign.Bottom
      default : return VerticalAlign.Top
    }
  }
  let result:AlignRuleOption = {}
  if (custom.left){result.left = {anchor:custom.left.anchor,align:mapHorizontal(custom.left.align)}}
  if (custom.right){result.right = {anchor:custom.right.anchor,align:mapHorizontal(custom.right.align)}}
  if (custom.middle){result.middle = {anchor:custom.middle.anchor,align:mapHorizontal(custom.middle.align)}}
  if (custom.top){result.top = {anchor:custom.top.anchor,align:mapVertical(custom.top.align)}}
  if (custom.center){result.center = {anchor:custom.center.anchor,align:mapVertical(custom.center.align)}}
  if (custom.bottom){result.bottom = {anchor:custom.bottom.anchor,align:mapVertical(custom.bottom.align)}}
  return result
}

function toHarmonyMargin(margin?:FlutterMarginOrPadding):Margin | undefined{
  if (!margin) {return undefined}
  let result:Margin = {}
  if (margin.left) {result.left = margin.left}
  if (margin.right) {result.right = margin.right}
  if (margin.top) {result.top = margin.top}
  if (margin.bottom) {result.bottom = margin.bottom}
  return result
}

function toHamonyWidget(items?:Map<string,ESObject>[]):FlutterWidget[]{
  if (!items || items.length <=0) { return []}
  let array:FlutterWidget[] =[]
  items.forEach((item:Map<string,ESObject>)=>{
    let tt = mapToObject(item) as FlutterWidget
    array.push(tt)
  })
  return array
}

function toHarmonyPrivacyEntity(privacys?:Map<string,ESObject>[]) :PrivacyEntity[] | undefined{
  if (!privacys || privacys.length <=0) { return undefined}
  const getFontWeght = (fontWeight:number):FontWeight=>{
    switch (fontWeight){
      case 0: return FontWeight.Lighter
      case 1: return FontWeight.Normal
      case 2: return FontWeight.Regular
      case 3: return FontWeight.Medium
      case 4: return FontWeight.Bold
      case 5: return FontWeight.Bolder
      default :return FontWeight.Normal
    }
  }
  let array:PrivacyEntity[] = []
  privacys.forEach((privacy:Map<string,ESObject>)=>{
    let tt = mapToObject(privacy) as FlutterPrivacyEntity
    let tmp:PrivacyEntity = new PrivacyEntity()
    tmp.text = tt.text
    tmp.fontSize = tt.fontSize
    tmp.fontWeight = getFontWeght(tt.fontWeight)
    tmp.isProtocol = tt.isProtocol
    tmp.url = tt.url
    tmp.fontColor = tt.fontColor
    array.push(tmp)
  })
  return array
}

function toHarmonyImageFit(scale?:number){
  if (!scale) {
    return undefined
  }
  const imageAry = [
    ImageFit.Contain,
    ImageFit.Cover,
    ImageFit.Auto,
    ImageFit.Fill,
    ImageFit.ScaleDown,
    ImageFit.None,
    ImageFit.TOP_START,
    ImageFit.TOP,
    ImageFit.TOP_END,
    ImageFit.START,
    ImageFit.CENTER,
    ImageFit.END,
    ImageFit.BOTTOM_START,
    ImageFit.BOTTOM,
    ImageFit.BOTTOM_END,
    ImageFit.MATRIX
  ]
  if (scale <16 && scale >=0) {
    return imageAry[scale]
  }else {
    return undefined
  }
}

function toHarmonyTextAlign(align?:number){
  if (!align){ return undefined}
  switch (align){
    case 0:return TextAlign.Center
    case 1:return TextAlign.Start
    case 2:return TextAlign.End
    case 3:return TextAlign.JUSTIFY
    default : return undefined
  }
}



/**
 * 授权页 UI 配置 HarmonyOS 端接口
 */
interface ShanYanUIConfigHarmony {

  statusBarColor? :string
  isStatusBarLightIcon? :boolean
  statusBarContentColor? :string
  navigationBarColor? :string
  isNavigationBarLightIcon?: boolean
  navigationBarContentColor? :string
  enableStatusBarAnimation?: boolean
  enableNavigationBarAnimation? :boolean

  // ---------- 导航栏设置 ----------
  navTextSize?: number;        // 服务条款标题字体大小
  navTextColor?: string;       // 服务条款标题字体颜色, 例如"#FFFFFF"
  navColor?: string;           // 服务栏颜色，例如"#000000"
  loginPageGrayScale?: number; // 授权页灰度值，范围0-1

  // ---------- 手机号码设置 ----------
  numberSize?: number;   // 手机号码字体大小
  numberIsBold?: boolean; // 是否加粗
  numberColor?: string;  // 手机号码字体颜色
  numberAlignRuleOption?: FlutterAlignRuleOption; // 手机号码布局偏移规则
  numberMargin?: FlutterMarginOrPadding;          // 手机号码边缘边距

  loginBtnWidth?: number;        // 登录按钮宽度
  loginBtnHeight?: number;       // 登录按钮高度
  loginBtnText?: string;         // 登录按钮文本
  loginBtnTextSize?: number;     // 登录按钮字体大小
  loginBtnTextColor?: string;    // 登录按钮字体颜色
  loginBtnImgPath?: string;      // 登录按钮背景图片
  loginBtnColor?: string;        // 登录按钮背景颜色
  loginBtnBorderRadius?: number; // 登录按钮圆角
  loginBtnAlignRuleOption?: FlutterAlignRuleOption; // 登录按钮布局偏移规则
  loginBtnMargin?: FlutterMarginOrPadding;          // 登录按钮边缘边距

  // ---------- 隐私协议设置 ----------
  clauses?: Map<string,ESObject>[];      // 隐私条款
  checkBoxWidth?: number;                       // 勾选框宽度
  checkBoxHeight?: number;                      // 勾选框高度
  clauseState?: boolean;                        // 勾选状态
  checkedImage?: string;                        // 勾选图片
  unCheckedImage?: string;                      // 未勾选图片
  checkedColor?: string;                        // 勾选颜色
  checkTipText?: string;                        // 未勾选提示文案
  clauseMargin?: FlutterMarginOrPadding;               // 隐私协议边缘边距
  clauseAlignRuleOption?: FlutterAlignRuleOption;      // 隐私协议布局偏移规则
  checkBoxMargin?: FlutterMarginOrPadding;             // 勾选框偏移边距
  checkBoxAlignRuleOption?: FlutterAlignRuleOption;   // 勾选框布局偏移规则
  clauseNavMarginTop?:number                          // 设置协议页标题栏margin.top，范围为 0-99
  windowLayoutFullScreen?: boolean                    // 设置是否全屏，默认不配置


  isInterceptionLogin?:boolean;

  widgets ?:Map<string,ESObject>[];
  // ---------- 窗口模式 ----------
  windowMode?: boolean; // 窗口模式，默认 false
  windowWidth?: string
  windowHeight?: string
  windowAlignment?: number
  windowOffsetX?: string
  windowOffsetY?: string
  windowShowInSubWindow?: boolean
  windowIsModal?: boolean
  windowAutoCancel?: boolean
  windowMaskColor?: string
  windowKeyboardAvoidMode?: number
  windowEnableHoverMode?: boolean
  windowHoverModeArea?: number
  windowLevelMode?: number
  windowLevelUniqueId?: number
  windowImmersiveMode?: number
}


interface  FlutterPrivacyEntity {
  text: string
  fontSize: number
  fontWeight: number
  isProtocol: boolean
  fontColor: string
  url?: string
}


/**
 * 布局偏移规则接口
 */
interface FlutterAlignRuleOption{
  left?: FlutterAlignAnchor;
  center?: FlutterAlignAnchor;
  right?: FlutterAlignAnchor;

  top?: FlutterAlignAnchor;
  middle?: FlutterAlignAnchor;
  bottom?: FlutterAlignAnchor;

  bias?: FlutterBiasOption;
}

/**
 * 偏移锚点接口
 */
interface FlutterAlignAnchor{
  anchor: string,
  align: FLutterHorizontalAlign | FLutterVerticalAlign
}

/**
 * 水平 / 垂直偏移枚举
 */

enum FLutterHorizontalAlign {
  Start = 1,
  Center = 2,
  End = 3,
}

enum FLutterVerticalAlign {
  Top = 4,
  Middle = 5,
  Bottom = 6,
}

/**
 * 偏差值接口
 */
interface FlutterBiasOption {
  horizontal?: number;
  vertical?: number;
}

/**
 * 边缘 / 内边距接口
 */
interface FlutterMarginOrPadding {
  top?: Length;
  left?: Length;
  right?: Length;
  bottom?: Length;
}

interface FlutterWidget{
  widgetId: string
  type:FlutterWidgetType
  margin?:FlutterMarginOrPadding
  width?:string
  height?:string
  textAlign?:number
  scaleType?:number
  alignRuleOption?:FlutterAlignRuleOption
  cornerRadius?:number
  borderWidth?:number
  borderColor?:string
  textContent?:string
  textFont?:number
  textColor?:string
  backgroundColor?:string
  image?:string
  backgroundImgPath?:string
  isFinish:boolean
}

enum FlutterWidgetType{
  TextView = 'TextView',
  Button = 'Button',
  ImageView = 'ImageView'
}


@Builder
function FlutterWidgetView(){
  RelativeContainer(){
    ForEach(WidgetEvent.getInstance().list,(item:FlutterWidget)=>{
      if (item.type === FlutterWidgetType.Button) {
        Button(item.textContent,{type:ButtonType.Normal})
          .id(item.widgetId)
          .width(item.width)
          .height(item.height)
          .fontColor(item.textColor)
          .fontSize(item.textFont)
          .backgroundColor(item.backgroundColor)
          .backgroundImage($r(`app.media.${item.backgroundImgPath}`))
          .borderWidth(item.borderWidth)
          .borderColor(item.borderColor)
          .borderRadius(item.cornerRadius as Length)
          .margin(toHarmonyMargin(item.margin))
          .alignRules(toHarmonyAlignRuleOption(item.alignRuleOption))
          .onClick(()=>{
            WidgetEvent.getInstance().onclick(item)
          })

      }else if (item.type === FlutterWidgetType.ImageView){
        // Image($rawfile(`flutter_assets/assets/Img/${item.backgroundImgPath}`))
        Image($r(`app.media.${item.backgroundImgPath}`))
          .id(item.widgetId)
          .width(item.width)
          .height(item.height)
          .objectFit(toHarmonyImageFit(item.scaleType))
          .backgroundColor(item.backgroundColor)
          .borderWidth(item.borderWidth)
          .borderColor(item.borderColor)
          .borderRadius(item.cornerRadius as Length)
          .margin(toHarmonyMargin(item.margin))
          .alignRules(toHarmonyAlignRuleOption(item.alignRuleOption))
          .onClick(()=>{
            WidgetEvent.getInstance().onclick(item)
          })
      }else if (item.type === FlutterWidgetType.TextView){
        Text(item.textContent)
          .id(item.widgetId)
          .width(item.width)
          .height(item.height)
          .fontColor(item.textColor)
          .fontSize(item.textFont)
          .textAlign(toHarmonyTextAlign(item.textAlign))
          .backgroundColor(item.backgroundColor)
          .borderWidth(item.borderWidth)
          .borderColor(item.borderColor)
          .borderRadius(item.cornerRadius as Length)
          .margin(toHarmonyMargin(item.margin))
          .alignRules(toHarmonyAlignRuleOption(item.alignRuleOption))
          .onClick(()=>{
            WidgetEvent.getInstance().onclick(item)
          })
      }else {
        //用户自己扩展
      }
    },(item:FlutterWidget) => item.widgetId)
  }
}

@Builder
function FlutterBlankWidgetView(){
  RelativeContainer(){

  }.width('100%')
  .height('100%')
  .backgroundColor('#ffffff')
}

@Builder
export function clauseComponent(): void {
  Column() {
    Text('自定义协议页标题栏')
      .fontSize(20)
      .alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        center: { anchor: '__container__', align: VerticalAlign.Center },
      })
  }.width('100%')
  .height(50)
  .backgroundColor(0x7f0086d0)
  .id('clauseComponent')
}

