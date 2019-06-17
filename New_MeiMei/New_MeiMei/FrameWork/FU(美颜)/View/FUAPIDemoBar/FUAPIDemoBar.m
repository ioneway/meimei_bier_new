//
//  FULiveDemoBar.m
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import "FUAPIDemoBar.h"
#import "FUDemoBar.h"

@interface FUAPIDemoBar ()<FUDemoBarDelegate>


@property (nonatomic, strong) FUDemoBar *bar ;
@property (nonatomic, assign, readwrite) double selectedFilterLevel;
@end

@implementation FUAPIDemoBar

@synthesize skinDetectEnable = _skinDetectEnable ;
@synthesize blurShape = _blurShape ;
@synthesize blurLevel = _blurLevel ;
@synthesize whiteLevel = _whiteLevel ;
@synthesize redLevel = _redLevel ;
@synthesize eyelightingLevel = _eyelightingLevel ;
@synthesize beautyToothLevel = _beautyToothLevel ;

@synthesize faceShape = _faceShape ;
@synthesize enlargingLevel = _enlargingLevel ;
@synthesize thinningLevel = _thinningLevel ;
@synthesize enlargingLevel_new = _enlargingLevel_new ;
@synthesize thinningLevel_new = _thinningLevel_new ;
@synthesize jewLevel = _jewLevel ;
@synthesize foreheadLevel = _foreheadLevel ;
@synthesize noseLevel = _noseLevel ;
@synthesize mouthLevel = _mouthLevel ;

@synthesize itemsDataSource = _itemsDataSource ;
@synthesize selectedItem = _selectedItem ;
@synthesize filtersDataSource = _filtersDataSource ;
@synthesize beautyFiltersDataSource = _beautyFiltersDataSource ;
@synthesize selectedFilter = _selectedFilter ;
@synthesize selectedFilterLevel = _selectedFilterLevel ;

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        NSBundle *frameWorkBundle = [NSBundle bundleForClass:FUDemoBar.class];
        self.bar = (FUDemoBar *)[frameWorkBundle loadNibNamed:@"FUDemoBar" owner:self options:NULL].firstObject;
        self.bar.frame = self.bounds;
        self.bar.delegate = self ;
        [self addSubview:self.bar ];
        
        self.bar.skinDetectEnable = _skinDetectEnable ;
        self.bar.blurShape = _blurShape ;
        self.bar.blurLevel = _blurLevel ;
        self.bar.whiteLevel = _whiteLevel ;
        self.bar.redLevel = _redLevel ;
        self.bar.eyelightingLevel = _eyelightingLevel ;
        self.bar.beautyToothLevel = _beautyToothLevel ;
        
        self.bar.faceShape = _faceShape ;
        self.bar.enlargingLevel = _enlargingLevel ;
        self.bar.thinningLevel = _thinningLevel ;
        self.bar.jewLevel = _jewLevel ;
        self.bar.foreheadLevel = _foreheadLevel ;
        self.bar.noseLevel = _noseLevel ;
        self.bar.mouthLevel = _mouthLevel ;
        
        self.bar.filtersDataSource = _filtersDataSource ;
        self.beautyFiltersDataSource = _beautyFiltersDataSource ;
        self.bar.filtersCHName = _filtersCHName ;
        self.bar.selectFilter = _selectedFilter ;
        
        [self.bar setFilterLevel:_selectedFilterLevel forFilter:_selectedFilter];
        
    }
    return self ;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        NSBundle *frameWorkBundle = [NSBundle bundleForClass:FUDemoBar.class];
        self.bar = (FUDemoBar *)[frameWorkBundle loadNibNamed:@"FUDemoBar" owner:self options:NULL].firstObject;
        self.bar.frame = self.bounds;
        self.bar.delegate = self ;
        [self addSubview:self.bar];
        
        self.bar.skinDetectEnable = _skinDetectEnable ;
        self.bar.blurShape = _blurShape ;
        self.bar.blurLevel = _blurLevel ;
        self.bar.whiteLevel = _whiteLevel ;
        self.bar.redLevel = _redLevel ;
        self.bar.eyelightingLevel = _eyelightingLevel ;
        self.bar.beautyToothLevel = _beautyToothLevel ;
        
        self.bar.faceShape = _faceShape ;
        self.bar.enlargingLevel = _enlargingLevel ;
        self.bar.thinningLevel = _thinningLevel ;
        self.bar.jewLevel = _jewLevel ;
        self.bar.foreheadLevel = _foreheadLevel ;
        self.bar.noseLevel = _noseLevel ;
        self.bar.mouthLevel = _mouthLevel ;
        
        self.bar.filtersDataSource = _filtersDataSource ;
        self.beautyFiltersDataSource = _beautyFiltersDataSource ;
        self.bar.filtersCHName = _filtersCHName ;
        self.bar.selectFilter = _selectedFilter ;
        
        [self.bar setFilterLevel:_selectedFilterLevel forFilter:_selectedFilter];
    }
    return self ;
}

