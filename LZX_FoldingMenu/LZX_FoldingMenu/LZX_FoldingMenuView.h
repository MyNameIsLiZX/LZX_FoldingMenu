//
//  LZX_FoldingMenuView.h
//  LZX_FoldingMenu
//
//  Created by twzs on 2017/8/9.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZX_FoldingMenuView : UIView

/** 点击cell 回调当前索引 */
@property (nonatomic, copy) void(^block)(NSInteger,NSInteger);

/** 参数一 坐标  参数二 父级  参数三 标题数组  参数四 标题背景颜色数组 参数五 所要展示的列表数组(所包含的数组个数, 与标题的个数相同) */
- (instancetype)initForm:(CGRect)rect superController:(UIViewController *)controller TitleArr:(NSArray *)titleArr bgColor:(UIColor *)bgColor TitleColor:(UIColor *)titleColor titleFont:(NSInteger)titleFont listArr:(NSArray *)listArr ;

@end
