//
//  NSObject+MethodSwizzling.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/22.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "NSObject+MethodSwizzling.h"

@implementation NSObject (MethodSwizzling)
+(void)MethodExchangeWithOriginMethod:(SEL)originSelector andSwizzlingMethod:(SEL)swizzlingSelector andIsInstanceMethod:(BOOL)isInstanceMethod
{
    Class class = [self class];
    Method originMethod;
    Method swizzlingMethod;
    //这里获取Method的时候，一定要注意SEL的类型，实例方法/类方法
    if (isInstanceMethod) {//实例方法
        originMethod = class_getInstanceMethod(class, originSelector);
        swizzlingMethod = class_getInstanceMethod(class, swizzlingSelector);
    } else { //类方法
        originMethod = class_getClassMethod(class, originSelector);
        swizzlingMethod = class_getClassMethod(class, swizzlingSelector);
    }
    //判断 originSel 方法是否实现
    //使用class_addMethod方法判断
    //class_addMethod向指定类中添加一个方法.
    //如果父类中有该方法，则会在该类中生成一个覆盖父类实现的方法.
    //如果该类中该方法已经存在，则返回NO.
    
    //把originSel的IMP指向目标方法实现
    
    // Method 结构
    // struct old_method {
    //    SEL method_name; //方法名
    //    char *method_types;//表示的是方法的返回值和参数类型
    //    IMP method_imp;//实现
    // };
    BOOL result = class_addMethod(class, originSelector, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    if (result) {//添加成功
        //把原始方法的实现IMP指向目标的方法
        //这里有疑问，此时获取originMethod.IMP 不就是上面新增的那个吗。
        //通过查看此时originMethod.IMP指向的信息，仍然是指向父类方法的实现，没有改变！
        class_replaceMethod(class, swizzlingSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {//说明原始方法存在 执行交换操作
        method_exchangeImplementations(originMethod, swizzlingMethod);
    }
    
}
@end
