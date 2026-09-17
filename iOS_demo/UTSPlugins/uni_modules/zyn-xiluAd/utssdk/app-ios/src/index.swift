import ADXiluSDK
import CoreGraphics
import DCloudUTSFoundation
import Foundation
import GDTMobSDK
import MSAdSDK
import UIKit
@objc(UTSSDKModulesZynXiluAdXiluInitOptions)
@objcMembers
public class XiluInitOptions : NSObject, UTSObject {
    public var appId: String!
    public var debug: Bool = false
    public var success: ((_ message: String) -> Void)?
    public var fail: ((_ errMsg: String) -> Void)?
    public var complete: (() -> Void)?
    public subscript(_ key: String) -> Any? {
        get {
            return utsSubscriptGetValue(key)
        }
        set {
            switch(key){
                case "appId":
                    self.appId = try! utsSubscriptCheckValue(newValue)
                case "debug":
                    self.debug = try! utsSubscriptCheckValue(newValue)
                case "success":
                    self.success = try! utsSubscriptCheckValueIfPresent(newValue)
                case "fail":
                    self.fail = try! utsSubscriptCheckValueIfPresent(newValue)
                case "complete":
                    self.complete = try! utsSubscriptCheckValueIfPresent(newValue)
                default:
                    break
            }
        }
    }
    public override init() {
        super.init()
    }
    public init(_ obj: UTSJSONObject) {
        self.appId = obj["appId"] as! String
        self.debug = (obj["debug"] as? Bool) ?? false
        self.success = obj["success"] as! ((_ message: String) -> Void)?
        self.fail = obj["fail"] as! ((_ errMsg: String) -> Void)?
        self.complete = obj["complete"] as! (() -> Void)?
    }
}
@objc(UTSSDKModulesZynXiluAdXiluAdEvents)
@objcMembers
public class XiluAdEvents : NSObject, UTSObject {
    public var onReceive: (() -> Void)?
    public var onFail: ((_ message: String) -> Void)?
    public var onClick: (() -> Void)?
    public var onClose: (() -> Void)?
    public var onExpose: (() -> Void)?
    public var onSkip: (() -> Void)?
    public var onTick: ((_ remaining: NSNumber) -> Void)?
    public var onReward: (() -> Void)?
    public var onVideoComplete: (() -> Void)?
    public subscript(_ key: String) -> Any? {
        get {
            return utsSubscriptGetValue(key)
        }
        set {
            switch(key){
                case "onReceive":
                    self.onReceive = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onFail":
                    self.onFail = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onClick":
                    self.onClick = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onClose":
                    self.onClose = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onExpose":
                    self.onExpose = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onSkip":
                    self.onSkip = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onTick":
                    self.onTick = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onReward":
                    self.onReward = try! utsSubscriptCheckValueIfPresent(newValue)
                case "onVideoComplete":
                    self.onVideoComplete = try! utsSubscriptCheckValueIfPresent(newValue)
                default:
                    break
            }
        }
    }
    public override init() {
        super.init()
    }
    public init(_ obj: UTSJSONObject) {
        self.onReceive = obj["onReceive"] as! (() -> Void)?
        self.onFail = obj["onFail"] as! ((_ message: String) -> Void)?
        self.onClick = obj["onClick"] as! (() -> Void)?
        self.onClose = obj["onClose"] as! (() -> Void)?
        self.onExpose = obj["onExpose"] as! (() -> Void)?
        self.onSkip = obj["onSkip"] as! (() -> Void)?
        self.onTick = obj["onTick"] as! ((_ remaining: NSNumber) -> Void)?
        self.onReward = obj["onReward"] as! (() -> Void)?
        self.onVideoComplete = obj["onVideoComplete"] as! (() -> Void)?
    }
}
@objc(UTSSDKModulesZynXiluAdXiluLoadAdOptions)
@objcMembers
public class XiluLoadAdOptions : NSObject, UTSObject {
    public var posId: String!
    public var top: NSNumber?
    public var left: NSNumber?
    public var width: NSNumber?
    public var height: NSNumber?
    public var count: NSNumber?
    public var events: XiluAdEvents?
    public subscript(_ key: String) -> Any? {
        get {
            return utsSubscriptGetValue(key)
        }
        set {
            switch(key){
                case "posId":
                    self.posId = try! utsSubscriptCheckValue(newValue)
                case "top":
                    self.top = try! utsSubscriptCheckValueIfPresent(newValue)
                case "left":
                    self.left = try! utsSubscriptCheckValueIfPresent(newValue)
                case "width":
                    self.width = try! utsSubscriptCheckValueIfPresent(newValue)
                case "height":
                    self.height = try! utsSubscriptCheckValueIfPresent(newValue)
                case "count":
                    self.count = try! utsSubscriptCheckValueIfPresent(newValue)
                case "events":
                    self.events = try! utsSubscriptCheckValueIfPresent(newValue)
                default:
                    break
            }
        }
    }
    public override init() {
        super.init()
    }
    public init(_ obj: UTSJSONObject) {
        self.posId = obj["posId"] as! String
        self.top = obj["top"] as! NSNumber?
        self.left = obj["left"] as! NSNumber?
        self.width = obj["width"] as! NSNumber?
        self.height = obj["height"] as! NSNumber?
        self.count = obj["count"] as! NSNumber?
        self.events = obj["events"] as! XiluAdEvents?
    }
}
public func runOnMain(_ block: @escaping () -> Void) -> Void {
    if (Thread.isMainThread) {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}
public func num(_ v: CGFloat) -> NSNumber {
    return NSNumber(value: Double(v))
}
public func cgf(_ v: NSNumber) -> CGFloat {
    return CGFloat((v as! NSNumber).doubleValue)
}
public func cgi(_ v: NSNumber) -> Int {
    return (v as! NSNumber).intValue
}
public func xRect(_ x: NSNumber, _ y: NSNumber, _ w: NSNumber, _ h: NSNumber) -> CGRect {
    return CGRectMake(cgf(x), cgf(y), cgf(w), cgf(h))
}
public func xSize(_ w: NSNumber, _ h: NSNumber) -> CGSize {
    return CGSizeMake(cgf(w), cgf(h))
}
public func screenWidth() -> NSNumber {
    return num(UIScreen.main.bounds.size.width)
}
public func screenHeight() -> NSNumber {
    return num(UIScreen.main.bounds.size.height)
}
public func getKeyWindow() -> UIWindow? {
    var app = UIApplication.shared
    var kw = app.keyWindow
    if (kw != nil) {
        return kw
    }
    var wins = app.windows
    do {
        var i: NSNumber = 0
        while(i < wins.length){
            if (wins[i].isKeyWindow) {
                return wins[i]
            }
            i++
        }
    }
    return wins.length > 0 ? wins[0] : nil
}
public func safeAreaBottom() -> NSNumber {
    var win = getKeyWindow()
    if (win != nil) {
        return num(win!.safeAreaInsets.bottom)
    }
    return 0
}
public func platformName(_ p: ADXiluAdPlatform) -> String {
    if (p == ADXiluAdPlatform.beizi) {
        return "倍孜Beizi"
    } else if (p == ADXiluAdPlatform.ms) {
        return "美数MS"
    } else if (p == ADXiluAdPlatform.gdt) {
        return "优量汇GDT"
    } else if (p == ADXiluAdPlatform.csj) {
        return "穿山甲CSJ"
    } else if (p == ADXiluAdPlatform.bqt) {
        return "百度百青藤BQT"
    } else if (p == ADXiluAdPlatform.ks) {
        return "快手KS"
    }
    return "全部渠道All"
}
public func topViewController(_ vc: UIViewController?) -> UIViewController? {
    var current = vc
    do {
        var i: NSNumber = 0
        while(i < 10){
            if (current == nil) {
                break
            }
            if (current!.presentedViewController != nil) {
                current = current!.presentedViewController
            } else if (UTSiOS.instanceof(current, UINavigationController.self)) {
                current = (current as! UINavigationController).visibleViewController
            } else if (UTSiOS.instanceof(current, UITabBarController.self)) {
                current = (current as! UITabBarController).selectedViewController
            } else {
                break
            }
            i++
        }
    }
    return current
}
public func getTopViewController() -> UIViewController? {
    var win = getKeyWindow()
    if (win == nil) {
        return nil
    }
    return topViewController(win!.rootViewController)
}
public func loadRemoteImage(_ imageView: UIImageView, _ urlStr: String?) -> Void {
    if (urlStr == nil || urlStr!.length == 0) {
        return
    }
    var url = URL(string: urlStr!)
    if (url == nil) {
        return
    }
    DispatchQueue.global().async(execute: {
    () -> Void in
    var data = NSData(contentsOf: url!)
    if (data == nil) {
        return
    }
    var img = UIImage(data: data as! Data)
    if (img == nil) {
        return
    }
    DispatchQueue.main.async(execute: {
    () -> Void in
    imageView.image = img!
    })
    })
}
@objc(UTSSDKModulesZynXiluAdXilu_Rect)
@objcMembers
public class xilu_Rect : NSObject, UTSObject {
    public var x: NSNumber!
    public var y: NSNumber!
    public var w: NSNumber!
    public var h: NSNumber!
    public subscript(_ key: String) -> Any? {
        get {
            return utsSubscriptGetValue(key)
        }
        set {
            switch(key){
                case "x":
                    self.x = try! utsSubscriptCheckValue(newValue)
                case "y":
                    self.y = try! utsSubscriptCheckValue(newValue)
                case "w":
                    self.w = try! utsSubscriptCheckValue(newValue)
                case "h":
                    self.h = try! utsSubscriptCheckValue(newValue)
                default:
                    break
            }
        }
    }
    public override init() {
        super.init()
    }
    public init(_ obj: UTSJSONObject) {
        self.x = obj["x"] as! NSNumber
        self.y = obj["y"] as! NSNumber
        self.w = obj["w"] as! NSNumber
        self.h = obj["h"] as! NSNumber
    }
}
public func makeLabel(_ frame: xilu_Rect, _ text: String?, _ fontSize: NSNumber, _ color: UIColor, _ lines: NSNumber) -> UILabel {
    var label = UILabel()
    label.frame = xRect(frame.x, frame.y, frame.w, frame.h)
    label.text = text
    label.font = UIFont.systemFont(ofSize: cgf(fontSize))
    label.textColor = color
    label.numberOfLines = cgi(lines)
    return label
}
public func makeTipView(_ width: NSNumber, _ text: String) -> UIView {
    var tip = UIView()
    tip.frame = xRect(0, 0, width, 44)
    tip.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    var label = makeLabel(xilu_Rect(UTSJSONObject([
        "x": 12 as NSNumber,
        "y": 0 as NSNumber,
        "w": width - 24,
        "h": 44 as NSNumber
    ])), text, 12, UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1), 1)
    tip.addSubview(label)
    return tip
}
public func buildMSCard(_ model: MSNativeFeedAdModel, _ vc: UIViewController, _ width: NSNumber) -> UIView? {
    var meta = model.adMaterialMeta
    if (meta == nil) {
        return nil
    }
    var ctype = meta!.metaCreativeType()
    var isThree = ctype == MSCreativeType.threeImage
    var isSmall = ctype == MSCreativeType.smallImage
    var cardH: NSNumber = isThree || isSmall ? 186 : 216
    var card = MSNativeCustomAdView()
    card.frame = xRect(0, 0, width, cardH)
    card.backgroundColor = UIColor.white
    var closeBtn = UIButton(type: UIButton.ButtonType.custom)
    closeBtn.frame = xRect(width - 30, 6, 24, 24)
    closeBtn.setTitle("×", for: UIControl.State.normal)
    closeBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    closeBtn.titleLabel!.font = UIFont.systemFont(ofSize: 20)
    var logoView = meta!.metaLogo()
    logoView.frame = xRect(width - 52, 10, 16, 16)
    logoView.contentMode = UIView.ContentMode.scaleAspectFit
    var iconView = UIImageView()
    iconView.frame = xRect(12, 10, 44, 44)
    iconView.contentMode = UIView.ContentMode.scaleAspectFill
    iconView.clipsToBounds = true
    loadRemoteImage(iconView, meta!.metaIcon())
    var titleLabel = makeLabel(xilu_Rect(UTSJSONObject([
        "x": 66 as NSNumber,
        "y": 8 as NSNumber,
        "w": width - 150,
        "h": 22 as NSNumber
    ])), meta!.metaTitle(), 16, UIColor.black, 1)
    var descLabel = makeLabel(xilu_Rect(UTSJSONObject([
        "x": 66 as NSNumber,
        "y": 32 as NSNumber,
        "w": width - 90,
        "h": 18 as NSNumber
    ])), meta!.metaContent(), 13, UIColor.darkGray, 1)
    var actionTitle = meta!.metaActionTitle()
    var actionLabel = makeLabel(xilu_Rect(UTSJSONObject([
        "x": width - 92,
        "y": 10 as NSNumber,
        "w": 80 as NSNumber,
        "h": 30 as NSNumber
    ])), actionTitle != nil ? actionTitle! : "查看详情", 13, UIColor(red: 0.95, green: 0.45, blue: 0.1, alpha: 1), 1)
    actionLabel.textAlignment = NSTextAlignment.center
    actionLabel.backgroundColor = UIColor(red: 1, green: 0.94, blue: 0.88, alpha: 1)
    actionLabel.layer.cornerRadius = 6
    actionLabel.layer.masksToBounds = true
    var sourceLabel = makeLabel(xilu_Rect(UTSJSONObject([
        "x": 12 as NSNumber,
        "y": cardH - 28,
        "w": 160 as NSNumber,
        "h": 18 as NSNumber
    ])), meta!.metaSource(), 12, UIColor(red: 0.95, green: 0.45, blue: 0.1, alpha: 1), 1)
    var imageViews: Array<UIImageView> = []
    var urls = meta!.metaImageUrls()
    if (urls != nil) {
        if (isThree) {
            var gap: NSNumber = 10
            var perW = (width - 24 - gap * 2) / 3
            do {
                var i: NSNumber = 0
                while(i < urls!.length){
                    if (i >= 3) {
                        break
                    }
                    var img = UIImageView()
                    img.frame = xRect(12 + i * (perW + gap), 66, perW, 90)
                    img.contentMode = UIView.ContentMode.scaleAspectFill
                    img.clipsToBounds = true
                    loadRemoteImage(img, urls![i])
                    imageViews.push(img)
                    i++
                }
            }
        } else {
            var img = UIImageView()
            if (isSmall) {
                img.frame = xRect(12, 66, 130, 90)
            } else {
                img.frame = xRect(12, 66, width - 24, 120)
            }
            img.contentMode = UIView.ContentMode.scaleAspectFill
            img.clipsToBounds = true
            loadRemoteImage(img, urls!.length > 0 ? urls![0] : nil)
            imageViews.push(img)
        }
    }
    card.loadNativeCustomAd(with: meta!, metaLogo: meta!.metaLogo(), closeBtn: closeBtn, imgViews: imageViews, iconImageView: iconView, actionLabel: actionLabel, titleLabel: titleLabel, sourceLabel: sourceLabel, contentLabel: descLabel)
    var clickViews = [
        iconView,
        titleLabel,
        descLabel,
        actionLabel,
        sourceLabel
    ] as! Array<UIView>
    do {
        var i: NSNumber = 0
        while(i < imageViews.length){
            clickViews.push(imageViews[i])
            i++
        }
    }
    card.showNativeAd(withClick: clickViews, presentVC: vc)
    return card
}
public func buildGDTCard(_ data: GDTUnifiedNativeAdDataObject, _ vc: UIViewController, _ width: NSNumber) -> UIView? {
    if (!data.isAdValid) {
        return nil
    }
    var adView = GDTUnifiedNativeAdView()
    adView.frame = xRect(0, 0, width, 145)
    adView.viewController = vc
    adView.mediaView.frame = adView.bounds
    var clickables: Array<UIView> = []
    adView.registerDataObject(data, clickableViews: clickables)
    return adView
}
@objc(UTSSDKModulesZynXiluAdBaseAdDelegate)
@objcMembers
public class BaseAdDelegate : NSObject, ADXiluBaseAdDelegate {
    internal var events: XiluAdEvents
    public init(_ events: XiluAdEvents){
        self.events = events
        super.init()
    }
    public func xilu_AdDidReceive(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        console.log("""
[zyn-xiluAd] 广告加载成功 posId=\(xiluAd.adPosId) 渠道=\(platformName(adInfo.platform)) adId=\(adInfo.adId) priority=\(adInfo.priority) isReady=\(adInfo.isReady)
""")
        runOnMain({
        () -> Void in
        self.events.onReceive?()
        })
    }
    public func xilu_AdDidFail(_ xiluAd: ADXiluBaseAd, error: ADXiluError) -> Void {
        var msg = """
[code=\(error.code)] \(error.message)
"""
        console.log("""
[zyn-xiluAd] 广告加载失败 posId=\(xiluAd.adPosId) code=\(error.code) message=\(error.message) description=\(error.description)
""")
        runOnMain({
        () -> Void in
        self.events.onFail?(msg)
        })
    }
    public func xilu_AdDidClick(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.events.onClick?()
        })
    }
    public func xilu_AdDidClose(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.events.onClose?()
        })
    }
    public func xilu_AdWillClose(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {}
    public func xilu_AdDidExpose(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.events.onExpose?()
        })
    }
    public func xilu_AdDidSkip(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.events.onSkip?()
        })
    }
    public func xilu_AdDidReward(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {}
    public func xilu_AdTick(_ xiluAd: ADXiluBaseAd, remainingTime: Double) -> Void {
        runOnMain({
        () -> Void in
        self.events.onTick?(remainingTime as! NSNumber)
        })
    }
}
@objc(UTSSDKModulesZynXiluAdRewardVideoDelegate)
@objcMembers
public class RewardVideoDelegate : BaseAdDelegate, ADXiluRewardVodAdDelegate {
    public func xilu_AdVideoDidCache(_ rewardVodAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {}
    public func xilu_AdVideoDidComplete(_ rewardVodAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.events.onVideoComplete?()
        })
    }
    public func xilu_AdVideoDidError(_ rewardVodAd: ADXiluBaseAd, adInfo: ADXiluAdInfo, error: ADXiluError) -> Void {
        var msg = error.message
        runOnMain({
        () -> Void in
        self.events.onFail?(msg)
        })
    }
    public override func xilu_AdDidReward(_ rewardVodAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.events.onReward?()
        })
    }
}
@objc(UTSSDKModulesZynXiluAdNativeAdDelegate)
@objcMembers
public class NativeAdDelegate : BaseAdDelegate {
    private var isTemplate: Bool = false
    public init(_ events: XiluAdEvents, _ isTemplate: Bool){
        self.isTemplate = isTemplate
        super.init(events)
    }
    public override func xilu_AdDidReceive(_ xiluAd: ADXiluBaseAd, adInfo: ADXiluAdInfo) -> Void {
        runOnMain({
        () -> Void in
        self.appendAdInfo(adInfo)
        self.events.onReceive?()
        })
    }
    public func xilu_AdDidReceiveMuti(_ xiluAd: ADXiluBaseAd, adInfos: Array<ADXiluAdInfo>) -> Void {
        runOnMain({
        () -> Void in
        do {
            var i: NSNumber = 0
            while(i < adInfos.length){
                self.appendAdInfo(adInfos[i])
                i++
            }
        }
        self.events.onReceive?()
        })
    }
    private func appendAdInfo(_ adInfo: ADXiluAdInfo) -> Void {
        var container = nativeContainer
        if (container == nil) {
            return
        }
        var width = screenWidth()
        var adViewAny = adInfo.extraData["nativeAdView"]
        if (UTSiOS.instanceof(adViewAny, UIView.self)) {
            var adView = adViewAny as! UIView
            var h: NSNumber = 300
            adView.frame = xRect(0, nativeContentY, width, h)
            container!.addSubview(adView)
            nativeContentY += h + 8
            container!.contentSize = xSize(width, nativeContentY)
            return
        }
        var dataAny = adInfo.extraData["nativeAdData"]
        var vc = getTopViewController()
        if (UTSiOS.instanceof(dataAny, MSNativeFeedAdModel.self) && vc != nil) {
            var card = buildMSCard(dataAny as! MSNativeFeedAdModel, vc!, width)
            if (card != nil) {
                card!.frame = xRect(0, nativeContentY, width, num(card!.frame.size.height))
                container!.addSubview(card!)
                nativeContentY += num(card!.frame.size.height) + 8
                container!.contentSize = xSize(width, nativeContentY)
                return
            }
        }
        if (UTSiOS.instanceof(dataAny, GDTUnifiedNativeAdDataObject.self) && vc != nil) {
            var card = buildGDTCard(dataAny as! GDTUnifiedNativeAdDataObject, vc!, width)
            if (card != nil) {
                card!.frame = xRect(0, nativeContentY, width, 145)
                container!.addSubview(card!)
                nativeContentY += 153
                container!.contentSize = xSize(width, nativeContentY)
                return
            }
        }
        if (!self.isTemplate) {
            var tip = makeTipView(width, "该平台自渲染广告需按平台 API 自行绘制")
            tip.frame = xRect(0, nativeContentY, width, 44)
            container!.addSubview(tip)
            nativeContentY += 52
            container!.contentSize = xSize(width, nativeContentY)
        }
    }
}
public var splashAd: ADXiluSplashAd? = nil
public var splashDelegate: BaseAdDelegate? = nil
public var bannerAd: ADXiluBannerAd? = nil
public var bannerDelegate: BaseAdDelegate? = nil
public var bannerContainer: UIView? = nil
public var interstitialAd: ADXiluInterstitialAd? = nil
public var interstitialDelegate: BaseAdDelegate? = nil
public var rewardVideoAd: ADXiluRewardVodAd? = nil
public var rewardVideoDelegate: RewardVideoDelegate? = nil
public var nativeAd: ADXiluNativeAd? = nil
public var nativeDelegate: NativeAdDelegate? = nil
public var nativeContainer: UIScrollView? = nil
public var nativeContentY: NSNumber = 0
public func keepAlive(_ spreadRefs: Any...) -> Void {
    var refs = Array(spreadRefs)
    if (refs.length < 0) {
        console.log("")
    }
}
public func removeView(_ view: UIView?) -> Void {
    if (view != nil) {
        view!.removeFromSuperview()
    }
}
public func clearNativeContainer() -> Void {
    removeView(nativeContainer)
    nativeContainer = nil
    nativeContentY = 0
}
public var initSDK = {
(_ options: XiluInitOptions) -> Void in
var manager = ADXiluSDKManager.shared
if (manager.isInitialized) {
    options.success?("SDK 已初始化")
    options.complete?()
    return
}
var debug = options.debug ?? false
manager.initialize(appId: options.appId, debug: debug, useSDKAudioSessionSetting: false, completion: {
(_ success: Bool, _ message: String?) -> Void in
runOnMain({
() -> Void in
if (success) {
    options.success?(message != nil ? message! : "SDK 初始化成功")
} else {
    options.fail?(message != nil ? message! : "SDK 初始化失败")
}
options.complete?()
})
})
}
public var isInitialized = {
() -> Bool in
return ADXiluSDKManager.shared.isInitialized
}
public var loadSplashAd = {
(_ options: XiluLoadAdOptions) -> Void in
runOnMain({
() -> Void in
var events = options.events ?? (XiluAdEvents(UTSJSONObject([:])))
if (!isInitialized()) {
    events.onFail?("SDK 未初始化")
    return
}
splashAd?.p_release()
splashAd = nil
var adSize = ADXiluAdSize.screenSize
var ad = ADXiluSplashAd(adPosId: options.posId, style: ADXiluSplashAdStyle.fullScreen, adSize: adSize)
ad.countdownDuration = 5
var delegate = BaseAdDelegate(events)
ad.delegate = delegate
splashAd = ad
splashDelegate = delegate
ad.loadAd()
var originReceive = events.onReceive
events.onReceive = {
() -> Void in
runOnMain({
() -> Void in
ad.showAd()
originReceive?()
})
}
})
}
public var loadBannerAd = {
(_ options: XiluLoadAdOptions) -> Void in
console.log("""
[zyn-xiluAd] loadBannerAd 被调用 posId=\(options.posId) height=\(options.height ?? 60) top=\(options.top ?? -1)
""")
runOnMain({
() -> Void in
var events = options.events ?? (XiluAdEvents(UTSJSONObject([:])))
if (!isInitialized()) {
    console.log("[zyn-xiluAd] Banner 加载中止：SDK 未初始化，请先调用 initSDK")
    events.onFail?("SDK 未初始化")
    return
}
var win = getKeyWindow()
var vc = getTopViewController()
console.log("""
[zyn-xiluAd] Banner 环境检查 win=\(win != nil) vc=\(vc != nil) 主线程=\(Thread.isMainThread)
""")
if (win == nil || vc == nil) {
    console.log("[zyn-xiluAd] Banner 加载中止：无法获取 keyWindow 或顶层 ViewController")
    events.onFail?("无法获取窗口")
    return
}
bannerAd?.p_release()
removeView(bannerContainer)
bannerAd = nil
bannerContainer = nil
var width = options.width ?? screenWidth()
var left = options.left ?? 0
var height = options.height ?? 60
var bottom = safeAreaBottom()
var top = options.top ?? (screenHeight() - height - bottom)
console.log("""
[zyn-xiluAd] Banner 布局参数 left=\(left) width=\(width) height=\(height) top=\(top) bottomSafe=\(bottom) screenH=\(screenHeight())
""")
var container = UIView()
container.frame = xRect(left, top, width, height)
container.backgroundColor = UIColor.white
win!.addSubview(container)
var adSize = ADXiluAdSize(width: cgf(width), height: cgf(height))
console.log("""
[zyn-xiluAd] 构建 ADXiluBannerAd posId=\(options.posId) adSize=\(num(adSize.width))x\(num(adSize.height))
""")
var ad = ADXiluBannerAd(adPosId: options.posId, adSize: adSize)
ad.showCloseBtn = true
ad.containerView = container
ad.nativeViewController = vc
var delegate = BaseAdDelegate(events)
ad.delegate = delegate
bannerAd = ad
bannerDelegate = delegate
bannerContainer = container
var originReceive = events.onReceive
events.onReceive = {
() -> Void in
runOnMain({
() -> Void in
console.log("[zyn-xiluAd] Banner 加载成功回调，调用 showAd(in:) 展示到容器")
ad.showAd(in: container)
originReceive?()
})
}
var originClose = events.onClose
events.onClose = {
() -> Void in
runOnMain({
() -> Void in
console.log("[zyn-xiluAd] Banner 被关闭，移除悬浮容器")
removeView(bannerContainer)
bannerContainer = nil
originClose?()
})
}
console.log("[zyn-xiluAd] 调用 bannerAd.loadAd()，等待渠道返回（结果见“广告加载成功/失败”日志）")
ad.loadAd()
})
}
public var loadInterstitialAd = {
(_ options: XiluLoadAdOptions) -> Void in
runOnMain({
() -> Void in
var events = options.events ?? (XiluAdEvents(UTSJSONObject([:])))
if (!isInitialized()) {
    events.onFail?("SDK 未初始化")
    return
}
var vc = getTopViewController()
if (vc == nil) {
    events.onFail?("无法获取 ViewController")
    return
}
interstitialAd?.p_release()
interstitialAd = nil
var ad = ADXiluInterstitialAd(adPosId: options.posId, adSize: ADXiluAdSize.screenSize, rootVC: vc)
var delegate = BaseAdDelegate(events)
ad.delegate = delegate
interstitialAd = ad
interstitialDelegate = delegate
var originReceive = events.onReceive
events.onReceive = {
() -> Void in
runOnMain({
() -> Void in
ad.showAd(from: vc!)
originReceive?()
})
}
ad.loadAd()
})
}
public var loadRewardVideoAd = {
(_ options: XiluLoadAdOptions) -> Void in
runOnMain({
() -> Void in
var events = options.events ?? (XiluAdEvents(UTSJSONObject([:])))
if (!isInitialized()) {
    events.onFail?("SDK 未初始化")
    return
}
var vc = getTopViewController()
if (vc == nil) {
    events.onFail?("无法获取 ViewController")
    return
}
rewardVideoAd?.p_release()
rewardVideoAd = nil
var ad = ADXiluRewardVodAd(adPosId: options.posId)
ad.isMuted = false
var delegate = RewardVideoDelegate(events)
ad.delegate = delegate
ad.videoDelegate = delegate
rewardVideoAd = ad
rewardVideoDelegate = delegate
var originReceive = events.onReceive
events.onReceive = {
() -> Void in
runOnMain({
() -> Void in
ad.showAd(from: vc!)
originReceive?()
})
}
ad.loadAd()
})
}
public func loadNativeAdInternal(_ options: XiluLoadAdOptions, _ isTemplate: Bool) -> Void {
    runOnMain({
    () -> Void in
    var events = options.events ?? (XiluAdEvents(UTSJSONObject([:])))
    if (!isInitialized()) {
        events.onFail?("SDK 未初始化")
        return
    }
    var win = getKeyWindow()
    var vc = getTopViewController()
    if (win == nil || vc == nil) {
        events.onFail?("无法获取窗口")
        return
    }
    nativeAd?.p_release()
    clearNativeContainer()
    nativeAd = nil
    var width = screenWidth()
    var top = options.top ?? 140
    var height = options.height ?? (screenHeight() - top - safeAreaBottom())
    var container = UIScrollView()
    container.frame = xRect(0, top, width, height)
    container.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    container.showsVerticalScrollIndicator = true
    container.contentSize = xSize(width, 0)
    win!.addSubview(container)
    nativeContainer = container
    var adSize = ADXiluAdSize(width: cgf(width), height: 300)
    var count = options.count ?? 3
    var ad = ADXiluNativeAd(adPosId: options.posId, adSize: adSize, count: cgi(count))
    ad.isTemplate = isTemplate
    ad.nativeViewController = vc
    var delegate = NativeAdDelegate(events, isTemplate)
    ad.delegate = delegate
    nativeAd = ad
    nativeDelegate = delegate
    var originClose = events.onClose
    events.onClose = {
    () -> Void in
    runOnMain({
    () -> Void in
    clearNativeContainer()
    originClose?()
    })
    }
    ad.loadAd()
    })
}
public var loadNativeTemplateAd = {
(_ options: XiluLoadAdOptions) -> Void in
loadNativeAdInternal(options, true)
}
public var loadNativeRenderAd = {
(_ options: XiluLoadAdOptions) -> Void in
loadNativeAdInternal(options, false)
}
public var destroyAd = {
(_ type: String) -> Void in
runOnMain({
() -> Void in
keepAlive(splashDelegate, bannerDelegate, interstitialDelegate, rewardVideoDelegate, nativeDelegate)
if (type == "splash") {
    splashAd?.p_release()
    splashAd = nil as ADXiluSplashAd?
    splashDelegate = nil as BaseAdDelegate?
} else if (type == "banner") {
    bannerAd?.p_release()
    removeView(bannerContainer)
    bannerAd = nil as ADXiluBannerAd?
    bannerContainer = nil as UIView?
    bannerDelegate = nil as BaseAdDelegate?
} else if (type == "interstitial") {
    interstitialAd?.p_release()
    interstitialAd = nil as ADXiluInterstitialAd?
    interstitialDelegate = nil as BaseAdDelegate?
} else if (type == "rewardVideo") {
    rewardVideoAd?.p_release()
    rewardVideoAd = nil as ADXiluRewardVodAd?
    rewardVideoDelegate = nil as RewardVideoDelegate?
} else if (type == "native") {
    nativeAd?.p_release()
    clearNativeContainer()
    nativeAd = nil as ADXiluNativeAd?
    nativeDelegate = nil as NativeAdDelegate?
}
})
}
@objc(UTSSDKModulesZynXiluAdXiluInitOptionsJSONObject)
@objcMembers
public class XiluInitOptionsJSONObject : NSObject {
    public var appId: String!
    public var debug: Bool = false
    public var success: UTSCallback?
    public var fail: UTSCallback?
    public var complete: UTSCallback?
}
@objc(UTSSDKModulesZynXiluAdXiluAdEventsJSONObject)
@objcMembers
public class XiluAdEventsJSONObject : NSObject {
    public var onReceive: UTSCallback?
    public var onFail: UTSCallback?
    public var onClick: UTSCallback?
    public var onClose: UTSCallback?
    public var onExpose: UTSCallback?
    public var onSkip: UTSCallback?
    public var onTick: UTSCallback?
    public var onReward: UTSCallback?
    public var onVideoComplete: UTSCallback?
}
@objc(UTSSDKModulesZynXiluAdXiluLoadAdOptionsJSONObject)
@objcMembers
public class XiluLoadAdOptionsJSONObject : NSObject {
    public var posId: String!
    public var top: NSNumber?
    public var left: NSNumber?
    public var width: NSNumber?
    public var height: NSNumber?
    public var count: NSNumber?
    public var events: XiluAdEventsJSONObject?
}
public func initSDKByJs(_ options: XiluInitOptionsJSONObject) -> Void {
    return initSDK(XiluInitOptions(UTSJSONObject([
        "appId": options.appId,
        "debug": options.debug,
        "success": {
        (message: String) -> Void in
        options.success?(message)
        },
        "fail": {
        (errMsg: String) -> Void in
        options.fail?(errMsg)
        },
        "complete": {
        () -> Void in
        options.complete?()
        }
    ])))
}
public func isInitializedByJs() -> Bool {
    return isInitialized()
}
public func loadSplashAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
    var events = options.events
    return loadSplashAd(XiluLoadAdOptions(UTSJSONObject([
        "posId": options.posId,
        "top": options.top,
        "left": options.left,
        "width": options.width,
        "height": options.height,
        "count": options.count,
        "events": events != nil ? XiluAdEvents(UTSJSONObject([
            "onReceive": {
            () -> Void in
            events!.onReceive?()
            },
            "onFail": {
            (message: String) -> Void in
            events!.onFail?(message)
            },
            "onClick": {
            () -> Void in
            events!.onClick?()
            },
            "onClose": {
            () -> Void in
            events!.onClose?()
            },
            "onExpose": {
            () -> Void in
            events!.onExpose?()
            },
            "onSkip": {
            () -> Void in
            events!.onSkip?()
            },
            "onTick": {
            (remaining: NSNumber) -> Void in
            events!.onTick?(remaining)
            },
            "onReward": {
            () -> Void in
            events!.onReward?()
            },
            "onVideoComplete": {
            () -> Void in
            events!.onVideoComplete?()
            }
        ])) : nil
    ])))
}
public func loadBannerAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
    var events = options.events
    return loadBannerAd(XiluLoadAdOptions(UTSJSONObject([
        "posId": options.posId,
        "top": options.top,
        "left": options.left,
        "width": options.width,
        "height": options.height,
        "count": options.count,
        "events": events != nil ? XiluAdEvents(UTSJSONObject([
            "onReceive": {
            () -> Void in
            events!.onReceive?()
            },
            "onFail": {
            (message: String) -> Void in
            events!.onFail?(message)
            },
            "onClick": {
            () -> Void in
            events!.onClick?()
            },
            "onClose": {
            () -> Void in
            events!.onClose?()
            },
            "onExpose": {
            () -> Void in
            events!.onExpose?()
            },
            "onSkip": {
            () -> Void in
            events!.onSkip?()
            },
            "onTick": {
            (remaining: NSNumber) -> Void in
            events!.onTick?(remaining)
            },
            "onReward": {
            () -> Void in
            events!.onReward?()
            },
            "onVideoComplete": {
            () -> Void in
            events!.onVideoComplete?()
            }
        ])) : nil
    ])))
}
public func loadInterstitialAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
    var events = options.events
    return loadInterstitialAd(XiluLoadAdOptions(UTSJSONObject([
        "posId": options.posId,
        "top": options.top,
        "left": options.left,
        "width": options.width,
        "height": options.height,
        "count": options.count,
        "events": events != nil ? XiluAdEvents(UTSJSONObject([
            "onReceive": {
            () -> Void in
            events!.onReceive?()
            },
            "onFail": {
            (message: String) -> Void in
            events!.onFail?(message)
            },
            "onClick": {
            () -> Void in
            events!.onClick?()
            },
            "onClose": {
            () -> Void in
            events!.onClose?()
            },
            "onExpose": {
            () -> Void in
            events!.onExpose?()
            },
            "onSkip": {
            () -> Void in
            events!.onSkip?()
            },
            "onTick": {
            (remaining: NSNumber) -> Void in
            events!.onTick?(remaining)
            },
            "onReward": {
            () -> Void in
            events!.onReward?()
            },
            "onVideoComplete": {
            () -> Void in
            events!.onVideoComplete?()
            }
        ])) : nil
    ])))
}
public func loadRewardVideoAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
    var events = options.events
    return loadRewardVideoAd(XiluLoadAdOptions(UTSJSONObject([
        "posId": options.posId,
        "top": options.top,
        "left": options.left,
        "width": options.width,
        "height": options.height,
        "count": options.count,
        "events": events != nil ? XiluAdEvents(UTSJSONObject([
            "onReceive": {
            () -> Void in
            events!.onReceive?()
            },
            "onFail": {
            (message: String) -> Void in
            events!.onFail?(message)
            },
            "onClick": {
            () -> Void in
            events!.onClick?()
            },
            "onClose": {
            () -> Void in
            events!.onClose?()
            },
            "onExpose": {
            () -> Void in
            events!.onExpose?()
            },
            "onSkip": {
            () -> Void in
            events!.onSkip?()
            },
            "onTick": {
            (remaining: NSNumber) -> Void in
            events!.onTick?(remaining)
            },
            "onReward": {
            () -> Void in
            events!.onReward?()
            },
            "onVideoComplete": {
            () -> Void in
            events!.onVideoComplete?()
            }
        ])) : nil
    ])))
}
public func loadNativeTemplateAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
    var events = options.events
    return loadNativeTemplateAd(XiluLoadAdOptions(UTSJSONObject([
        "posId": options.posId,
        "top": options.top,
        "left": options.left,
        "width": options.width,
        "height": options.height,
        "count": options.count,
        "events": events != nil ? XiluAdEvents(UTSJSONObject([
            "onReceive": {
            () -> Void in
            events!.onReceive?()
            },
            "onFail": {
            (message: String) -> Void in
            events!.onFail?(message)
            },
            "onClick": {
            () -> Void in
            events!.onClick?()
            },
            "onClose": {
            () -> Void in
            events!.onClose?()
            },
            "onExpose": {
            () -> Void in
            events!.onExpose?()
            },
            "onSkip": {
            () -> Void in
            events!.onSkip?()
            },
            "onTick": {
            (remaining: NSNumber) -> Void in
            events!.onTick?(remaining)
            },
            "onReward": {
            () -> Void in
            events!.onReward?()
            },
            "onVideoComplete": {
            () -> Void in
            events!.onVideoComplete?()
            }
        ])) : nil
    ])))
}
public func loadNativeRenderAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
    var events = options.events
    return loadNativeRenderAd(XiluLoadAdOptions(UTSJSONObject([
        "posId": options.posId,
        "top": options.top,
        "left": options.left,
        "width": options.width,
        "height": options.height,
        "count": options.count,
        "events": events != nil ? XiluAdEvents(UTSJSONObject([
            "onReceive": {
            () -> Void in
            events!.onReceive?()
            },
            "onFail": {
            (message: String) -> Void in
            events!.onFail?(message)
            },
            "onClick": {
            () -> Void in
            events!.onClick?()
            },
            "onClose": {
            () -> Void in
            events!.onClose?()
            },
            "onExpose": {
            () -> Void in
            events!.onExpose?()
            },
            "onSkip": {
            () -> Void in
            events!.onSkip?()
            },
            "onTick": {
            (remaining: NSNumber) -> Void in
            events!.onTick?(remaining)
            },
            "onReward": {
            () -> Void in
            events!.onReward?()
            },
            "onVideoComplete": {
            () -> Void in
            events!.onVideoComplete?()
            }
        ])) : nil
    ])))
}
public func destroyAdByJs(_ type: String) -> Void {
    return destroyAd(type)
}
@objc(UTSSDKModulesZynXiluAdIndexSwift)
@objcMembers
public class UTSSDKModulesZynXiluAdIndexSwift : NSObject {
    public static func s_initSDKByJs(_ options: XiluInitOptionsJSONObject) -> Void {
        return initSDKByJs(options)
    }
    public static func s_isInitializedByJs() -> Bool {
        return isInitializedByJs()
    }
    public static func s_loadSplashAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
        return loadSplashAdByJs(options)
    }
    public static func s_loadBannerAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
        return loadBannerAdByJs(options)
    }
    public static func s_loadInterstitialAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
        return loadInterstitialAdByJs(options)
    }
    public static func s_loadRewardVideoAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
        return loadRewardVideoAdByJs(options)
    }
    public static func s_loadNativeTemplateAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
        return loadNativeTemplateAdByJs(options)
    }
    public static func s_loadNativeRenderAdByJs(_ options: XiluLoadAdOptionsJSONObject) -> Void {
        return loadNativeRenderAdByJs(options)
    }
    public static func s_destroyAdByJs(_ type: String) -> Void {
        return destroyAdByJs(type)
    }
}
