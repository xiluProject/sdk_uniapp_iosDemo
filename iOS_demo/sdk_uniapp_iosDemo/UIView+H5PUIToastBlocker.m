#import "UIView+H5PUIToastBlocker.h"
#import <objc/runtime.h>

// 是否启用拦截（可在调试时临时关掉）
static BOOL gXiluToastBlockerEnabled = YES;

// 匹配到一次就缓存类名，避免每次 addSubview 都做字符串比较
static NSMutableSet<NSString *> *gXiluBlockedClassCache = nil;
static NSMutableSet<NSString *> *gXiluAllowedClassCache = nil;

// 判断一个类名是否属于要拦截的 DCloud Toast 家族
static BOOL XiluIsBlockedToastClass(Class cls) {
    if (!cls) return NO;
    NSString *clsName = NSStringFromClass(cls);
    if (clsName.length == 0) return NO;

    // 先查缓存
    if ([gXiluAllowedClassCache containsObject:clsName]) return NO;
    if ([gXiluBlockedClassCache containsObject:clsName]) return YES;

    // 未命中缓存，做字符串匹配（不区分大小写）
    NSString *lower = [clsName lowercaseString];
    BOOL blocked = NO;
    if ([lower containsString:@"puitoast"])        blocked = YES;
    else if ([lower containsString:@"h5puitoast"]) blocked = YES;
    else if ([lower containsString:@"h5puialert"]) blocked = YES;
    else if ([lower containsString:@"puialert"])   blocked = YES;
    else if ([lower containsString:@"puiloading"]) blocked = YES;
    else if ([lower containsString:@"h5uirichtextview"]) blocked = YES; // -9001 文字容器

    if (blocked) {
        [gXiluBlockedClassCache addObject:clsName];
    } else {
        [gXiluAllowedClassCache addObject:clsName];
    }
    return blocked;
}

@implementation UIView (H5PUIToastBlocker)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gXiluBlockedClassCache = [NSMutableSet set];
        gXiluAllowedClassCache = [NSMutableSet set];

        Class cls = [self class];
        SEL originalSel = @selector(addSubview:);
        SEL swizzledSel = @selector(xilu_addSubview:);

        Method originalMethod = class_getInstanceMethod(cls, originalSel);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);

        BOOL didAddMethod = class_addMethod(cls,
                                            originalSel,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(cls,
                                swizzledSel,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

        NSLog(@"[zyn-xiluAd] UIView.addSubview: 已 swizzle，H5PUIToast 拦截器生效");
    });
}

- (void)xilu_addSubview:(UIView *)view {
    Class viewCls = object_getClass(view);
        NSString *clsName = NSStringFromClass(viewCls);
        // 打印包含 "Pui" 或 "Toast" 的添加行为
        if ([clsName.lowercaseString containsString:@"pui"] ||
            [clsName.lowercaseString containsString:@"toast"]) {
            NSLog(@"[zyn-xiluAd] addSubview 观察: 父=%@ 子=%@",
                  NSStringFromClass([self class]), clsName);
        }
    if (gXiluToastBlockerEnabled && view) {
        Class viewCls = object_getClass(view); // 用真实类（防止 KVO 动态子类）
        if (XiluIsBlockedToastClass(viewCls)) {
            NSLog(@"[zyn-xiluAd] Runtime 拦截 H5PUIToast 添加: %@", NSStringFromClass(viewCls));
            return; // 关键：直接返回，不执行原始 addSubview
        }
    }
    // 注意：这里调用的是原始 addSubview:（已通过 swizzle 交换）
    [self xilu_addSubview:view];
}

@end
