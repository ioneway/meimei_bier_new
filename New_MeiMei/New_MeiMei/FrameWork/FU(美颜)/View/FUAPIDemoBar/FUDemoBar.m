//
//  FUDemoBar.m
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import "FUDemoBar.h"
#import "FilterView.h"
#import "BeautySkinView.h"
#import "BeautySlider.h"
#import "ItemsView.h"

@interface FUDemoBar ()<FilterViewDelegate, BeautySkinViewDelegate, FUItemsViewDelegate>
{
    BOOL isShownTop ;
}
/**     底部按钮     **/
@property (weak, nonatomic) IBOutlet UIButton *itemsBtn;        // 贴纸
@property (weak, nonatomic) IBOutlet UIButton *beautySkinBtn;   // 美肤
@property (weak, nonatomic) IBOutlet UIButton *beautyShapeBtn;  // 美型
@property (weak, nonatomic) IBOutlet UIButton *beautyFilterBtn; // 美颜滤镜
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;       // 滤镜

@property (copy, nonatomic) NSMutableDictionary<NSString *,NSNumber *> *filtersLevel;

@property (weak, nonatomic) IBOutlet ItemsView *itemsView;            // 贴纸
@property (weak, nonatomic) IBOutlet FilterView *filterView;            // 滤镜
@property (weak, nonatomic) IBOutlet FilterView *beautyFilterView;      // 美颜滤镜
@property (weak, nonatomic) IBOutlet UIView *filterSliderView;          // 滚动条
@property (weak, nonatomic) IBOutlet BeautySlider *filterSlider;        // 滚动条

@property (weak, nonatomic) IBOutlet BeautySkinView *beautySkinView;    // 美肤

@property (weak, nonatomic) IBOutlet BeautySkinView *beautyShapeView;   // 美型

@property (weak, nonatomic) IBOutlet UIView *faceShapeView;

@property (weak, nonatomic) IBOutlet UIButton *morenBtn;
@property (weak, nonatomic) IBOutlet UIButton *nvshenBtn;
@property (weak, nonatomic) IBOutlet UIButton *wanghongBtn;
@property (weak, nonatomic) IBOutlet UIButton *ziranBtn;
@property (weak, nonatomic) IBOutlet UIButton *zidingyiBtn;

@property (nonatomic, strong) NSMutableDictionary *beautySkinSelectDict ;
@property (nonatomic, strong) NSMutableDictionary *beautyShapeSelectDict ;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wanghongCenterX;
@end

@implementation FUDemoBar
@synthesize blurShape = _blurShape ;

@synthesize blurLevel = _blurLevel ;
@synthesize whiteLevel = _whiteLevel ;
@synthesize redLevel = _redLevel ;
@synthesize eyelightingLevel = _eyelightingLevel ;
@synthesize beautyToothLevel = _beautyToothLevel ;


@synthesize enlargingLevel_new = _enlargingLevel_new ;
@synthesize enlargingLevel = _enlargingLevel ;
@synthesize thinningLevel = _thinningLevel ;
@synthesize thinningLevel_new = _thinningLevel_new ;
@synthesize jewLevel = _jewLevel ;
@synthesize foreheadLevel = _foreheadLevel ;
@synthesize noseLevel = _noseLevel ;
@synthesize mouthLevel = _mouthLevel ;


- (instancetype)init
{
    NSBundle *frameWorkBundle = [NSBundle bundleForClass:self.class];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FUDemoBar" bundle:frameWorkBundle];
    FUDemoBar *bar = (FUDemoBar *)storyboard.instantiateInitialViewController.view;
    
    isShownTop = NO ;
    if (!bar) {
        return nil;
    }
    
    return bar;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    self.itemsView.mDelegate = self;
    
    self.filterSlider.type = FilterSliderTypeFilter ;
    self.filterView.mDelegate = self ;
    self.beautyFilterView.mDelegate = self ;
    self.beautySkinView.mDelegate = self ;
    self.beautySkinView.type = BeautyViewTypeSkin ;

    self.beautyShapeView.mDelegate  = self ;
    self.beautyShapeView.type = BeautyViewTypeShape ;

    isShownTop = NO ;
    [self showTopView:NO Animation:isShownTop SubView:nil];
    
    self.beautySkinSelectDict = [@{
                                   @"blurLevel": @(YES),
                                   @"whiteLevel":@(YES),
                                   @"redLevel":@(YES),
                                   @"eyelightingLevel":@(NO),
                                   @"beautyToothLevel":@(NO),
                                   } mutableCopy];
    self.beautySkinView.beautySkinDict = self.beautySkinSelectDict ;
    
    self.beautyShapeSelectDict = [@{
                                    @"enlargingLevel":@(YES),
                                    @"thinningLevel":@(YES),
                                    @"enlargingLevel_new":@(YES),
                                    @"thinningLevel_new":@(YES),
                                    @"jewLevel":@(YES),
                                    @"foreheadLevel":@(YES),
                                    @"noseLevel":@(YES),
                                    @"mouthLevel":@(YES),
                                    } mutableCopy];
    
    self.beautyShapeView.beautyShapeDict = self.beautyShapeSelectDict ;

}

