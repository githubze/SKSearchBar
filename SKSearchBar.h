//
//  SKSearchBar.h
//  DCProject
//
//  Created by 阿汤哥 on 2019/1/22.
//  Copyright © 2019 aze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKDefine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SKSearchBarDelegete<NSObject>

/**
 开始编辑
 */
- (void)sk_searchBarTextDidBeginEditing:(UISearchBar *)searchBar;

/**
 结束编辑
 */
- (void)sk_searchBarTextDidEndEditing:(UISearchBar *)searchBar;

/**
 搜索按钮
 */
- (void)sk_searchBarSearchButtonClicked:(UISearchBar *)searchBar;

/**
 取消按钮
 */
- (void)sk_searchBarCancelButtonClicked:(UISearchBar *)searchBar;

@end

typedef NS_ENUM(NSInteger,SKSearchAlignmentType){
    SKSearchAlignmentTypeLeft,
    SKSearchAlignmentTypeCenter
};

@interface SKSearchBar : UISearchBar

/**
 协议
 */
@property (nonatomic, weak) id<SKSearchBarDelegete> sk_delegate;

/**
 搜索区域背景图片
 */
@property (nonatomic, strong) UIImage * searchFieldBackgroundImage;

/**
 搜索图片
 */
@property (nonatomic, strong) UIImage * searchBarIcon;

/**
 搜索文字颜色
 */
@property (nonatomic, strong) UIColor * searchTextColor;

/**
 搜索PlaceHolder颜色
 */
@property (nonatomic, strong) UIColor * searchPlaceHolderColor;

/**
 搜索文字字体
 */
@property (nonatomic, strong) UIFont * searchTextFont;

/**
 是否显示取消按钮 默认显示
 */
@property (nonatomic, assign) BOOL showCancelButton;

/**
 取消按钮文字
 */
@property (nonatomic, strong) NSString * cancelButtonTitle;

/**
 取消按钮文字颜色
 */
@property (nonatomic, strong) UIColor * cancelButtonTextColor;

/**
 取消按钮字体
 */
@property (nonatomic, strong) UIFont * cancelButtonFont;

/**
 对齐方式
 */
@property (nonatomic, assign) SKSearchAlignmentType searchAlignmentType;

/**
 是否是编辑状态
 */
@property (nonatomic, assign) BOOL isEdting;

@end

NS_ASSUME_NONNULL_END
