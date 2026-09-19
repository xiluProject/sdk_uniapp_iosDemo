# xiluAdSdk - uniapp 集成文档
## 目录结构

sdk_uniapp_iosDemo：

```
sdk_uniapp_iosDemo/
├── adSdk_uniapp_iosDemo/       # HBuilder X 工程demo
└── iOS_demo/                   # 本地打包之后的iOS原生demo
```

xiluAdSdk 是一个支持多平台广告聚合的 iOS SDK，提供统一的 API 接口，支持 Objective-C 和 Swift/SwiftUI 项目。

## xiluAdSdk 的 UTS 插件导入

1. 下载 `adSdk_uniapp_iosDemo` 工程
2. 把 `adSdk_uniapp_iosDemo` 中 `xiluAdSdk` 文件夹添加到您的 `uni_modules` 中（如果没有 `uni_modules`，请创建一个 `uni_modules` 文件夹）
3. 把 `adSdk_uniapp_iosDemo` 中 `common` 文件夹添加到您的工程中


---

## 统一调用模式（重要）

所有广告类型都遵循「**加载与展示分离**」的两步模式：

| 步骤 | 方法 | 说明 |
|---|---|---|
| 1 | `xiluAd.loadXxxAd({ posId, events })` | 只加载，不展示。加载成功会触发 `onReceive` |
| 2 | `onReceive` 里调用 `this.showAd()` | 业务方决定何时展示 |
| 3 | `xiluAd.showXxxAd()` | 真正展示广告 |

对照表：

| 广告类型 | 加载 | 展示 |
|---|---|---|
| 开屏 | `loadSplashAd` | `showSplashAd` |
| 插屏 | `loadInterstitialAd` | `showInterstitialAd` |
| 激励视频 | `loadRewardVideoAd` | `showRewardVideoAd` |
| 横幅 | `loadBannerAd` | `showBannerAd` |
| 信息流模板 | `loadNativeTemplateAd` | `showNativeTemplateAd` |
| 信息流自渲染 | `loadNativeRenderAd` | `showNativeRenderAd` |

**统一调用链：**

```
点击「加载广告」
   → loadAd()
   → xiluAd.loadXxxAd({ posId, events })
   → onReceive 回调
   → this.showAd()
   → xiluAd.showXxxAd()
   → onExpose / onClick / onClose
```

**注意：**

- `showXxxAd()` 必须在 `onReceive` 之后调用，否则对应的广告实例还未创建
- 每次 `loadXxxAd` 会释放上一次的广告实例，重复调用要按顺序来

---

## 快速开始

### 1. 初始化 SDK

```vue
import * as xiluAd from '@/uni_modules/xiluAdSdk';
import xiluConfig from '@/common/xilu-config.js';

xiluAd.initSDK({
    appId: this.appId,
    debug: true,
    success: (msg) => {
        this.inited = true;
        uni.showToast({ title: msg || '初始化成功', icon: 'success' });
    },
    fail: (errMsg) => {
        this.inited = false;
        uni.showModal({ title: '初始化失败', content: errMsg, showCancel: false });
    }
});
```

具体实现可以看 `adSdk_uniapp_iosDemo/pages/index/index.vue` 里面的代码。

---

### 2. 加载和展示广告

#### 开屏广告