- (void)setFilterLevel:(double)level forFilter:(NSString *)filter {
    if (!filter) {
        return;
    }
    self.filtersLevel[filter] = @(level);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.filterSlider.value = self.filtersLevel[_selectFilter].doubleValue;
        [self.filterView reloadData];
        [self.beautyFilterView reloadData];
    });
    
    if ([self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged];
    }
}

- (void)showTopView:(BOOL)isShow Animation:(BOOL)animation SubView:(UIView *)subView{
    
    CGAffineTransform frameTransform = isShow ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, self.frame.size.height * 0.5 ) ;
    
    CGFloat alpha = isShow ? 1.0 : 0.0 ;
    
    if (animation) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            self.itemsView.transform = frameTransform ;
            self.itemsView.alpha = alpha ;
            self.filterView.transform = frameTransform ;
            self.filterView.alpha = alpha ;
            self.beautyFilterView.transform = frameTransform ;
            self.beautyFilterView.alpha = alpha ;
            self.beautySkinView.transform = frameTransform ;
            self.beautySkinView.alpha = alpha ;
            self.beautyShapeView.transform = frameTransform ;
            self.beautyShapeView.alpha = alpha ;
        } completion:^(BOOL finished) {
            subView.hidden = NO ;
        }];
    }else {
        
        self.itemsView.transform = frameTransform ;
        self.itemsView.alpha = alpha ;
        self.filterView.transform = frameTransform ;
        self.filterView.alpha = alpha ;
        self.beautyFilterView.transform = frameTransform ;
        self.beautyFilterView.alpha = alpha ;
        self.beautySkinView.transform = frameTransform ;
        self.beautySkinView.alpha = alpha ;
        self.beautyShapeView.transform = frameTransform ;
        self.beautyShapeView.alpha = alpha ;
        
        subView.hidden = NO ;
    }
    
    if (!isShow) {
        _itemsBtn.selected = NO ;
        _filterBtn.selected = NO;
        _beautyFilterBtn.selected = NO;
        _beautySkinBtn.selected = NO;
        _beautyShapeBtn.selected = NO;
    }
    
    isShownTop = isShow ;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTopView:Animation:)]) {
        [self.delegate demoBarDidShowTopView:isShownTop Animation:animation];
    }
}

