//
//  SKSearchBar.m
//  DCProject
//
//  Created by 阿汤哥 on 2019/1/22.
//  Copyright © 2019 aze. All rights reserved.
//

#import "SKSearchBar.h"

@interface SKSearchBar () <UITextFieldDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end

// icon宽度
static CGFloat const searchIconW = 15.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 10.0;

@implementation SKSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.barTintColor = KTextColorfff;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setSearchFieldBackgroundImage:kimage(@"SearchBarBg") forState:UIControlStateNormal];
    [self setImage:kimage(@"searchIcon") forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.searchTextPositionAdjustment = UIOffsetMake(iconSpacing,0);

    UITextField * searchField = [self valueForKey:@"_searchField"];
    searchField.textColor = KTextColor333;
    searchField.font = kFontFix(12);
    [searchField setValue:KTextColor999 forKeyPath:@"_placeholderLabel.textColor"];
    searchField.frame = CGRectMake(15, (self.frame.size.height-32)/2, self.frame.size.width-30, 32);
    
    if (@available(iOS 11.0, *)) {
        // 先默认居中placeholder
        [self setPositionAdjustment:UIOffsetMake((searchField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}

// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kFontFix(12)} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}

// 开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 继续传递代理方法
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
// 结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

@end
