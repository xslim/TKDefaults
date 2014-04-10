//
//  UIView+MOAStyling.m
//  MyOrderApp
//
//  Created by Angel Garcia on 11/12/13.
//  Copyright (c) 2013 MyOrder.nl. All rights reserved.
//

#import "UIView+TKDStyling.h"
#import <objc/runtime.h>


//#ifndef COCOAPODS_POD_AVAILABLE_PixateFreestyle

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

//#else


//#endif

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