- (IBAction)bottomBtnClicked:(UIButton *)sender {
    
    if (sender.selected) {
        
        [self showTopView:NO Animation:YES SubView:nil];
        
        self.faceShapeView.hidden = YES ;
        self.filterSliderView.hidden = YES ;
        sender.selected = NO ;
        sender.titleLabel.font = [UIFont systemFontOfSize:14] ;
        return ;
    }
    
    self.itemsBtn.selected = sender == self.itemsBtn ;
    self.beautySkinBtn.selected = sender == self.beautySkinBtn ;
    self.beautyShapeBtn.selected = sender == self.beautyShapeBtn ;
    self.beautyFilterBtn.selected = sender == self.beautyFilterBtn ;
    self.filterBtn.selected = sender == self.filterBtn ;
    
    self.itemsBtn.titleLabel.font = self.itemsBtn.selected ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14] ;
    self.beautySkinBtn.titleLabel.font = self.beautySkinBtn.selected ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14] ;
    self.beautyShapeBtn.titleLabel.font = self.beautyShapeBtn.selected ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14] ;
    self.beautyFilterBtn.titleLabel.font = self.beautyFilterBtn.selected ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14] ;
    self.filterBtn.titleLabel.font = self.filterBtn.selected ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14] ;
    
    self.itemsView.hidden = !self.itemsBtn.selected ;
    self.beautySkinView.hidden = !self.beautySkinBtn.selected ;
    self.beautyShapeView.hidden = !self.beautyShapeBtn.selected ;
    self.beautyFilterView.hidden = !self.beautyFilterBtn.selected ;
    self.filterView.hidden = !self.filterBtn.selected ;
    
    UIView *subView ;
    
    self.filterSliderView.hidden = YES ;
    self.faceShapeView.hidden = YES ;

    if (!self.beautySkinView.hidden) {

        switch (self.beautySkinView.selectIndex) {
            case 2:{        // 磨皮
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeBlur ;
                self.filterSlider.value = self.blurLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 3:{        // 美白
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeWhite ;
                self.filterSlider.value = self.whiteLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 4:{        // 红润
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeRed ;
                self.filterSlider.value = self.redLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 5:{        // 亮眼
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeEyeLighting ;
                self.filterSlider.value = self.eyelightingLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 6:{        // 美牙
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeBeautyTooth ;
                self.filterSlider.value = self.beautyToothLevel ;
                subView = self.filterSliderView ;
            }
                break;

            default:{
                self.filterSliderView.hidden = YES ;
                subView = nil ;
            }
                break;
        }
    }

    if (!self.beautyShapeView.hidden) {

        switch (self.beautyShapeView.selectIndex) {
            case 0:{        // 脸型
//                self.faceShapeView.hidden = NO ;
                subView = self.faceShapeView ;
            }
                break;
            case 1:{        // 大眼
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = self.faceShape == 4 ? FilterSliderTypeEyeLarge_new : FilterSliderTypeEyeLarge ;
                self.filterSlider.value = self.faceShape == 4 ? self.enlargingLevel_new : self.enlargingLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 2:{        // 瘦脸
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = self.faceShape == 4 ? FilterSliderTypeThinFace_new : FilterSliderTypeThinFace ;
                self.filterSlider.value = self.faceShape == 4 ? self.thinningLevel_new : self.thinningLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 3:{        // 下巴
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeJew ;
                self.filterSlider.value = self.jewLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 4:{        // 额头
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeForehead ;
                self.filterSlider.value = self.foreheadLevel ;
//                NSLog(@"*** %f", self.foreheadLevel);
                subView = self.filterSliderView ;
            }
                break;
            case 5:{        // 瘦鼻
//                self.filterSliderView.hidden = NO ;
                self.filterSlider.type = FilterSliderTypeNose ;
                self.filterSlider.value = self.noseLevel ;
                subView = self.filterSliderView ;
            }
                break;
            case 6:{        // 嘴型
                self.filterSlider.type = FilterSliderTypeMouth ;
                self.filterSlider.value = self.mouthLevel ;
                subView = self.filterSliderView ;
            }
                break;

            default:
                self.faceShapeView.hidden = YES ;
                self.filterSliderView.hidden = YES ;
                subView = nil ;
                break;
        }
    }

    if (!self.beautyFilterView.hidden && self.beautyFilterView.selectedFilterIndex != -1) {
        self.filterSlider.type = FilterSliderTypeFilter ;
        self.filterSlider.value = self.filtersLevel[_selectFilter].doubleValue;
        subView = self.filterSliderView ;
    }

    if (!self.filterView.hidden && self.filterView.selectedFilterIndex != -1) {
        self.filterSlider.type = FilterSliderTypeFilter ;
        self.filterSlider.value = self.filtersLevel[_selectFilter].doubleValue;
        subView = self.filterSliderView ;
    }
    
    [self showTopView:YES Animation:YES SubView:subView];
}

#pragma mark ---- BeautySkinViewDelegate

- (void)beautySkinViewDidSelectType:(NSInteger)typeIndex isShow:(BOOL)isShow isDown:(BOOL)isDown{
    
    UIView *topView ;
    NSString *sliderName ;
    NSString *tipStr ;
    double value = 0.0 ;
    switch (typeIndex) {
        case 0:{
            
            self.skinDetectEnable = !self.skinDetectEnable ;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTip:isShow:)]) {
                [self.delegate demoBarDidShowTip:@"精准美肤" isShow:self.skinDetectEnable];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
                [self.delegate demoBarBeautyParamChanged];
            }
        }
            break ;
        case 1:{
            _blurShape = self.beautySkinView.clearBlur ;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTip:isShow:)]) {
                [self.delegate demoBarDidShowTip:_blurShape == 1 ?  @"朦胧磨皮" : @"清晰磨皮" isShow:YES];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
                [self.delegate demoBarBeautyParamChanged];
            }
        }
            break ;
        case 2:{    // 磨皮
            
            //            self.filterSliderView.hidden = !isShow ;
            self.filterSlider.type = FilterSliderTypeBlur ;
//            self.filterSlider.value = _blurLevel ;
            topView = self.filterSliderView;
            sliderName = @"blurLevel" ;
            value = _blurLevel ;
            tipStr = @"磨皮" ;
        }
            break;
        case 3:{    // 美白
            
            //            self.filterSliderView.hidden = !isShow ;
            self.filterSlider.type = FilterSliderTypeWhite ;
//            self.filterSlider.value = _whiteLevel ;
            topView = self.filterSliderView;
            sliderName = @"whiteLevel" ;
            value = _whiteLevel ;
            tipStr = @"美白" ;
        }
            break;
        case 4:{    // 红润
            
            //            self.filterSliderView.hidden = !isShow ;
            self.filterSlider.type = FilterSliderTypeRed ;
//            self.filterSlider.value = _redLevel ;
            topView = self.filterSliderView;
            sliderName = @"redLevel" ;
            value = _redLevel ;
            tipStr = @"红润" ;
        }
            break;
        case 5:{    // 亮眼
            
            //            self.filterSliderView.hidden = !isShow ;
            self.filterSlider.type = FilterSliderTypeEyeLighting ;
//            self.filterSlider.value = _eyelightingLevel ;
            topView = self.filterSliderView;
            sliderName = @"eyelightingLevel" ;
            value = _eyelightingLevel ;
            tipStr = @"亮眼" ;
        }
            break;
        case 6:{    //没牙
            
            //            self.filterSliderView.hidden = !isShow ;
            self.filterSlider.type = FilterSliderTypeBeautyTooth ;
//            self.filterSlider.value = _beautyToothLevel ;
            topView = self.filterSliderView;
            sliderName = @"beautyToothLevel" ;
            value = _beautyToothLevel ;
            tipStr = @"美牙" ;
        }
            break;
            
        default:
            break;
    }
    
    [self showTopView:topView shown:isShow];
    
    if (!isShow && isDown) {
        if (!sliderName) {
            return ;
        }
        NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
        if (!dict) {
            dict= [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [dict setValue:@(NO) forKey:sliderName];
        self.beautySkinView.beautySkinDict = dict ;
        
    }else {
        if (!sliderName) {
            return ;
        }
        NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
        if (!dict) {
            dict= [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [dict setValue: @(YES) forKey:sliderName];
        self.beautySkinView.beautySkinDict = dict ;
    }
    
    if (isDown && !isShow) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTip:isShow:)]) {
            [self.delegate demoBarDidShowTip:tipStr isShow:NO ];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
            [self.delegate demoBarBeautyParamChanged];
        }
    }
    if (!isDown && isShow) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTip:isShow:)]) {
            [self.delegate demoBarDidShowTip:tipStr isShow:YES ];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
            [self.delegate demoBarBeautyParamChanged];
        }
    }
    
    if (typeIndex != 0 && typeIndex != 1) {
        
        self.filterSlider.value = value ;
    }
}

