//
//  SKSearchBar.m
//  DCProject
//
//  Created by 阿汤哥 on 2019/1/22.
//  Copyright © 2019 aze. All rights reserved.
//

#import "SKSearchBar.h"

@interface SKSearchBar () <UITextFieldDelegate,UISearchBarDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end

// icon宽度
static CGFloat const searchIconW = 15.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 6.0;
// 取消按钮宽
static CGFloat const cannelSpacing = 32.0;

@implementation SKSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initData];
    }
    return self;
}

- (void)initData{
    self.barTintColor = KTextColorfff;
    self.searchBarIcon = kimage(@"searchIcon");
    self.searchFieldBackgroundImage = kimage(@"SearchBarBg");
    self.showCancelButton = YES;
    self.cancelButtonTitle = @"取消";
    self.cancelButtonTextColor = KTextColor333;
    self.cancelButtonFont = kFontFix(14);
    self.placeholder = @"请输入关键字";
    self.searchTextFont = kFontFix(14);
    self.searchTextColor = KTextColor333;
    self.searchPlaceHolderColor = UIColorFromRGB(0xA1A1A1);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setSearchFieldBackgroundImage:self.searchFieldBackgroundImage forState:UIControlStateNormal];
    [self setImage:self.searchBarIcon forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.searchTextPositionAdjustment = UIOffsetMake(iconSpacing,0);
    self.delegate = self;
    
    for (UIView *view in [[self.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
            cancelBtn.titleLabel.font = self.cancelButtonFont;
            [cancelBtn setTitleColor:self.cancelButtonTextColor forState:UIControlStateNormal];
        }
    }
    
    UITextField * searchField = [self valueForKey:@"_searchField"];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.textColor = self.searchTextColor;
    searchField.font = self.searchTextFont;
    [searchField setValue:self.searchPlaceHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    searchField.frame = CGRectMake(15, (self.frame.size.height-34)/2-1, self.frame.size.width-30-(self.showsCancelButton?cannelSpacing:0), 34);
    
    if (self.searchAlignmentType == SKSearchAlignmentTypeCenter &&self.isEdting==NO) {
        if (@available(iOS 11.0, *)) {
            // 先默认居中placeholder
            [self setPositionAdjustment:UIOffsetMake((searchField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
}

// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kFontFix(14)} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW+8;
    }
    return _placeholderWidth;
}

#pragma mark - delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 继续传递代理方法
    self.showsCancelButton = self.showCancelButton;
    self.isEdting = YES;
    if (self.showCancelButton) {
        [self layoutSubviews];
    }
    
    if ([self.sk_delegate respondsToSelector:@selector(sk_searchBarTextDidBeginEditing:)]) {
        [self.sk_delegate sk_searchBarTextDidBeginEditing:self];
    }
    
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.showsCancelButton = NO;
    self.isEdting = NO;
    
    if ([self.sk_delegate respondsToSelector:@selector(sk_searchBarTextDidEndEditing:)]) {
        [self.sk_delegate sk_searchBarTextDidEndEditing:self];
    }
    
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    if (self.showCancelButton) {
//        CGRect frame = textField.frame;
//        frame.size.width -= cannelSpacing;
//        textField.frame = frame;
//    }
//}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.searchAlignmentType == SKSearchAlignmentTypeCenter) {
        if (@available(iOS 11.0, *)) {
            
            [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if ([self.sk_delegate respondsToSelector:@selector(sk_searchBarCancelButtonClicked:)]) {
        [self.sk_delegate sk_searchBarCancelButtonClicked:self];
    }
    [self resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([self.sk_delegate respondsToSelector:@selector(sk_searchBarSearchButtonClicked:)]) {
        [self.sk_delegate sk_searchBarSearchButtonClicked:self];
    }
    [self resignFirstResponder];
}
@end