- (void)setFilterLevel:(double)level forFilter:(NSString *)filter{
    _selectedFilterLevel = level;
    [self.bar setFilterLevel:level forFilter:filter];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bar.frame = self.bounds ;
}

#pragma mark --- FUDemoBarDelegate

-(void)demoBarDidSelectedItem:(NSString *)itemName {
    
    _selectedItem = itemName ;
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidSelectedItem:)]) {
        [self.delegate demoBarDidSelectedItem:itemName];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged ];
    }
}

- (void)demoBarDidSelectedFilter:(NSString *)filter {
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidSelectedFilter:)]) {
        [self.delegate demoBarDidSelectedFilter:filter];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged ];
    }
}

- (void)demoBarBeautyParamChanged {
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarBeautyParamChanged)]) {
        [self.delegate demoBarBeautyParamChanged ];
    }
}

-(void)demoBarDidShowTopView:(BOOL)shown Animation:(BOOL)animation {
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShowTopView:)]) {
        [self.delegate demoBarDidShowTopView:shown];
    }
}

-(void)demoBarDidShowTip:(NSString *)tip isShow:(BOOL)show {
    
    NSString *open = show ? @"开启" : @"关闭" ;
    
    NSString *tipStr = [tip stringByAppendingString:open];
    if (self.delegate && [self.delegate respondsToSelector:@selector(demoBarDidShouldShowTip:)]) {
        [self.delegate demoBarDidShouldShowTip:tipStr ];
    }
}

#pragma mark --- setter && getter

-(void)setSkinDetectEnable:(BOOL)skinDetectEnable {
    _skinDetectEnable = skinDetectEnable ;
    self.bar.skinDetectEnable = skinDetectEnable ;
}

-(BOOL)skinDetectEnable {
    
    return self.bar.skinDetectEnable ;
}

-(void)setBlurShape:(NSInteger)blurShape {
    _blurShape = blurShape ;
    self.bar.blurShape = blurShape ;
}

-(NSInteger)blurShape {
    return self.bar.blurShape ;
}

-(void)setBlurLevel:(double)blurLevel {
    _blurLevel = blurLevel ;
    self.bar.blurLevel = blurLevel ;
}

-(double)blurLevel {
    return self.bar.blurLevel ;
}

-(void)setWhiteLevel:(double)whiteLevel{
    _whiteLevel = whiteLevel ;
    self.bar.whiteLevel  = whiteLevel ;
}

-(double)whiteLevel {
    return self.bar.whiteLevel ;
}

-(void)setRedLevel:(double)redLevel {
    _redLevel = redLevel ;
    self.bar.redLevel = redLevel ;
}

-(double)redLevel {
    return self.bar.redLevel ;
}

-(void)setEyelightingLevel:(double)eyelightingLevel {
    _eyelightingLevel = eyelightingLevel ;
    self.bar.eyelightingLevel = eyelightingLevel ;
}

-(double)eyelightingLevel {
    return self.bar.eyelightingLevel ;
}

-(void)setBeautyToothLevel:(double)beautyToothLevel {
    _beautyToothLevel = beautyToothLevel ;
    self.bar.beautyToothLevel = beautyToothLevel ;
}

-(double)beautyToothLevel {
    return self.bar.beautyToothLevel ;
}

-(void)setFaceShape:(NSInteger)faceShape {
    _faceShape = faceShape ;
    self.bar.faceShape = faceShape ;
}

-(NSInteger)faceShape {
    return self.bar.faceShape ;
}