-(void)beautyShapeViewDidSelectType:(NSInteger)typeIndex isShow:(BOOL)isShow isDown:(BOOL)isDown{
    
    if (!isDown) {
        _faceShapeView.hidden = YES ;
        _filterSliderView.hidden = YES ;
    }
    
    UIView *topView ;
    NSString *sliderName ;
    double value = 0.0 ;
    NSString *tipStr ;
    switch (typeIndex) {
        case 0:{    // 脸型
//            self.faceShapeView.hidden = NO ;
            topView = self.faceShapeView ;
        }
            break;
        case 1:{    // 大眼
            
//            self.filterSliderView.hidden = NO ;
            self.filterSlider.type = _faceShape == 4 ? FilterSliderTypeEyeLarge_new : FilterSliderTypeEyeLarge ;
//            self.filterSlider.value = _faceShape == 4 ? _enlargingLevel_new : _enlargingLevel ;
            topView = _filterSliderView ;
            value = _faceShape == 4 ? _enlargingLevel_new : _enlargingLevel ;
            sliderName = _faceShape == 4 ? @"enlargingLevel_new" : @"enlargingLevel" ;
            tipStr = @"大眼" ;
        }
            break;
        case 2:{    // 瘦脸
            
            self.filterSliderView.hidden = NO ;
            self.filterSlider.type = _faceShape == 4 ? FilterSliderTypeThinFace_new : FilterSliderTypeThinFace ;
//            self.filterSlider.value = _faceShape == 4 ? _thinningLevel_new : _thinningLevel ;
            topView = self.filterSliderView ;
            
            value = _faceShape == 4 ? _thinningLevel_new : _thinningLevel ;
            sliderName = _faceShape == 4 ? @"thinningLevel_new" : @"thinningLevel" ;
            tipStr = @"瘦脸" ;
        }
            break;
        case 3:{    // 下巴
            
            self.filterSliderView.hidden = NO ;
            self.filterSlider.type = FilterSliderTypeJew ;
//            self.filterSlider.value = _jewLevel ;
            topView = self.filterSliderView ;
            
            value = _jewLevel ;
            sliderName = @"jewLevel";
            tipStr = @"下巴" ;
        }
            break;
        case 4:{    // 额头
            
            self.filterSliderView.hidden = NO ;
            self.filterSlider.type = FilterSliderTypeForehead ;
//            self.filterSlider.value = self.foreheadLevel ;
            topView = self.filterSliderView ;
            
            value = _foreheadLevel ;
            sliderName = @"foreheadLevel";
            tipStr = @"额头" ;
        }
            break;
        case 5:{    // 瘦鼻
            
            self.filterSliderView.hidden = NO ;
            self.filterSlider.type = FilterSliderTypeNose ;
//            self.filterSlider.value = self.noseLevel ;
            topView = self.filterSliderView ;
            
            value = _noseLevel ;
            sliderName = @"noseLevel";
            tipStr = @"瘦鼻" ;
        }
            break;
        case 6:{    // 嘴型
            
            self.filterSliderView.hidden = NO ;
            self.filterSlider.type = FilterSliderTypeMouth ;
//            self.filterSlider.value = self.mouthLevel ;
            topView = self.filterSliderView ;
            
            value = _mouthLevel ;
            sliderName = @"mouthLevel";
            tipStr = @"嘴型" ;
        }
            break;
            
        default:
            break;
    }
    
    [self showTopView:topView shown:isShow];
    
    if (!isShow && isDown) {
        if (!sliderName) {
            return ;
        }
        NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
        if (!dict) {
            dict= [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [dict setValue:@(NO) forKey:sliderName];
        self.beautyShapeView.beautyShapeDict = dict ;
    }else {
        if (!sliderName) {
            return ;
        }
        NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
        if (!dict) {
            dict= [NSMutableDictionary dictionaryWithCapacity:1];
        }
        [dict setValue: @(YES) forKey:sliderName];
        self.beautyShapeView.beautyShapeDict = dict ;
    }
    
    if (isDown && !isShow) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTip:isShow:)]) {
            [self.delegate demoBarDidShowTip:tipStr isShow:NO ];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
            [self.delegate demoBarBeautyParamChanged];
        }
    }
    if (!isDown && isShow) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTip:isShow:)]) {
            [self.delegate demoBarDidShowTip:tipStr isShow:YES ];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
            [self.delegate demoBarBeautyParamChanged];
        }
    }
    
    if (typeIndex != 0) {
        self.filterSlider.value = value ;
    }
}