```vue
// 加载广告（仅加载，不展示）
loadAd() {
    // #ifdef APP-PLUS
    if (uni.getSystemInfoSync().platform !== 'ios') {
        uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
        return;
    }
    if (typeof xiluAd === 'undefined' || !xiluAd.loadSplashAd) {
        uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
        return;
    }
    if (!this.posId) {
        uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
        return;
    }
    this.logs = [];
    this.setStatus('正在加载...', 'status-wait');
    xiluAd.loadSplashAd({ posId: this.posId, events: this.buildEvents() });
    // #endif
    // #ifndef APP-PLUS
    uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
    // #endif
}

// 回调与展示
buildEvents() {
    return {
        onReceive: () => {
            this.log('广告加载成功');
            this.showAd();
        },
        onFail: (message) => {
            this.setStatus('加载失败', 'status-err');
            this.log(`广告加载失败：${message}`);
        },
        onExpose: () => this.log('广告曝光'),
        onClick: () => this.log('广告被点击'),
        onSkip: () => this.log('广告被跳过'),
        onClose: () => {
            this.setStatus('广告已关闭', 'status-wait');
            this.log('广告关闭');
        },
        onTick: (remaining) => this.log(`倒计时：${remaining}s`)
    };
}

// 独立展示方法
showAd() {
    // #ifdef APP-PLUS
    if (typeof xiluAd === 'undefined' || !xiluAd.showSplashAd) {
        this.setStatus('SDK 未导出 showSplashAd', 'status-err');
        this.log('当前 SDK 未导出 showSplashAd，无法手动展示');
        return;
    }
    xiluAd.showSplashAd();
    this.setStatus('已展示', 'status-ok');
    this.log('广告全屏展示');
    // #endif
}
```

---

#### 插屏广告

```vue
// 加载广告（仅加载，不弹出）
loadAd() {
    // #ifdef APP-PLUS
    if (uni.getSystemInfoSync().platform !== 'ios') {
        uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
        return;
    }
    if (typeof xiluAd === 'undefined' || !xiluAd.loadInterstitialAd) {
        uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
        return;
    }
    if (!this.posId) {
        uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
        return;
    }
    this.logs = [];
    this.setStatus('正在加载...', 'status-wait');
    xiluAd.loadInterstitialAd({ posId: this.posId, events: this.buildEvents() });
    // #endif
    // #ifndef APP-PLUS
    uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
    // #endif
}

// 回调与展示
buildEvents() {
    return {
        onReceive: () => {
            this.log('插屏广告加载成功');
            this.showAd();
        },
        onFail: (message) => {
            this.setStatus('加载失败', 'status-err');
            this.log(`插屏广告加载失败：${message}`);
        },
        onExpose: () => this.log('广告曝光'),
        onClick: () => this.log('广告被点击'),
        onClose: () => {
            this.setStatus('广告已关闭', 'status-wait');
            this.log('插屏广告关闭');
        }
    };
}

// 独立展示方法
showAd() {
    // #ifdef APP-PLUS
    if (typeof xiluAd === 'undefined' || !xiluAd.showInterstitialAd) {
        this.setStatus('SDK 未导出 showInterstitialAd', 'status-err');
        this.log('当前 SDK 未导出 showInterstitialAd，无法手动弹出');
        return;
    }
    xiluAd.showInterstitialAd();
    this.setStatus('加载成功，已弹出', 'status-ok');
    this.log('插屏广告已弹出');
    // #endif
}
```

---

#### 激励视频广告

```vue
// 加载广告（仅加载，不播放）
loadAd() {
    // #ifdef APP-PLUS
    if (uni.getSystemInfoSync().platform !== 'ios') {
        uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
        return;
    }
    if (typeof xiluAd === 'undefined' || !xiluAd.loadRewardVideoAd) {
        uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
        return;
    }
    if (!this.posId) {
        uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
        return;
    }
    this.logs = [];
    this.setStatus('正在加载...', 'status-wait');
    xiluAd.loadRewardVideoAd({ posId: this.posId, events: this.buildEvents() });
    // #endif
    // #ifndef APP-PLUS
    uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
    // #endif
}

// 回调与展示
buildEvents() {
    return {
        onReceive: () => {
            this.log('激励视频加载成功');
            this.showAd();
        },
        onFail: (message) => {
            this.setStatus('加载/播放失败', 'status-err');
            this.log(`激励视频失败：${message}`);
        },
        onExpose: () => this.log('广告曝光'),
        onClick: () => this.log('广告被点击'),
        onVideoComplete: () => this.log('视频播放完成'),
        onReward: () => {
            this.log('达到奖励条件，请在此发放奖励');
            uni.showToast({ title: '获得奖励', icon: 'success' });
        },
        onClose: () => {
            this.setStatus('广告已关闭', 'status-wait');
            this.log('激励视频广告关闭');
        }
    };
}

// 独立展示方法
showAd() {
    // #ifdef APP-PLUS
    if (typeof xiluAd === 'undefined' || !xiluAd.showRewardVideoAd) {
        this.setStatus('SDK 未导出 showRewardVideoAd', 'status-err');
        this.log('当前 SDK 未导出 showRewardVideoAd，无法手动播放');
        return;
    }
    xiluAd.showRewardVideoAd();
    this.setStatus('加载成功，开始播放', 'status-ok');
    this.log('激励视频开始播放');
    // #endif
}
```

