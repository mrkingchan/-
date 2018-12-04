//
//  NNHAreaPickerView.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAreaPickerView.h"

@interface NNHAreaPickerView ()

/** 城市数据 **/
@property (nonatomic, strong) NSArray *pickerViewDataSource;
/**  **/
@property (nonatomic, copy) NSString *areaString;

@end

@implementation NNHAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    self.widthForComponent = ^CGFloat (NSInteger component){
        return SCREEN_WIDTH/3;
    };
    
    self.numberOfComponents = ^NSUInteger{
        return 3;
    };
    
    NNHWeakSelf(self)
    self.numberOfRows = ^NSUInteger (NSInteger Components){
        NNHStrongSelf(self)
        if (Components == 0) {
            return strongself.pickerViewDataSource.count;
        }else if (Components ==1)
        {
            NSInteger index_fir = [strongself selectedRowInComponent:0];
            NSArray *array = strongself.pickerViewDataSource[index_fir][@"area"];
            return [array count];
        }
        NSInteger index_fir = [strongself selectedRowInComponent:0];
        NSInteger index_sec = [strongself selectedRowInComponent:1];
        NSArray *array = strongself.pickerViewDataSource[index_fir][@"area"];

        return [array[index_sec][@"area"] count];
    };
    
    self.viewForRowAndComponent = ^ UIView *(NSInteger Component,NSInteger Row,UIView *resuseView){
        NNHStrongSelf(self)
        NSDictionary *dic = [strongself backPickerViewDicWithComponent:Component andRow:Row];
        if (dic == nil) {
            return nil;
        }
        NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:dic[@"name"] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        UILabel *label;
        if (resuseView == nil) {
            label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.attributedText = attributeStr;
        }else
        {
            label.attributedText = attributeStr;
        }
        return label;
    };
    
    self.didScrollRowAndComponent = ^ (NSInteger Component,NSInteger Row){
        NNHStrongSelf(self);
        if (Component != 2) {
            [strongself reloadAllData];
            [strongself selectedRow:0 andComponent:Component+1 andAnimation:NO];
        };
    };
    
    self.didSelectedRowAndComponent = ^(NSInteger Component,NSInteger Row){
        NNHStrongSelf(self);;
        if (Component !=2) {
            Component = 2;
            Row = 0;
        }
        /** 选中的之前一个字典 **/
        NSInteger index = [strongself selectedRowInComponent:0];
        NSInteger indexSec = [strongself selectedRowInComponent:1];
        NSDictionary *dictParent = [strongself.pickerViewDataSource objectAtIndex:index];
        NSString *parentStr =     dictParent[@"area"][indexSec][@"name"];
        NSDictionary *dic =    [strongself backPickerViewDicWithComponent:Component andRow:Row];
        strongself.areaString = [NSString stringWithFormat:@"%@%@",parentStr,dic[@"name"]];
        
        NSString *code = [dic[@"id"] description];
        if (weakself.didSelectedAreaBlock) {
            weakself.didSelectedAreaBlock(code, dictParent[@"name"], parentStr,dic[@"name"]);

        }
    };
}

- (NSDictionary *)backPickerViewDicWithComponent:(NSInteger)component andRow:(NSInteger)row
{
    if (component == 0) {
        return self.pickerViewDataSource[row];
    }else { /** 当前选中的行 **/
        if (component == 1) { // 如果选中的是第一列
            NSInteger index = [self selectedRowInComponent:0];
            NSDictionary *dict = [self.pickerViewDataSource objectAtIndex:index];
            if ([dict[@"area"] count] -1 <row) {
                return nil;
            }
            return dict[@"area"][row];
        }else if (component == 2){
            /** 区县 **/
            NSInteger indexFirst = [self selectedRowInComponent:0];
            NSInteger indexSec = [self selectedRowInComponent:1];
            /** 第一层字典 **/
            NSDictionary *dict = [self.pickerViewDataSource objectAtIndex:indexFirst];
            NSArray *ary = dict[@"area"][indexSec][@"area"];
            if (ary.count - 1 <row) {
                return nil;
            }
            return  ary[row];
        };
    };
    return nil;
}

- (NSArray *)pickerViewDataSource
{
    if (_pickerViewDataSource == nil ) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _pickerViewDataSource = [NSArray arrayWithContentsOfFile:path];
    }
    return _pickerViewDataSource;
}


@end