- (void)showTopView:(UIView *)topView shown:(BOOL)shown {
    
    if (shown) {
        
        topView.alpha = 0.0 ;
        topView.hidden = NO ;
        topView.transform = CGAffineTransformMakeTranslation(0, topView.frame.size.height / 2.0) ;
        [UIView animateWithDuration:0.20 animations:^{
            topView.alpha = 1.0 ;
            topView.transform = CGAffineTransformIdentity ;
        }];
        
    }else {
        [UIView animateWithDuration:0.12 animations:^{
            
            topView.alpha = 0.0 ;
            topView.transform = CGAffineTransformMakeTranslation(0, topView.frame.size.height / 2.0) ;
        }completion:^(BOOL finished) {
            topView.hidden = YES ;
        }];
    }
}

-(void)itemsViewDidSelectItem:(NSString *)itemName {
    _selectedItem = itemName ;
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidSelectedItem:)]) {
        [self.delegate demoBarDidSelectedItem:itemName];
    }
}

// 脸型
- (IBAction)faceShapeSelect:(UIButton *)sender{
    
    if (sender.selected) {
        return ;
    }
    
    self.morenBtn.selected = self.morenBtn == sender ;
    self.morenBtn.backgroundColor = self.morenBtn.selected ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor lightGrayColor];
    
    self.nvshenBtn.selected = self.nvshenBtn == sender ;
    self.nvshenBtn.backgroundColor = self.nvshenBtn.selected ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor lightGrayColor];

    self.wanghongBtn.selected = self.wanghongBtn == sender ;
    self.wanghongBtn.backgroundColor = self.wanghongBtn.selected ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor lightGrayColor];
    
    self.ziranBtn.selected = self.ziranBtn == sender ;
    self.ziranBtn.backgroundColor = self.ziranBtn.selected ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor lightGrayColor];

    self.zidingyiBtn.selected = self.zidingyiBtn == sender ;
    self.zidingyiBtn.backgroundColor = self.zidingyiBtn.selected ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor lightGrayColor];
    
    /**美型类型 (0、1、2、3) 默认：3，女神：0，网红：1，自然：2*/
    
    BOOL isZDY = YES ;
    if (self.morenBtn.selected) {
        _faceShape = 3 ;
    }else if (self.nvshenBtn.selected){
        _faceShape = 0 ;
    }else if (self.wanghongBtn.selected){
        _faceShape = 1 ;
    }else if (self.ziranBtn.selected){
        _faceShape = 2 ;
    }else if (self.zidingyiBtn.selected){
        _faceShape = 4 ;
        isZDY = NO ;
    }
    self.beautyShapeView.faceType = _faceShape ;
    [self.beautyShapeView reloadSectionInsects: isZDY];
    
    
    BOOL currentB = !self.morenBtn.selected ;
    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"faceShape"] boolValue];
    if (currentB != selectB) {
        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"faceShape"];
        
        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged];
    }
    
}

#pragma mark ----   FilterViewDelegate
- (void)filterView:(FilterView *)filterView didSelectedFilter:(NSString *)filter {
    
    _selectFilter = filter;
    
    NSArray *keys = self.filtersLevel.allKeys;
    if (![keys containsObject:_selectFilter]) {
        self.filtersLevel[_selectFilter] = @(1.0);
    }
    
    self.filterSlider.value = self.filtersLevel[_selectFilter].doubleValue;
    self.filterSlider.type = FilterSliderTypeFilter ;
    
    self.filterSliderView.hidden = NO ;
    self.filterSliderView.alpha = 0.0 ;
    self.filterSliderView.transform = CGAffineTransformMakeTranslation(0, self.filterSliderView.frame.size.height) ;
    [UIView animateWithDuration:0.2 animations:^{
        self.filterSliderView.alpha = 1.0 ;
        self.filterSliderView.transform = CGAffineTransformIdentity ;
    }];
    
    if (_filterView != filterView) {
        _filterView.selectedFilterIndex = -1;
    }
    
    if (_beautyFilterView != filterView) {
        _beautyFilterView.selectedFilterIndex = -1;
    }
    
    if ([self.delegate respondsToSelector:@selector(demoBarDidSelectedFilter:)]) {
        [self.delegate demoBarDidSelectedFilter:filter];
    }
    
    if ([self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged];
    }
}

-(void)filterView:(FilterView *)filterView didHiddeFilter:(NSString *)filter {
    
    [UIView animateWithDuration:0.15 animations:^{
        self.filterSliderView.alpha = 0 ;
        self.filterSliderView.transform = CGAffineTransformMakeTranslation(0, self.filterSliderView.frame.size.height) ;
    }completion:^(BOOL finished) {
        self.filterSliderView.hidden = YES ;
    }];
}

