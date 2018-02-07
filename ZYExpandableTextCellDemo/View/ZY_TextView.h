//
//  ZY_TextView.h
//  ZYExpandableTextCellDemo
//
//  Created by 中商国际 on 2018/2/6.
//  Copyright © 2018年 中商国际. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double SZTextViewVersionNumber;

FOUNDATION_EXPORT const unsigned char SZTextViewVersionString[];


IB_DESIGNABLE
@interface ZY_TextView : UITextView

@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (nonatomic) IBInspectable double fadeTime;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end
