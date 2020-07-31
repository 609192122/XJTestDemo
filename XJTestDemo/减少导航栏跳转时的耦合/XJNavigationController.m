//
//  XJNavigationController.m
//  XJTestDemo
//
//  Created by mac on 2020/7/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "XJNavigationController.h"
#import "objc/runtime.h"

static void *paramsKey      = &paramsKey;
static void *replyActionKey = &replyActionKey;
static void *mainNavigationKey = &mainNavigationKey;

@implementation XJ_Node

@end


@implementation UIViewController (URL)

- (id)setupNode:(XJ_Params)action {
    XJ_Node *node = [XJ_Node new];
    node.animate = YES; // 默认使用动画
    node.isNav = NO;
    action(node);
    
    return node;
}

/*
- (instancetype)initWithParams:(id)params {

    return [self initWithParams:params replyAction:nil];
}

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithParams:(id)params replyAction:(XJ_ReplyAction)replyAction {
    //present的时候有问题，不知道为什么
    self = [super init];
    if ( self ) {
        
        self.xj_params = params;
        
        self.xj_replyAction = replyAction;
        
    }
    
    return self;
}
*/

#pragma mark - ----------- PUSH ------------
- (void)xj_pushSimpleViewController:(NSString *)clsName {
    [self xj_pushViewController:^(XJ_Node *node) {
        node.clsName = clsName;
    }];
}

- (void)xj_pushViewController:(XJ_Params)params {

    XJ_Node *node = [self setupNode:params];
    Class vcClass = [XJNavigationController findViewControllerClassWithClsName:node.clsName];
    if ( !vcClass ) {
        NSAssert(NO, XJ_NSStringFormat(@"clsName:%@ not register", node.clsName));
    }
    UIViewController *controller = [self customViewCtrWithClass:vcClass XJ_Node:node];
    
    UINavigationController *nav = (UINavigationController *)objc_getAssociatedObject([XJNavigationController shareXJNavigationController], mainNavigationKey);
    [nav?nav:[XJNavigationController shareXJNavigationController] pushViewController:controller animated:node.animate];
}

#pragma mark - ----------- POP ------------
- (void)xj_popViewController {
    [self xj_popViewControllerAnimate:YES];
}

- (void)xj_popViewControllerAnimate:(BOOL)animated {
    UINavigationController *nav = (UINavigationController *)objc_getAssociatedObject([XJNavigationController shareXJNavigationController], mainNavigationKey);
    [nav?nav:[XJNavigationController shareXJNavigationController] popViewControllerAnimated:animated];
}

- (void)xj_popToRootViewControllerAnimated:(BOOL)animated {
    UINavigationController *nav = (UINavigationController *)objc_getAssociatedObject(self, mainNavigationKey);
    [nav popToRootViewControllerAnimated:animated];
}

- (void)xj_popToViewControllerWithClsName:(NSString *)clsName animated:(BOOL)animated {
    UIViewController *vc = [XJNavigationController findViewControllerIfExistWithClsName:clsName];
    if ( vc ) {
        UINavigationController *nav = (UINavigationController *)objc_getAssociatedObject(self, mainNavigationKey);
        [nav pushViewController:vc animated:animated];
    }
}

#pragma mark - ----------- 控制器初始化 ------------
- (UIViewController *)customViewCtrWithClass:(Class)vcClass XJ_Node:(XJ_Node *)node{
    UIViewController *controller = [[vcClass alloc] init];
    controller.xj_params = node.params;
    controller.xj_replyAction = node.replyAction;
    controller.title = node.title;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    controller.navigationItem.backBarButtonItem = backItem;
    controller.hidesBottomBarWhenPushed = YES;
    
    return controller;
}

- (void)back{
    if (self.presentedViewController) {
        [self xj_dismissSimpleViewController];
    }else{
        [self xj_popViewController];
    }
}