// 滚动条滚动
- (IBAction)filterSliderValueChange:(UISlider *)sender {
    
    
    switch (self.filterSlider.type) {
        case FilterSliderTypeFilter:{
            
            if (_selectFilter) {
                self.filtersLevel[_selectFilter] = @(sender.value);
                if ([self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
                    [self.delegate demoBarBeautyParamChanged];
                }
            }
//            NSLog(@"filter value : %.2f ", sender.value);
        }
            break;
        case FilterSliderTypeWhite:{
            
            self.whiteLevel = sender.value ;
//            NSLog(@"white value : %.2f ", sender.value);
        }
            break;
        case FilterSliderTypeRed:{
            
            self.redLevel = sender.value ;
//            NSLog(@"red value : %.2f ", sender.value);
        }
            break;
        case FilterSliderTypeEyeLighting:{
            
            self.eyelightingLevel = sender.value ;
//            NSLog(@"eyelight value : %.2f ", sender.value);
        }
            break;
        case FilterSliderTypeBeautyTooth:{
            
            self.beautyToothLevel = sender.value ;
//            NSLog(@"beauty tooth value : %.2f ", sender.value);
        }
            break;
        case FilterSliderTypeBlur:{
            
            self.blurLevel = sender.value ;
//            NSLog(@"blue value : %.2f ", sender.value);
        }
            break ;
        case FilterSliderTypeEyeLarge: {
            self.enlargingLevel = sender.value ;
//            NSLog(@"eyelarge value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeThinFace: {
            self.thinningLevel = sender.value ;
//            NSLog(@"thing value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeJew: {
            self.jewLevel = sender.value ;
//            NSLog(@"jew value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeForehead: {
            self.foreheadLevel = sender.value ;
//            NSLog(@"forehead value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeNose: {
            self.noseLevel = sender.value ;
//            NSLog(@"nose value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeMouth: {
            self.mouthLevel = sender.value ;
//            NSLog(@"mouth value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeEyeLarge_new: {
            self.enlargingLevel_new = sender.value ;
//            NSLog(@"enlarge_new value : %.2f ", sender.value);
            break;
        }
        case FilterSliderTypeThinFace_new: {
            self.thinningLevel_new = sender.value ;
//            NSLog(@"face_new value : %.2f ", sender.value);
            break;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged];
    }
}

#pragma mark --- setter

-(void)setFiltersDataSource:(NSArray<NSString *> *)filtersDataSource {
    
    _filtersDataSource = filtersDataSource;
    
    self.filterView.filterDataSource = @[@"origin", @"delta", @"electric", @"slowlived", @"tokyo", @"warm"];
    if ([self.filterView.filterDataSource containsObject:_selectFilter]) {
        self.filterView.selectedFilterIndex = [self.filterView.filterDataSource indexOfObject:_selectFilter];
    }else{
        self.filterView.selectedFilterIndex = -1;
    }
    
    if (filtersDataSource.count > 0) {
        for (NSString *filter in filtersDataSource) {
            self.filtersLevel[filter] = @(1.0);
        }
    }
}

-(void)setBeautyFiltersDataSource:(NSArray<NSString *> *)beautyFiltersDataSource {
    _beautyFiltersDataSource = beautyFiltersDataSource;
    self.beautyFilterView.filterDataSource = beautyFiltersDataSource.count >0 ? beautyFiltersDataSource:@[@"origin", @"qingxin", @"fennen", @"ziran", @"hongrun"];
    if ([self.beautyFilterView.filterDataSource containsObject:_selectFilter]) {
        self.beautyFilterView.selectedFilterIndex = [self.beautyFilterView.filterDataSource indexOfObject:_selectFilter];
    }else{
        self.beautyFilterView.selectedFilterIndex = -1;
    }
    
    if (beautyFiltersDataSource.count > 0) {
        for (NSString *filter in beautyFiltersDataSource) {
            self.filtersLevel[filter] = @(1.0);
        }
    }
    
}

-(void)setFiltersCHName:(NSDictionary<NSString *,NSString *> *)filtersCHName {
    
    _filtersCHName = filtersCHName;
    _filterView.filtersCHName = filtersCHName;
    _beautyFilterView.filtersCHName = filtersCHName;
}

-(void)setSelectFilter:(NSString *)selectFilter {
    _selectFilter = selectFilter ;
    
    if ([self.filterView.filterDataSource containsObject:_selectFilter]) {
        self.filterView.selectedFilterIndex = [self.filterView.filterDataSource indexOfObject:_selectFilter];
    }else{
        self.filterView.selectedFilterIndex = -1;
    }
    
    if ([self.beautyFilterView.filterDataSource containsObject:_selectFilter]) {
        self.beautyFilterView.selectedFilterIndex = [self.beautyFilterView.filterDataSource indexOfObject:_selectFilter];
        self.filterView.selectedFilterIndex = -1;
    }else{
        self.beautyFilterView.selectedFilterIndex = -1;
    }
    
    if (!_selectFilter) {
        return;
    }
    
    NSArray *keys = self.filtersLevel.allKeys;
    if (![keys containsObject:_selectFilter]) {
        self.filtersLevel[_selectFilter] = @(1.0);
    }
    
    self.filterSlider.value = self.filtersLevel[_selectFilter].doubleValue;
}

-(void)setSkinDetectEnable:(BOOL)skinDetectEnable {
    _skinDetectEnable = skinDetectEnable ;
    self.beautySkinView.skinDetectEnable = skinDetectEnable ;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)filtersLevel{
    if (!_filtersLevel) {
        _filtersLevel = [[NSMutableDictionary alloc] init];
    }
    
    return _filtersLevel;
}

/**美型类型 (0、1、2、3) 默认：3，女神：0，网红：1，自然：2*/
-(void)setFaceShape:(NSInteger)faceShape {
    _faceShape = faceShape ;
    
    UIButton *btn ;
    switch (faceShape) {
        case 0:
            btn = self.nvshenBtn ;
            break;
        case 1:
            btn = self.wanghongBtn ;
            break;
        case 2:
            btn = self.ziranBtn ;
            break;
        case 3:
            btn = self.morenBtn ;
            break;
        case 4:
            btn = self.zidingyiBtn ;
            break;
            
        default:
            break;
    }
    
    [self faceShapeSelect:btn];
}

- (double)selectedFilterLevel{
    
    if (!_selectFilter) {
        return 1.0;
    }
    
    NSArray *keys = self.filtersLevel.allKeys;
    if (![keys containsObject:_selectFilter]) {
        self.filtersLevel[_selectFilter] = @(1.0);
    }
    
    return self.filtersLevel[_selectFilter].doubleValue;
}

-(void)setBlurShape:(NSInteger)blurShape {
    _blurShape = blurShape ;
    self.beautySkinView.clearBlur = (bool)blurShape ;
}

-(NSInteger)blurShape {
    
    return self.beautySkinView.clearBlur ;
}

-(void)setBlurLevel:(double)blurLevel {
    _blurLevel = blurLevel ;
    
//    BOOL currentB = (BOOL)blurLevel ;
//    BOOL selectB = [[_beautySkinSelectDict objectForKey:@"blurLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautySkinSelectDict setObject:@(currentB) forKey:@"blurLevel"];
//        self.beautySkinView.beautySkinDict = _beautySkinSelectDict ;
//    }
}

-(double)blurLevel {
    
    NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
    BOOL isClose = [[dict objectForKey:@"blurLevel"] boolValue];
    
    return isClose ? _blurLevel : 0;
}

-(void)setWhiteLevel:(double)whiteLevel {
    _whiteLevel = whiteLevel ;
    
//    BOOL currentB = (BOOL)whiteLevel ;
//    BOOL selectB = [[_beautySkinSelectDict objectForKey:@"whiteLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautySkinSelectDict setObject:@(currentB) forKey:@"whiteLevel"];
//        self.beautySkinView.beautySkinDict = _beautySkinSelectDict ;
//    }
}

-(double)whiteLevel {
    
    NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
    BOOL isClose = [[dict objectForKey:@"whiteLevel"] boolValue];
    return isClose ? _whiteLevel : 0 ;
}

-(void)setRedLevel:(double)redLevel {
    _redLevel = redLevel;
    
//    BOOL currentB = (BOOL)redLevel ;
//    BOOL selectB = [[_beautySkinSelectDict objectForKey:@"redLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautySkinSelectDict setObject:@(currentB) forKey:@"redLevel"];
//        self.beautySkinView.beautySkinDict = _beautySkinSelectDict ;
//    }
}

-(double)redLevel {
    
    NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
    BOOL isClose = [[dict objectForKey:@"redLevel"] boolValue];
    
    return isClose ? _redLevel : 0 ;
}

-(void)setEyelightingLevel:(double)eyelightingLevel {
    _eyelightingLevel = eyelightingLevel ;
    
//    BOOL currentB = (BOOL)eyelightingLevel ;
//    BOOL selectB = [[_beautySkinSelectDict objectForKey:@"eyelightingLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautySkinSelectDict setObject:@(currentB) forKey:@"eyelightingLevel"];
//        self.beautySkinView.beautySkinDict = _beautySkinSelectDict ;
//    }
}

-(double)eyelightingLevel {
    
    NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
    BOOL isClose = [[dict objectForKey:@"eyelightingLevel"] boolValue];
    
    return isClose ? _eyelightingLevel : 0 ;
}

-(void)setBeautyToothLevel:(double)beautyToothLevel {
    _beautyToothLevel = beautyToothLevel ;
    
//    BOOL currentB = (BOOL)beautyToothLevel ;
//    BOOL selectB = [[_beautySkinSelectDict objectForKey:@"beautyToothLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautySkinSelectDict setObject:@(currentB) forKey:@"beautyToothLevel"];
//        self.beautySkinView.beautySkinDict = _beautySkinSelectDict ;
//    }
}

-(double)beautyToothLevel {
    
    NSMutableDictionary *dict = self.beautySkinView.beautySkinDict ;
    BOOL isClose = [[dict objectForKey:@"beautyToothLevel"] boolValue];
    
    return isClose ? _beautyToothLevel : 0 ;
}


-(void)setThinningLevel:(double)thinningLevel {
    _thinningLevel = thinningLevel ;

//    BOOL currentB = (BOOL)thinningLevel ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"thinningLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"thinningLevel"];
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)thinningLevel {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"thinningLevel"] boolValue];
    
    return isClose ? _thinningLevel : 0 ;
}

