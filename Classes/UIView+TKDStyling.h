//
//  UIView+MOAStyling.h
//  MyOrderApp
//
//  Created by Angel Garcia on 11/12/13.
//  Copyright (c) 2013 MyOrder.nl. All rights reserved.
//

#import <UIKit/UIKit.h>
//#ifdef COCOAPODS_POD_AVAILABLE_PixateFreestyle
//#import <PixateFreestyle/UIView+PXStyling.h>
//#endif

@interface UIView (TKDStyling)

//#ifndef COCOAPODS_POD_AVAILABLE_PixateFreestyle

typedef enum
{
    PXStylingUndefined = 0, // undefined
    PXStylingNormal,        // normal
    PXStylingNone           // none
    
} PXStylingMode;

@property (nonatomic, assign) PXStylingMode styleMode;
@property (nonatomic, copy) NSString *styleId;
@property (nonatomic, copy) NSString *styleClass;
@property (nonatomic, copy) NSString *styleCSS;

- (void)updateStyles;
//#endif

@end
