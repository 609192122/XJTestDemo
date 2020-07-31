//
//  XJNavigationController.h
//  XJTestDemo
//
//  Created by mac on 2020/7/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 快速注册viewcontroller
#undef    XJ_IMPLEMENT_LOAD
#define XJ_IMPLEMENT_LOAD(clsName) \
+ (void)load { \
@autoreleasepool { \
    [XJNavigationController registerWithClsName:clsName viewControllerClass:[self class]]; \
} \
}

@class XJ_Node;

typedef void (^__nullable XJ_ReplyAction)(id result);
typedef void (^__nullable XJ_CompleteAction)(void);
typedef void (^XJ_Params)(XJ_Node *node);

@interface XJ_Node : NSObject
///跳转的控制器注册名
@property (nonatomic, strong) NSString       *clsName;
///动画
@property (nonatomic, assign) BOOL           animate;
///导航栏控制器
@property (nonatomic, assign) BOOL           isNav;
///传值数据模型
@property (nonatomic, strong) id             params;
///控制器标题
@property (nonatomic, strong) NSString       *title;
///presentcompleteAction
@property (nonatomic, copy) XJ_CompleteAction completeAction;
///数据回传
@property (nonatomic, copy) XJ_ReplyAction    replyAction;

@end

@interface UIViewController (URL) <UIGestureRecognizerDelegate>
///传值数据模型
@property (nonatomic, strong) id             xj_params;
///数据回传
@property (nonatomic, copy) XJ_ReplyAction    xj_replyAction;

//- (instancetype)initWithParams:(id)params;
//- (instancetype)initWithParams:(id)params replyAction:(XJ_ReplyAction)replyAction;

- (void)xj_pushViewController:(XJ_Params)params;
- (void)xj_pushSimpleViewController:(NSString *)clsName;

- (void)xj_popViewController;
- (void)xj_popViewControllerAnimate:(BOOL)animated;
- (void)xj_popToRootViewControllerAnimated:(BOOL)animated;
- (void)xj_popToViewControllerWithClsName:(NSString *)clsName animated:(BOOL)animated;

- (void)xj_presentViewController:(XJ_Params)params;
- (void)xj_presentSimpleViewController:(NSString *)clsName;

- (void)xj_dismissSimpleViewController;
- (void)xj_dismissViewControllerAnimated:(BOOL)animated completion:(XJ_CompleteAction)completion;

@end

@interface XJNavigationController : UINavigationController

///单例初始化
+ (instancetype)shareXJNavigationController;

/// 注册一个ViewController到导航栏
+ (void)registerWithClsName:(NSString *)clsName viewControllerClass:(Class)cls;

/// 移除导航栏中一个ViewController的实例
+ (void)removeViewControllerWithClsName:(NSString *)clsName;

/// 根据url查找ViewController的类名
+ (Class)findViewControllerClassWithClsName:(NSString *)clsName;

/// 导航栏中是否存在ViewController的实例
+ (BOOL)existViewControllerWithClsName:(NSString *)clsName;

/// 获取导航栏中的ViewController的实例
+ (UIViewController *)findViewControllerIfExistWithClsName:(NSString *)clsName;

/// 取消注册
+ (void)deregisterClsName:(NSString *)clsName;

@end

NS_ASSUME_NONNULL_END