-(void)setEnlargingLevel:(double)enlargingLevel {
    _enlargingLevel = enlargingLevel ;
    
//    BOOL currentB = (BOOL)enlargingLevel ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"enlargingLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"enlargingLevel"];
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)enlargingLevel {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"enlargingLevel"] boolValue];
    
    return isClose ? _enlargingLevel : 0 ;
}

-(void)setJewLevel:(double)jewLevel {
    _jewLevel = jewLevel ;
//    BOOL currentB = !(jewLevel > -0.01 && jewLevel < 0.01) ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"jewLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(YES) forKey:@"jewLevel"];
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)jewLevel {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"jewLevel"] boolValue];
    return isClose ? _jewLevel : 0 ;
}

-(void)setForeheadLevel:(double)foreheadLevel {
    _foreheadLevel = foreheadLevel ;
    
//    BOOL currentB = !(foreheadLevel > -0.01 && foreheadLevel < 0.01) ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"foreheadLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"foreheadLevel"];
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)foreheadLevel {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"foreheadLevel"] boolValue];
    
    return isClose ? _foreheadLevel : 0 ;
}

-(void)setNoseLevel:(double)noseLevel {
    _noseLevel = noseLevel ;
    
//    BOOL currentB = !(noseLevel > -0.01 && noseLevel < 0.01) ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"noseLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"noseLevel"];
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)noseLevel {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"noseLevel"] boolValue];
    
    return isClose ? _noseLevel : 0 ;
}


