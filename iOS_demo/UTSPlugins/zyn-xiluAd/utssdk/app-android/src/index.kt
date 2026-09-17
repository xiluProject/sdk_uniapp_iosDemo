@file:Suppress("UNCHECKED_CAST", "USELESS_CAST", "INAPPLICABLE_JVM_NAME", "UNUSED_ANONYMOUS_PARAMETER", "SENSELESS_COMPARISON", "NAME_SHADOWING", "UNNECESSARY_NOT_NULL_ASSERTION")
package uts.sdk.modules.zynXiluAd
import io.dcloud.uniapp.*
import io.dcloud.uniapp.extapi.*
import io.dcloud.uts.*
import io.dcloud.uts.Map
import io.dcloud.uts.Set
import io.dcloud.uts.UTSAndroid
import kotlin.properties.Delegates
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
open class XiluInitOptions (
    @JsonNotNull
    open var appId: String,
    open var debug: Boolean? = null,
    open var success: ((message: String) -> Unit)? = null,
    open var fail: ((errMsg: String) -> Unit)? = null,
    open var complete: (() -> Unit)? = null,
) : UTSObject()
open class XiluAdEvents (
    open var onReceive: (() -> Unit)? = null,
    open var onFail: ((message: String) -> Unit)? = null,
    open var onClick: (() -> Unit)? = null,
    open var onClose: (() -> Unit)? = null,
    open var onExpose: (() -> Unit)? = null,
    open var onSkip: (() -> Unit)? = null,
    open var onTick: ((remaining: Number) -> Unit)? = null,
    open var onReward: (() -> Unit)? = null,
    open var onVideoComplete: (() -> Unit)? = null,
) : UTSObject()
open class XiluLoadAdOptions (
    @JsonNotNull
    open var posId: String,
    open var top: Number? = null,
    open var left: Number? = null,
    open var width: Number? = null,
    open var height: Number? = null,
    open var count: Number? = null,
    open var events: XiluAdEvents? = null,
) : UTSObject()
val initSDK = fun(options: XiluInitOptions): Unit {
    options.fail?.invoke("zyn-xiluAd 暂不支持 Android 平台")
    options.complete?.invoke()
}
val isInitialized = fun(): Boolean {
    return false
}
val loadSplashAd = fun(_options: XiluLoadAdOptions): Unit {}
val loadBannerAd = fun(_options: XiluLoadAdOptions): Unit {}
val loadInterstitialAd = fun(_options: XiluLoadAdOptions): Unit {}
val loadRewardVideoAd = fun(_options: XiluLoadAdOptions): Unit {}
val loadNativeTemplateAd = fun(_options: XiluLoadAdOptions): Unit {}
val loadNativeRenderAd = fun(_options: XiluLoadAdOptions): Unit {}
val destroyAd = fun(_type: String): Unit {}
open class XiluInitOptionsJSONObject : UTSJSONObject() {
    open lateinit var appId: String
    open var debug: Boolean? = null
    open var success: UTSCallback? = null
    open var fail: UTSCallback? = null
    open var complete: UTSCallback? = null
}
open class XiluAdEventsJSONObject : UTSJSONObject() {
    open var onReceive: UTSCallback? = null
    open var onFail: UTSCallback? = null
    open var onClick: UTSCallback? = null
    open var onClose: UTSCallback? = null
    open var onExpose: UTSCallback? = null
    open var onSkip: UTSCallback? = null
    open var onTick: UTSCallback? = null
    open var onReward: UTSCallback? = null
    open var onVideoComplete: UTSCallback? = null
}
open class XiluLoadAdOptionsJSONObject : UTSJSONObject() {
    open lateinit var posId: String
    open var top: Number? = null
    open var left: Number? = null
    open var width: Number? = null
    open var height: Number? = null
    open var count: Number? = null
    open var events: XiluAdEventsJSONObject? = null
}
fun initSDKByJs(options: XiluInitOptionsJSONObject): Unit {
    return initSDK(XiluInitOptions(appId = options.appId, debug = options.debug, success = fun(message: String): Unit {
        options.success?.invoke(message)
    }
    , fail = fun(errMsg: String): Unit {
        options.fail?.invoke(errMsg)
    }
    , complete = fun(): Unit {
        options.complete?.invoke()
    }
    ))
}
fun isInitializedByJs(): Boolean {
    return isInitialized()
}
fun loadSplashAdByJs(_options: XiluLoadAdOptionsJSONObject): Unit {
    val events = _options.events
    return loadSplashAd(XiluLoadAdOptions(posId = _options.posId, top = _options.top, left = _options.left, width = _options.width, height = _options.height, count = _options.count, events = if (events != null) {
        XiluAdEvents(onReceive = fun(): Unit {
            events!!.onReceive?.invoke()
        }, onFail = fun(message: String): Unit {
            events!!.onFail?.invoke(message)
        }, onClick = fun(): Unit {
            events!!.onClick?.invoke()
        }, onClose = fun(): Unit {
            events!!.onClose?.invoke()
        }, onExpose = fun(): Unit {
            events!!.onExpose?.invoke()
        }, onSkip = fun(): Unit {
            events!!.onSkip?.invoke()
        }, onTick = fun(remaining: Number): Unit {
            events!!.onTick?.invoke(remaining)
        }, onReward = fun(): Unit {
            events!!.onReward?.invoke()
        }, onVideoComplete = fun(): Unit {
            events!!.onVideoComplete?.invoke()
        })
    } else {
        null
    }
    ))
}
fun loadBannerAdByJs(_options: XiluLoadAdOptionsJSONObject): Unit {
    val events = _options.events
    return loadBannerAd(XiluLoadAdOptions(posId = _options.posId, top = _options.top, left = _options.left, width = _options.width, height = _options.height, count = _options.count, events = if (events != null) {
        XiluAdEvents(onReceive = fun(): Unit {
            events!!.onReceive?.invoke()
        }, onFail = fun(message: String): Unit {
            events!!.onFail?.invoke(message)
        }, onClick = fun(): Unit {
            events!!.onClick?.invoke()
        }, onClose = fun(): Unit {
            events!!.onClose?.invoke()
        }, onExpose = fun(): Unit {
            events!!.onExpose?.invoke()
        }, onSkip = fun(): Unit {
            events!!.onSkip?.invoke()
        }, onTick = fun(remaining: Number): Unit {
            events!!.onTick?.invoke(remaining)
        }, onReward = fun(): Unit {
            events!!.onReward?.invoke()
        }, onVideoComplete = fun(): Unit {
            events!!.onVideoComplete?.invoke()
        })
    } else {
        null
    }
    ))
}
fun loadInterstitialAdByJs(_options: XiluLoadAdOptionsJSONObject): Unit {
    val events = _options.events
    return loadInterstitialAd(XiluLoadAdOptions(posId = _options.posId, top = _options.top, left = _options.left, width = _options.width, height = _options.height, count = _options.count, events = if (events != null) {
        XiluAdEvents(onReceive = fun(): Unit {
            events!!.onReceive?.invoke()
        }, onFail = fun(message: String): Unit {
            events!!.onFail?.invoke(message)
        }, onClick = fun(): Unit {
            events!!.onClick?.invoke()
        }, onClose = fun(): Unit {
            events!!.onClose?.invoke()
        }, onExpose = fun(): Unit {
            events!!.onExpose?.invoke()
        }, onSkip = fun(): Unit {
            events!!.onSkip?.invoke()
        }, onTick = fun(remaining: Number): Unit {
            events!!.onTick?.invoke(remaining)
        }, onReward = fun(): Unit {
            events!!.onReward?.invoke()
        }, onVideoComplete = fun(): Unit {
            events!!.onVideoComplete?.invoke()
        })
    } else {
        null
    }
    ))
}
fun loadRewardVideoAdByJs(_options: XiluLoadAdOptionsJSONObject): Unit {
    val events = _options.events
    return loadRewardVideoAd(XiluLoadAdOptions(posId = _options.posId, top = _options.top, left = _options.left, width = _options.width, height = _options.height, count = _options.count, events = if (events != null) {
        XiluAdEvents(onReceive = fun(): Unit {
            events!!.onReceive?.invoke()
        }, onFail = fun(message: String): Unit {
            events!!.onFail?.invoke(message)
        }, onClick = fun(): Unit {
            events!!.onClick?.invoke()
        }, onClose = fun(): Unit {
            events!!.onClose?.invoke()
        }, onExpose = fun(): Unit {
            events!!.onExpose?.invoke()
        }, onSkip = fun(): Unit {
            events!!.onSkip?.invoke()
        }, onTick = fun(remaining: Number): Unit {
            events!!.onTick?.invoke(remaining)
        }, onReward = fun(): Unit {
            events!!.onReward?.invoke()
        }, onVideoComplete = fun(): Unit {
            events!!.onVideoComplete?.invoke()
        })
    } else {
        null
    }
    ))
}
fun loadNativeTemplateAdByJs(_options: XiluLoadAdOptionsJSONObject): Unit {
    val events = _options.events
    return loadNativeTemplateAd(XiluLoadAdOptions(posId = _options.posId, top = _options.top, left = _options.left, width = _options.width, height = _options.height, count = _options.count, events = if (events != null) {
        XiluAdEvents(onReceive = fun(): Unit {
            events!!.onReceive?.invoke()
        }, onFail = fun(message: String): Unit {
            events!!.onFail?.invoke(message)
        }, onClick = fun(): Unit {
            events!!.onClick?.invoke()
        }, onClose = fun(): Unit {
            events!!.onClose?.invoke()
        }, onExpose = fun(): Unit {
            events!!.onExpose?.invoke()
        }, onSkip = fun(): Unit {
            events!!.onSkip?.invoke()
        }, onTick = fun(remaining: Number): Unit {
            events!!.onTick?.invoke(remaining)
        }, onReward = fun(): Unit {
            events!!.onReward?.invoke()
        }, onVideoComplete = fun(): Unit {
            events!!.onVideoComplete?.invoke()
        })
    } else {
        null
    }
    ))
}
fun loadNativeRenderAdByJs(_options: XiluLoadAdOptionsJSONObject): Unit {
    val events = _options.events
    return loadNativeRenderAd(XiluLoadAdOptions(posId = _options.posId, top = _options.top, left = _options.left, width = _options.width, height = _options.height, count = _options.count, events = if (events != null) {
        XiluAdEvents(onReceive = fun(): Unit {
            events!!.onReceive?.invoke()
        }, onFail = fun(message: String): Unit {
            events!!.onFail?.invoke(message)
        }, onClick = fun(): Unit {
            events!!.onClick?.invoke()
        }, onClose = fun(): Unit {
            events!!.onClose?.invoke()
        }, onExpose = fun(): Unit {
            events!!.onExpose?.invoke()
        }, onSkip = fun(): Unit {
            events!!.onSkip?.invoke()
        }, onTick = fun(remaining: Number): Unit {
            events!!.onTick?.invoke(remaining)
        }, onReward = fun(): Unit {
            events!!.onReward?.invoke()
        }, onVideoComplete = fun(): Unit {
            events!!.onVideoComplete?.invoke()
        })
    } else {
        null
    }
    ))
}
fun destroyAdByJs(_type: String): Unit {
    return destroyAd(_type)
}
