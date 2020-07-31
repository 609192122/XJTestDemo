//
//  XJConst.h
//  XJTestDemo
//
//  Created by mac on 2020/7/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 字体*/
#define XJ_Font(x) [UIFont systemFontOfSize:x]
/** 字符串是否为空*/
#define XJ_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 ? YES : NO )
/** 数组是否为空*/
#define XJ_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
/** 字典是否为空*/
#define XJ_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
/** 是否是空对象*/
#define XJ_ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
/** 转字符串*/
#define XJ_NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

/** 获取沙盒Document路径*/
#define XJ_DocumentPath(path) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:path]
/** 获取沙盒temp路径*/
#define XJ_TempPath(path) [NSTemporaryDirectory() stringByAppendingPathComponent:path]
/** 获取沙盒Cache路径*/
#define XJ_CachePath(path) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:path]

/** 开发的时候打印，但是发布的时候不打印的NSLog*/
#ifdef DEBUG
//#define NSLog(FORMAT, ...) {\
NSString *str = [[FCTools cachedDateFormatterWithStr:@"yyyy-MM-dd HH:mm:ss.SSSS"] stringFromDate:[NSDate date]];\
fprintf(stderr,"%s %s [Line:%d] %s\n", [str UTF8String], [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);}

//#define NSLog(FORMAT, ...) fprintf(stderr,"第%d行 \n %s\n", __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
//#define NSLog(FORMAT, ...) fprintf(stderr,"%s %s %s [Line: %d] %s\n", __DATE__, __TIME__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#define NSLog(...) NSLog(__VA_ARGS__)
//#define NSLog(...) NSLog(@"第%d行 \n %@\n\n", __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

/** 获取一段时间间隔*/
#define XJ_StartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define XJ_EndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

/** 颜色*/
#define XJ_RGBAColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define XJ_RGBAColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

/** 适配*/
#define XJ_iOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define XJ_iOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define XJ_iOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define XJ_iOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define XJ_iOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

/** 设备宽高*/
#define XJ_ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define XJ_ScreenHeight [[UIScreen mainScreen] bounds].size.height

// weakself strongself
#define XJ_Weakify(o)                __weak   typeof(self) fwwo = o;
#define XJ_Strongify(o)              __strong typeof(self) o = fwwo;

///导航高度
#define kNavBarHeight   (IS_iPhone_X ? 88 : 64)
///Tabar 高度
#define kTabbarHeight   (IS_iPhone_X ? 83 : 49)
///状态栏高度
#define kStatusBarHeight (IS_iPhone_X ? 44 : 20)
///顶部安全区
#define kSafeAreaTop (IS_iPhone_X ? 24 : 0)
///底部安全区
#define kSafeAreaBottom (IS_iPhone_X ? 34 : 0)


#define XJ_iPhone4_OR_4s    (SXSCREEN_H == 480)
#define XJ_iPhone5_OR_5c_OR_5s   (SXSCREEN_H == 568)
#define XJ_iPhone6_OR_6s   (SXSCREEN_H == 667)
#define XJ_iPhone6Plus_OR_6sPlus   (SXSCREEN_H == 736)
#define XJ_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define XJ_UserDefault [NSUserDefaults standardUserDefaults]
#define XJ_UserDefaultForKey(key) [XJ_UserDefault objectForKey:key]
#define XJ_UserDefaultSetKeyValue(key, value) [XJ_UserDefault setObject:value forKey:key]

#define XJ_NotificationCenter [NSNotificationCenter defaultCenter]

/** JSON解析*/
#define XJ_JSONSerialization(Data,Error) [NSJSONSerialization JSONObjectWithData:Data options:0 error:Error]

/** 图片*/
#define XJ_DefaultImage [UIImage imageNamed:@"defaultImage"]
#define XJ_SetImage(image) [UIImage imageNamed:image]

/** UIWindow*/
#define XJ_Keywindow [[UIApplication sharedApplication] keyWindow]


///类与对象
UIKIT_EXTERN NSString *const Cls_ClassViewController;
///多个cell事件解耦
UIKIT_EXTERN NSString *const Cls_MasterViewController;


