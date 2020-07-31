//
//  ClassViewController.m
//  XJTestDemo
//
//  Created by mac on 2020/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ClassViewController.h"

#import "Person.h"
#import "objc/message.h"

@interface Student : Person
{
    int _no;
}

@end

@implementation Student

@end

@interface ClassViewController ()

@end

@implementation ClassViewController

XJ_IMPLEMENT_LOAD(Cls_ClassViewController)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"类与对象";
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"分配的内存空间：stu - %zd", class_getInstanceSize([Student class]));
    NSLog(@"分配的内存空间：person - %zd", class_getInstanceSize([Person class]));
    
    //实例对象
    NSObject *objc1 = [[NSObject alloc] init];
    NSObject *objc2 = [[NSObject alloc] init];
    //子类对象
    Class class1 = [objc1 class];
    Class class2 = [objc2 class];
    Class class3 = object_getClass(objc1);
    Class class4 = object_getClass(objc2);
    //父类
    Class class5 = [NSObject class];
    Class class6 = [[NSObject class] class];
    //元类
    Class class7 = object_getClass([NSObject class]);
    Class class8 = object_getClass([[NSObject class] class]);

    
    NSLog(@"实例对象：objc1 = %p", objc1);
    NSLog(@"实例对象：objc2 = %p", objc2);
    NSLog(@"子类对象：class1 = %p", class1);
    NSLog(@"子类对象：class2 = %p", class2);
    NSLog(@"子类对象：class3 = %p", class3);
    NSLog(@"子类对象：class4 = %p", class4);
    NSLog(@"父类对象：class5 = %p", class5);
    NSLog(@"父类对象：class6 = %p", class6);
    NSLog(@"元类对象：class7 = %p", class7);
    NSLog(@"元类对象：class8 = %p", class8);

    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, XJ_ScreenHeight)];
    label.numberOfLines = 0;
    label.text = @"class对象在内存中存储的信息包括：\n\
    1.isa指针\n\
    2.superclass指针\n\
    3.类的属性信息（@property），类的成员变量信息（ivar）\n\
    4.类的方法信息（method），类的协议信息（protocol）\n\
    \n\
    \n\
    \n\
    对isa、superclass总结\n\
    instance的isa指向class\n\
    class的isa指向meta-class\n\
    meta-class的isa指向基类的meta-class，基类的isa指向自己\n\
    class的superclass指向父类的class，如果没有父类，superclass指针为nil\n\
    meta-class的superclass指向父类的meta-class，基类的meta-class的superclass指向基类的class\n\
    instance调用对象方法的轨迹，isa找到class，方法不存在，就通过superclass找父类\n\
    class调用类方法的轨迹，isa找meta-class，方法不存在，就通过superclass找父类";
    
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self xj_pushSimpleViewController:Cls_MasterViewController];
}

@end