-(void)setEnlargingLevel:(double)enlargingLevel {
    _enlargingLevel = enlargingLevel ;
    self.bar.enlargingLevel = enlargingLevel ;
}

-(double)enlargingLevel {
    return self.bar.enlargingLevel ;
}

-(void)setThinningLevel:(double)thinningLevel {
    _thinningLevel = thinningLevel ;
    self.bar.thinningLevel = thinningLevel ;
}

-(double)thinningLevel {
    return self.bar.thinningLevel ;
}

-(void)setJewLevel:(double)jewLevel {
    _jewLevel = jewLevel - 0.5 ;
    self.bar.jewLevel = _jewLevel;
}

-(double)jewLevel {
    return self.bar.jewLevel + 0.5 ;
}

-(void)setForeheadLevel:(double)foreheadLevel {
    _foreheadLevel = foreheadLevel - 0.5 ;
    self.bar.foreheadLevel = _foreheadLevel ;
}

-(double)foreheadLevel {
    return self.bar.foreheadLevel + 0.5 ;
}

-(void)setNoseLevel:(double)noseLevel {
    _noseLevel = noseLevel;
    self.bar.noseLevel = _noseLevel ;
}

-(double)noseLevel {
    return self.bar.noseLevel;
}

-(void)setMouthLevel:(double)mouthLevel {
    _mouthLevel = mouthLevel - 0.5 ;
    self.bar.mouthLevel = _mouthLevel ;
}

-(double)mouthLevel {
    return self.bar.mouthLevel + 0.5 ;
}


-(void)setFiltersDataSource:(NSArray<NSString *> *)filtersDataSource {
    _filtersDataSource = filtersDataSource ;
    _bar.filtersDataSource = filtersDataSource ;
}

-(NSArray<NSString *> *)filtersDataSource {
    if (!_bar.filtersDataSource) {
        return _filtersDataSource ;
    }
    return _bar.filtersDataSource ;
}

-(void)setBeautyFiltersDataSource:(NSArray<NSString *> *)beautyFiltersDataSource {
    _beautyFiltersDataSource = beautyFiltersDataSource ;
    _bar.beautyFiltersDataSource = beautyFiltersDataSource ;
}

-(NSArray<NSString *> *)beautyFiltersDataSource {
    if (!_bar.beautyFiltersDataSource) {
        return _beautyFiltersDataSource ;
    }
    return _bar.beautyFiltersDataSource ;
}

- (void)setFiltersCHName:(NSDictionary<NSString *,NSString *> *)filtersCHName{
    _filtersCHName = filtersCHName;
    
    _bar.filtersCHName = filtersCHName;
}

-(void)setSelectedFilter:(NSString *)selectedFilter {
    _selectedFilter = selectedFilter ;
    self.bar.selectFilter = selectedFilter ;
}

-(NSString *)selectedFilter {
    if (!_bar.selectFilter) {
        return _selectedFilter ;
    }
    return _bar.selectFilter ;
}

-(double)selectedFilterLevel {
    return self.bar.selectedFilterLevel ;
}

-(void)setEnlargingLevel_new:(double)enlargingLevel_new {
    _enlargingLevel_new = enlargingLevel_new ;
    self.bar.enlargingLevel_new = enlargingLevel_new ;
}
-(double)enlargingLevel_new {
    return self.bar.enlargingLevel_new ;
}
-(void)setThinningLevel_new:(double)thinningLevel_new {
    _thinningLevel_new = thinningLevel_new ;
    self.bar.thinningLevel_new = thinningLevel_new ;
}

-(double)thinningLevel_new {
    return self.bar.thinningLevel_new ;
}

-(void)setItemsDataSource:(NSArray<NSString *> *)itemsDataSource {
    _itemsDataSource = itemsDataSource ;
    self.bar.itemsDataSource = itemsDataSource ;
}

-(void)setSelectedItem:(NSString *)selectedItem {
    _selectedItem = selectedItem ;
    self.bar.selectedItem = selectedItem ;
}

-(NSString *)selectedItem {
    return self.bar.selectedItem ? self.bar.selectedItem : _selectedItem ;
}

-(void)setDemoBarType:(FUAPIDemoBarType)demoBarType {
    _demoBarType = demoBarType ;
    self.bar.demoBarType = _demoBarType ;
}
@end