---

#### 横幅广告

```vue
// 加载广告（仅加载，不展示；先把占位区坐标传给 SDK）
loadAd() {
    // #ifdef APP-PLUS
    if (uni.getSystemInfoSync().platform !== 'ios') {
        uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
        return;
    }
    if (typeof xiluAd === 'undefined' || !xiluAd.loadBannerAd) {
        uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
        return;
    }
    if (!this.posId) {
        uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
        return;
    }
    this.logs = [];
    this.loaded = false;
    this.setStatus('正在加载...', 'status-wait');

    const sys = uni.getSystemInfoSync();
    const navOffset = (sys.statusBarHeight || 0) + 44;

    uni.createSelectorQuery()
        .in(this)
        .select('.banner-placeholder')
        .boundingClientRect((rect) => {
            if (!rect) {
                uni.showToast({ title: '未找到展示区域', icon: 'none' });
                return;
            }
            const frame = {
                top: rect.top + navOffset,
                left: rect.left,
                width: rect.width,
                height: rect.height
            };
            this.log(`占位区域坐标：top=${frame.top} left=${frame.left} ${frame.width}x${frame.height}`);
            xiluAd.loadBannerAd({
                posId: this.posId,
                top: frame.top,
                left: frame.left,
                width: frame.width,
                height: frame.height,
                events: this.buildEvents()
            });
        })
        .exec();
    // #endif
    // #ifndef APP-PLUS
    uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
    // #endif
}

// 回调与展示
buildEvents() {
    return {
        onReceive: () => {
            this.log('Banner 广告加载成功');
            this.showAd();
        },
        onFail: (message) => {
            this.setStatus('加载失败', 'status-err');
            this.log(`Banner 广告加载失败：${message}`);
        },
        onExpose: () => this.log('广告曝光'),
        onClick: () => this.log('广告被点击'),
        onClose: () => {
            this.loaded = false;
            this.setStatus('广告已关闭', 'status-wait');
            this.log('Banner 广告关闭');
        }
    };
}

// 独立展示方法
showAd() {
    // #ifdef APP-PLUS
    if (typeof xiluAd === 'undefined' || !xiluAd.showBannerAd) {
        this.setStatus('SDK 未导出 showBannerAd', 'status-err');
        this.log('当前 SDK 未导出 showBannerAd，无法手动展示');
        return;
    }
    xiluAd.showBannerAd();
    this.loaded = true;
    this.setStatus('加载成功', 'status-ok');
    this.log('Banner 广告已展示到占位区域');
    // #endif
}
```

---

#### 信息流模板广告