-(void)setMouthLevel:(double)mouthLevel {
    _mouthLevel = mouthLevel ;
    
//    BOOL currentB = !(mouthLevel > -0.01 && mouthLevel < 0.01) ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"mouthLevel"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"mouthLevel"];
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)mouthLevel {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"mouthLevel"] boolValue];
    
    return isClose ? _mouthLevel : 0 ;
}

-(void)setEnlargingLevel_new:(double)enlargingLevel_new {
    _enlargingLevel_new = enlargingLevel_new ;
    
//    BOOL currentB = (BOOL)enlargingLevel_new ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"enlargingLevel_new"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"enlargingLevel_new"];
//        self.beautyShapeView.faceType = _faceShape ;
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)enlargingLevel_new {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"enlargingLevel_new"] boolValue];
    
    return isClose ? _enlargingLevel_new : 0 ;
}

-(void)setThinningLevel_new:(double)thinningLevel_new {
    _thinningLevel_new = thinningLevel_new ;
//    BOOL currentB = (BOOL)thinningLevel_new ;
//    BOOL selectB = [[_beautyShapeSelectDict objectForKey:@"thinningLevel_new"] boolValue];
//
//    if (currentB != selectB) {
//
//        [_beautyShapeSelectDict setObject:@(currentB) forKey:@"thinningLevel_new"];
//        self.beautyShapeView.faceType = _faceShape ;
//        self.beautyShapeView.beautyShapeDict = _beautyShapeSelectDict ;
//    }
}

-(double)thinningLevel_new {
    
    NSMutableDictionary *dict = self.beautyShapeView.beautyShapeDict ;
    BOOL isClose = [[dict objectForKey:@"thinningLevel_new"] boolValue];
    
    return isClose ? _thinningLevel_new : 0 ;
}

-(void)setBeautySkinSelectDict:(NSMutableDictionary *)beautySkinSelectDict {
    _beautySkinSelectDict = beautySkinSelectDict ;
    self.beautySkinView.beautySkinDict = beautySkinSelectDict ;
}

-(void)setBeautyShapeSelectDict:(NSMutableDictionary *)beautyShapeSelectDict {
    _beautyShapeSelectDict = beautyShapeSelectDict ;
    self.beautyShapeView.beautyShapeDict = beautyShapeSelectDict ;
}

-(void)setItemsDataSource:(NSArray<NSString *> *)itemsDataSource {
    _itemsDataSource = itemsDataSource ;
    self.itemsView.itemsArray = itemsDataSource ;
}

-(void)setSelectedItem:(NSString *)selectedItem {
    _selectedItem = selectedItem ;
    self.itemsView.selectedItem = selectedItem ;
}

-(void)setDemoBarType:(FUAPIDemoBarType)demoBarType {
    _demoBarType = demoBarType ;
    
    self.beautySkinView.demoBarType = demoBarType ;
    self.beautyShapeView.demoBarType = demoBarType ;
    
    self.zidingyiBtn.hidden = demoBarType == FUAPIDemoBarTypePerformance ;
    self.wanghongCenterX.constant = demoBarType == FUAPIDemoBarTypePerformance ? 40 : 0 ;
    self.filterSliderView.hidden = YES ;
    self.faceShapeView.hidden = YES ;
}

@end
