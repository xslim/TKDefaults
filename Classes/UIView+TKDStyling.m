//
//  UIView+MOAStyling.m
//  MyOrderApp
//
//  Created by Angel Garcia on 11/12/13.
//  Copyright (c) 2013 MyOrder.nl. All rights reserved.
//

#import "UIView+TKDStyling.h"
#import <objc/runtime.h>


#ifndef COCOAPODS_POD_AVAILABLE_PixateFreestyle

@implementation UIView (TKDStyling)

- (void)setStyleClass:(NSString *)styleClass {
}
- (void)setStyleCSS:(NSString *)styleCSS {
}
-(void)setStyleId:(NSString *)styleId {
}
- (NSString *)styleClass {
    return nil;
}
-(NSString *)styleCSS {
    return nil;
}
-(NSString *)styleId {
    return nil;
}
- (void)updateStyles {
}
@end

#else

@protocol Custom_PXBoxModel <NSObject>
- (BOOL)hasCornerRadius;
- (CGSize)radiusTopLeft;
- (CGSize)radiusTopRight;
- (CGSize)radiusBottomRight;
- (CGSize)radiusBottomLeft;
@end

@protocol Custom_PXContext <NSObject>
- (id<Custom_PXBoxModel>)boxModel;
@end

@protocol Custom_PXUIView <NSObject>
- (void)updateStyleWithRuleSet:(id)rules context:(id<Custom_PXContext>)context;
- (void)customUpdateStyleWithRuleSet:(id)rules context:(id<Custom_PXContext>)context;
@end

static void PXUIView_updateStyleWithRuleSet(UIView<Custom_PXUIView> *self, SEL _cmd, id rules, id<Custom_PXContext>context) {
    [self customUpdateStyleWithRuleSet:rules context:context];
    
    //If corner radius
    id<Custom_PXBoxModel> boxModel = [context boxModel];
    if ([boxModel hasCornerRadius]) {
        //Check all radius are equal and change the cornerRadius property in my view
        CGSize radiusSize = [boxModel radiusTopLeft];
        if (CGSizeEqualToSize(radiusSize, [boxModel radiusTopRight]) &&
            CGSizeEqualToSize(radiusSize, [boxModel radiusBottomLeft]) &&
            CGSizeEqualToSize(radiusSize, [boxModel radiusBottomRight])) {
            self.layer.cornerRadius = radiusSize.height;
        }
    }
}

@implementation UIView (TKDtyling)

+ (void)load {
    
    //Get main classes
    Class c_PXUIView = NSClassFromString(@"PXUIView");
    Class c_PX_AT = NSClassFromString(@"PX_AT");
    Class c_PXBoxModel = NSClassFromString(@"PXBoxModel");
    if (c_PXUIView && c_PX_AT && c_PXBoxModel) {
        //Get all methods
        Method boxModel = class_getInstanceMethod(c_PX_AT, @selector(boxModel));
        Method hasCornerRadius = class_getInstanceMethod(c_PXBoxModel, @selector(hasCornerRadius));
        Method radiusTopLeft = class_getInstanceMethod(c_PXBoxModel, @selector(radiusTopLeft));
        Method radiusTopRight = class_getInstanceMethod(c_PXBoxModel, @selector(radiusTopRight));
        Method radiusBottomRight = class_getInstanceMethod(c_PXBoxModel, @selector(radiusBottomRight));
        Method radiusBottomLeft = class_getInstanceMethod(c_PXBoxModel, @selector(radiusBottomLeft));
        
        Method method = class_getInstanceMethod(c_PXUIView, @selector(updateStyleWithRuleSet:context:));
        if (method && boxModel && hasCornerRadius && radiusTopLeft && radiusTopRight && radiusBottomLeft && radiusBottomRight) {
            SEL customSelector = @selector(customUpdateStyleWithRuleSet:context:);
            
            //Add our new method
            class_addMethod(c_PXUIView, customSelector, (IMP)PXUIView_updateStyleWithRuleSet, method_getTypeEncoding(method));
            
            //Swizzle
            Method method2 = class_getInstanceMethod(c_PXUIView, customSelector);
            method_exchangeImplementations(method, method2);
            return;
        }
    }
    NSLog(@"Pixate version not compatible with border-radius hack");
}

@end

#endif

#if DEBUG
@implementation NSObject(private)

+ (void)printClassMethods {
    

        NSMutableString *ms = nil;
        unsigned int out_count;
        
        ms = [NSMutableString string];
        out_count = 0;
        Method *class_methods = class_copyMethodList(self, &out_count);
        for (int i = 0; i < out_count; i++) {
            Method m = class_methods[i];
            const char* const type = method_copyReturnType(m);
            
            [ms appendFormat:@"\n\t- (%s)%@ %s",
             type,
             NSStringFromSelector(method_getDescription(m)->name),
             method_getTypeEncoding(m)
             ];
            
         
        }
        NSLog(@"Methods in %@\n%@\n", NSStringFromClass(self), ms);
    
    
        ms = [NSMutableString string];
        out_count = 0;
        Ivar *class_ivars = class_copyIvarList(self, &out_count);
        for (int i = 0; i < out_count; i++) {
            Ivar v = class_ivars[i];
            const char* const name = ivar_getName(v);
            const char* const type = ivar_getTypeEncoding(v);
            [ms appendFormat:@"\n\t- (%s)%s", type, name];
            
        }
        NSLog(@"IVars in %@\n%@\n", NSStringFromClass(self), ms);
    
    
        ms = [NSMutableString string];
        out_count = 0;
        objc_property_t *class_props = class_copyPropertyList(self, &out_count);
        for (int i = 0; i < out_count; i++) {
            objc_property_t p = class_props[i];
            const char* const name = property_getName(p);
            const char* const type = property_getAttributes(p);
            [ms appendFormat:@"\n\t- (%s)%s", type, name];
            
            
        }
        NSLog(@"Properties in %@\n%@\n", NSStringFromClass(self), ms);
    
}

@end
#endif