```vue
// 加载广告（仅加载，不渲染；先把占位区坐标传给 SDK）
loadAd() {
    // #ifdef APP-PLUS
    if (uni.getSystemInfoSync().platform !== 'ios') {
        uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
        return;
    }
    if (typeof xiluAd === 'undefined' || !xiluAd.loadNativeTemplateAd) {
        uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
        return;
    }
    if (!this.posId) {
        uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
        return;
    }
    this.logs = [];
    this.setStatus('正在加载...', 'status-wait');

    const sys = uni.getSystemInfoSync();
    const navOffset = (sys.statusBarHeight || 0) + 44;

    uni.createSelectorQuery()
        .in(this)
        .select('#nativePlaceholder')
        .boundingClientRect((rect) => {
            if (!rect) {
                uni.showToast({ title: '未找到展示区域', icon: 'none' });
                return;
            }
            const top = rect.top + navOffset;
            const left = rect.left;
            const width = rect.width;
            this.log(`占位区坐标：top=${top} left=${left} ${width}x${rect.height}`);

            xiluAd.loadNativeTemplateAd({
                posId: this.posId,
                count: 3,
                top: top,
                events: this.buildEvents()
            });
        })
        .exec();
    // #endif
    // #ifndef APP-PLUS
    uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
    // #endif
}

// 回调与展示
buildEvents() {
    return {
        onReceive: () => {
            this.log('信息流模板广告加载成功');
            this.showAd();
        },
        onFail: (message) => {
            this.setStatus('加载失败', 'status-err');
            this.log(`信息流广告加载失败：${message}`);
        },
        onExpose: () => this.log('广告曝光'),
        onClick: () => this.log('广告被点击'),
        onClose: () => {
            this.setStatus('广告已关闭', 'status-wait');
            this.log('信息流广告关闭');
        }
    };
}

// 独立展示方法
showAd() {
    // #ifdef APP-PLUS
    if (typeof xiluAd === 'undefined' || !xiluAd.showNativeTemplateAd) {
        this.setStatus('SDK 未导出 showNativeTemplateAd', 'status-err');
        this.log('当前 SDK 未导出 showNativeTemplateAd，无法手动渲染');
        return;
    }
    xiluAd.showNativeTemplateAd();
    this.setStatus('加载成功', 'status-ok');
    this.log('信息流模板广告已渲染到容器');
    // #endif
}
```

---

#### 信息流自渲染广告

```vue
// 加载广告（仅加载，不渲染）
loadAd() {
    // #ifdef APP-PLUS
    if (uni.getSystemInfoSync().platform !== 'ios') {
        uni.showToast({ title: '广告仅支持 iOS 设备', icon: 'none' });
        return;
    }
    if (typeof xiluAd === 'undefined' || !xiluAd.loadNativeRenderAd) {
        uni.showToast({ title: '当前基座不含广告插件，请用自定义调试基座', icon: 'none' });
        return;
    }
    if (!this.posId) {
        uni.showToast({ title: '请输入广告位 Id', icon: 'none' });
        return;
    }
    this.logs = [];
    this.setStatus('正在加载...', 'status-wait');

    const sys = uni.getSystemInfoSync();
    const navOffset = (sys.statusBarHeight || 0) + 44;

    uni.createSelectorQuery()
        .in(this)
        .select('#nativePlaceholder')
        .boundingClientRect((rect) => {
            if (!rect) {
                uni.showToast({ title: '未找到展示区域', icon: 'none' });
                return;
            }
            const top = rect.top + navOffset;
            const left = rect.left;
            const width = rect.width;
            this.log(`占位区坐标：top=${top} left=${left} ${width}x${rect.height}`);

            xiluAd.loadNativeRenderAd({
                posId: this.posId,
                count: 3,
                top: top,
                events: this.buildEvents()
            });
        })
        .exec();
    // #endif
    // #ifndef APP-PLUS
    uni.showToast({ title: '请在 iOS App 自定义基座中运行', icon: 'none' });
    // #endif
}

// 回调与展示
buildEvents() {
    return {
        onReceive: () => {
            this.log('信息流自渲染广告加载成功');
            this.showAd();
        },
        onFail: (message) => {
            this.setStatus('加载失败', 'status-err');
            this.log(`信息流广告加载失败：${message}`);
        },
        onExpose: () => this.log('广告曝光'),
        onClick: () => this.log('广告被点击'),
        onClose: () => {
            this.setStatus('广告已关闭', 'status-wait');
            this.log('信息流广告关闭');
        }
    };
}

// 独立展示方法
showAd() {
    // #ifdef APP-PLUS
    if (typeof xiluAd === 'undefined' || !xiluAd.showNativeRenderAd) {
        this.setStatus('SDK 未导出 showNativeRenderAd', 'status-err');
        this.log('当前 SDK 未导出 showNativeRenderAd，无法手动渲染');
        return;
    }
    xiluAd.showNativeRenderAd();
    this.setStatus('加载成功', 'status-ok');
    this.log('信息流自渲染广告已渲染到容器');
    // #endif
}
```

