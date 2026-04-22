import common from '@ohos.app.ability.common';
import { FlutterPage } from '@ohos/flutter_ohos'

let storage = LocalStorage.getShared()
const EVENT_BACK_PRESS = 'EVENT_BACK_PRESS'

@Entry(storage)
@Component
struct Index {
  private context = getContext(this) as common.UIAbilityContext
  @LocalStorageLink('viewId') viewId: string = "";
  @LocalStorageLink('navPathStack') navPathStack: NavPathStack = new NavPathStack()

  aboutToAppear() {
    // 将 NavPathStack 存入 AppStorage，供 EntryAbility 中的 NavigationChannel 使用
    AppStorage.setOrCreate<NavPathStack>('navPathStack', this.navPathStack)
  }

  build() {
    Navigation(this.navPathStack) {
      Column() {
        FlutterPage({ viewId: this.viewId })
      }
    }
    .hideTitleBar(true)
  }

  onBackPress(): boolean {
    this.context.eventHub.emit(EVENT_BACK_PRESS)
    return true
  }
}