#pragma mark - ----------- PRESENT ------------
- (void)xj_presentViewController:(XJ_Params)params {

    XJ_Node *node = [self setupNode:params];
    
    Class vcClass = [XJNavigationController findViewControllerClassWithClsName:node.clsName];
    if ( !vcClass ) {
        NSAssert(NO, XJ_NSStringFormat(@"clsName:%@ not register", node.clsName));
    }
    UIViewController *controller = [self customViewCtrWithClass:vcClass XJ_Node:node];
    if (node.isNav) {
        UINavigationController *nvc = [[[[XJNavigationController shareXJNavigationController] class] alloc] initWithRootViewController:controller];
        nvc.modalPresentationStyle = UIModalPresentationFullScreen;
        objc_setAssociatedObject([XJNavigationController shareXJNavigationController], mainNavigationKey, nvc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self presentViewController:nvc animated:node.animate completion:node.completeAction];
        
        return;
    }
    
    [self presentViewController:controller animated:node.animate completion:node.completeAction];
}

- (void)xj_presentSimpleViewController:(NSString *)clsName {
    
    [self xj_presentViewController:^(XJ_Node *node) {
        node.clsName = clsName;
    }];
}

#pragma mark - ----------- DISMISS ------------
- (void)xj_dismissSimpleViewController {
    [self xj_dismissViewControllerAnimated:YES completion:nil];
}

- (void)xj_dismissViewControllerAnimated:(BOOL)animated completion:(XJ_CompleteAction)completion {
    objc_setAssociatedObject([XJNavigationController shareXJNavigationController], mainNavigationKey, [XJNavigationController shareXJNavigationController], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self dismissViewControllerAnimated:animated completion:completion];
}

#pragma mark - ----------- 属性添加 getter/setter ------------
- (id)xj_params {
    return objc_getAssociatedObject(self, paramsKey);
}

- (void)setXj_params:(id)wb_params {
    objc_setAssociatedObject(self, paramsKey, wb_params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XJ_ReplyAction)xj_replyAction {
    return objc_getAssociatedObject(self, replyActionKey);
}

- (void)setXj_replyAction:(XJ_ReplyAction)xj_replyAction{
    objc_setAssociatedObject(self, replyActionKey, xj_replyAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end



@interface XJNavigationController ()

// 保存所有注册的ViewController的类与类名
@property (nonatomic, strong) NSMutableDictionary *registerVCCls;

@end

@implementation XJNavigationController

+ (instancetype)shareXJNavigationController {
    static XJNavigationController *navigationController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navigationController = [[XJNavigationController alloc] init];
    });
    return navigationController;
}

// 注册一个ViewController到导航栏
+ (void)registerWithClsName:(NSString *)clsName viewControllerClass:(Class)cls {
    [XJNavigationController shareXJNavigationController].registerVCCls[clsName] = cls;
}

// 移除导航栏中一个ViewController的实例
+ (void)removeViewControllerWithClsName:(NSString *)clsName {
    NSMutableArray *viewControllers = [[XJNavigationController shareXJNavigationController].viewControllers mutableCopy];
    UIViewController *targetVC = [[self class] findViewControllerIfExistWithClsName:clsName];
    if ( [viewControllers containsObject:targetVC] ) {
        [viewControllers removeObject:targetVC];
    }
    
    [XJNavigationController shareXJNavigationController].viewControllers = viewControllers;
}

// 根据url查找ViewController的类名
+ (Class)findViewControllerClassWithClsName:(NSString *)clsName {
    return [XJNavigationController shareXJNavigationController].registerVCCls[clsName];
}

// 导航栏中是否存在ViewController的实例
+ (BOOL)existViewControllerWithClsName:(NSString *)clsName {

    NSMutableArray *viewControllers = [[XJNavigationController shareXJNavigationController].viewControllers mutableCopy];
    UIViewController *targetVC = [[self class] findViewControllerIfExistWithClsName:clsName];
    
    if ( [viewControllers containsObject:targetVC] ) {
        return YES;
    }
    
    return NO;
}

// 获取导航栏中的ViewController的实例
+ (UIViewController *)findViewControllerIfExistWithClsName:(NSString *)clsName {

    Class vcClassName = [[self class] findViewControllerClassWithClsName:clsName];
    for (UIViewController *vc in [XJNavigationController shareXJNavigationController].viewControllers) {
        if ( vcClassName == vc.class ) {
            return vc;
        }
    }
    
    return nil;
}

// 取消注册
+ (void)deregisterClsName:(NSString *)clsName {
    
    [[XJNavigationController shareXJNavigationController].registerVCCls removeObjectForKey:clsName];
}

- (NSMutableDictionary *)registerVCCls {
    if(!_registerVCCls) {
        _registerVCCls = [@{} mutableCopy];
    }
    return _registerVCCls;
}

@end