---

## UTS 侧导出方法列表

供 vue 侧调用，均从 `@/uni_modules/xiluAdSdk` 导出：

| 方法 | 说明 |
|---|---|
| `initSDK(options)` | 初始化 SDK |
| `isInitialized()` | 是否已初始化 |
| `loadSplashAd(options)` | 加载开屏广告 |
| `showSplashAd()` | 展示开屏广告 |
| `loadBannerAd(options)` | 加载 Banner 广告 |
| `showBannerAd()` | 展示 Banner 广告 |
| `bringBannerToFront()` | 将 Banner 提到最前 |
| `sendBannerToBack()` | 将 Banner 沉到最后 |
| `loadInterstitialAd(options)` | 加载插屏广告 |
| `showInterstitialAd()` | 展示插屏广告 |
| `loadRewardVideoAd(options)` | 加载激励视频广告 |
| `showRewardVideoAd()` | 展示激励视频广告 |
| `loadNativeTemplateAd(options)` | 加载信息流模板广告 |
| `showNativeTemplateAd()` | 展示信息流模板广告 |
| `loadNativeRenderAd(options)` | 加载信息流自渲染广告 |
| `showNativeRenderAd()` | 展示信息流自渲染广告 |
| `addNativeTestCards(count)` | 向信息流容器追加测试卡片 |
| `destroyAd(type)` | 销毁指定广告实例 |

`destroyAd(type)` 的 `type` 取值：`"splash"` / `"banner"` / `"interstitial"` / `"rewardVideo"` / `"native"`。

## 

### 本地配置（推荐）

在 `common/xilu-config.js` 里维护 appId 与各广告位 Id：

```js
export default {
    appId: '你的AppId',
    posIds: {
        splash: '开屏广告位Id',
        banner: 'Banner广告位Id',
        interstitial: '插屏广告位Id',
        rewardVideo: '激励视频广告位Id',
        nativeTemplate: '信息流模板广告位Id',
        nativeRender: '信息流自渲染广告位Id'
    }
};
```

### 本地打包注意事项
如果使用本地打包的话,请去uniapp官网:https://nativesupport.dcloud.net.cn/AppDocs/download/ios.html下载对应的SDK版本,将解压后的SDK文件夹放到sdk_uniapp_iosDemo文件夹中,然后再自行pod install

### 解决uni-AD业务状态异常（-9001）弹框的问题

在iOS项目中添加iOS_demo/sdk_uniapp_iosDemo文件夹中的UIView+H5PUIToastBlocker.h和UIView+H5PUIToastBlocker.m文件,然后在AppDelegate.m文件中导入UIView+H5PUIToastBlocker.h的头文件

```js
#import "AppDelegate.h"
...
#import "UIView+H5PUIToastBlocker.h"
```



如有问题或建议，请联系：

- 邮箱: support@xilu.com
- 文档: https://github.com/xiluProject/sdk_uniapp_iosDemo
- demo 地址: https://github.com/xiluProject/sdk_uniapp_iosDemo

---

## 更新日志

### v1.0.0 (2026-10-27)

- 初始版本发布
- 支持 
- 包含完整的示例项目
