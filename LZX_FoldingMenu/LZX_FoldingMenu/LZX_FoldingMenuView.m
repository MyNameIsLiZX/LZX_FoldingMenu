//
//  LZX_FoldingMenuView.m
//  LZX_FoldingMenu
//
//  Created by twzs on 2017/8/9.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import "LZX_FoldingMenuView.h"

@interface LZX_FoldingMenuView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSArray  *contentArr;

@property (nonatomic, strong) NSArray  *listNumber;

@property (nonatomic, weak) UITableView  *tableView;
// 透明底层view
@property (nonatomic, strong) UIView  *bgView;

@property (nonatomic, assign) CGRect  FirstRect;

@property (nonatomic, assign) NSInteger  titleHeight;

@property (nonatomic, strong) UIColor  *color;

@property (nonatomic, assign) NSInteger  index;

@end

@implementation LZX_FoldingMenuView

- (instancetype)initForm:(CGRect)rect superController:(UIViewController *)controller TitleArr:(NSArray *)titleArr bgColor:(UIColor *)bgColor TitleColor:(UIColor *)titleColor titleFont:(NSInteger)titleFont listArr:(NSArray *)listArr  {
    if (self = [super init]) {
        self.frame = rect;
        self.titleHeight = rect.size.height;
        self.FirstRect = rect;
        self.contentArr = listArr;
        self.color = bgColor;
        [self setupBGView:controller.view];
        [self setupTitleWithTitleArr:titleArr bgColor:bgColor TitleColor:titleColor titleFont:titleFont];
        [self setupTabelView];
    }
    return self;
}

- (void)setupBGView:(UIView *)view {
    
    self.bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.1;
    self.bgView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.bgView addGestureRecognizer:tap];
    [view addSubview:_bgView];
}

- (void)setupTitleWithTitleArr:(NSArray *)titleArr bgColor:(UIColor *)bgColor TitleColor:(UIColor *)titleColor titleFont:(NSInteger)titleFont {
    
    float width = self.bounds.size.width/titleArr.count;
    
    [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupBtnRect:CGRectMake(idx*width, 0, width, self.titleHeight) title:titleArr[idx] background:bgColor titleColor:titleColor titleFont:titleFont tag:idx];
    }];
}

- (void)setupListTag:(UIButton *)sender {

    self.index = sender.tag;
    
    self.bgView.hidden = NO;
    self.listNumber = self.contentArr[sender.tag];
    self.tableView.frame = CGRectZero;
    // 更新tableview的高度
    CGRect rect = self.tableView.frame;
    rect = [self listCount:self.listNumber.count BtnTag:sender.tag];
    self.tableView.frame = rect;
    // 更新self的高度
    CGRect selfRect = self.FirstRect;
    selfRect.size.height += rect.size.height;
    self.frame = selfRect;
    // 刷新数据
    [self.tableView reloadData];
}

- (void)setupTabelView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width/3, 0) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listNumber.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"indexCell"];
    }
    cell.backgroundColor = self.color;
    cell.textLabel.text = self.listNumber[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.block(self.index,indexPath.row);
    [self hidenAnimation];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self hidenAnimation];
}

- (void)hidenAnimation {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.alpha = 0.5;
        CGRect rect = self.tableView.frame;
        rect.size.height = 0;
        self.tableView.frame = rect;
    } completion:^(BOOL finished) {
        self.tableView.alpha = 1;
        self.frame = self.FirstRect;
        self.bgView.hidden = YES;
    }];
    
}

- (CGRect)listCount:(NSInteger)count BtnTag:(NSInteger)btnTag {
    
    float width = self.bounds.size.width/self.contentArr.count;
    
    NSInteger listCount = count > 7 ? 7 : count;
    
    CGRect rect = CGRectMake(btnTag*width, self.titleHeight, width, listCount*44);
    
    return rect;
}

- (UIButton *)setupBtnRect:(CGRect)rect title:(NSString *)title background:(UIColor *)background titleColor:(UIColor *)titleColor titleFont:(NSInteger)titleFont tag:(NSInteger)tag {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = background;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    btn.frame = rect;
    btn.tag = tag;
    [btn addTarget:self action:@selector(setupListTag:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}
// 解决tableviewCell 分割线短半截的问题
-(void)layoutSubviews

{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
