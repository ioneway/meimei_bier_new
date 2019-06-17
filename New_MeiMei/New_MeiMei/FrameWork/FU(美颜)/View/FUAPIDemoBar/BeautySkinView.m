//
//  BeautySkinView.m
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import "BeautySkinView.h"
#import "UIImage+demobar.h"

@interface BeautySkinView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CGFloat space ;
}
@property (nonatomic, strong) NSArray *dataArray ;
@end

@implementation BeautySkinView

@synthesize beautySkinDict = _beautySkinDict ;
@synthesize beautyShapeDict = _beautyShapeDict ;

-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self ;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
    self.dataSource = self;
    self.delegate = self ;
    
    self.selectIndex = -1 ;
    
    [self registerClass:[BeautySkinCell class] forCellWithReuseIdentifier:@"BeautySkinCell"];
    
    [self reloadSectionInsects:YES];
}

-(void)setType:(BeautyViewType)type {
    _type = type ;
    
    self.selectIndex = -1 ;
    
    if (type == BeautyViewTypeSkin) {
        self.dataArray = self.demoBarType == FUAPIDemoBarTypeCommon ? @[@"精准美肤", @"美肤类型", @"磨皮", @"美白",@"红润", @"亮眼",@"美牙"] : @[@"磨皮", @"美白",@"红润"];
        
        [self reloadData];
    }else if (type == BeautyViewTypeShape){
        self.dataArray = @[@"脸型", @"大眼", @"瘦脸", ];
        [self reloadData];
    }
}

-(void)setSkinDetectEnable:(BOOL)skinDetectEnable{
    _skinDetectEnable = skinDetectEnable ;
    [self reloadData];
}

-(void)setClearBlur:(BOOL)clearBlur {
    _clearBlur = clearBlur ;
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count ;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.type == BeautyViewTypeSkin) {
        
        BeautySkinCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeautySkinCell" forIndexPath:indexPath];
        
        NSString *imageName = self.dataArray[indexPath.row] ;
        
        cell.imageView.image = [UIImage imageWithName:imageName];
        cell.titleLabel.text = self.dataArray[indexPath.row] ;
        cell.titleLabel.textColor = [UIColor whiteColor];
        
        cell.imageBgView.layer.borderWidth = indexPath.row == self.selectIndex ? 2.0 : 0.0 ;
        cell.imageBgView.layer.borderColor = indexPath.row == self.selectIndex ? [UIColor whiteColor].CGColor : [UIColor clearColor].CGColor;
        
        if (self.demoBarType == FUAPIDemoBarTypeCommon) {
            
            if (indexPath.row == 0) {
                
                if (self.skinDetectEnable) {
                    cell.imageView.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@_on",imageName]];
                    cell.titleLabel.textColor = [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0];
                }
                return cell ;
            }
            
            if (indexPath.row == 1) {
                
                cell.imageView.image = [UIImage imageWithName:@"美肤类型_on"] ;
                cell.titleLabel.text = self.clearBlur ? @"朦胧磨皮" : @"清晰磨皮" ;
                cell.titleLabel.textColor = [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0];
                
                return cell ;
            }
        }
        
        NSString *cellName ;
        
        if (self.demoBarType == FUAPIDemoBarTypeCommon) {
            switch (indexPath.row) {
                case 2:
                    cellName = @"blurLevel" ;
                    break;
                case 3:
                    cellName = @"whiteLevel" ;
                    break;
                case 4:
                    cellName = @"redLevel" ;
                    break;
                case 5:
                    cellName = @"eyelightingLevel" ;
                    break;
                case 6:
                    cellName = @"beautyToothLevel" ;
                    break;
                    
                default:
                    break;
            }
        }else {
            switch (indexPath.row) {
                case 0:
                    cellName = @"blurLevel" ;
                    break;
                case 1:
                    cellName = @"whiteLevel" ;
                    break;
                case 2:
                    cellName = @"redLevel" ;
                    break;
                    
                default:
                    break;
            }
        }
        BOOL cellShow = [[self.beautySkinDict objectForKey:cellName] boolValue];
        
        cell.imageView.image = cellShow ? [UIImage imageWithName:[NSString stringWithFormat:@"%@_on",imageName]] : [UIImage imageWithName:imageName];
        cell.titleLabel.textColor = cellShow ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor whiteColor] ;
        
        return cell ;
    }else if (self.type == BeautyViewTypeShape){
        
        BeautySkinCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeautySkinCell" forIndexPath:indexPath];
        
        NSString *imageName = self.dataArray[indexPath.row] ;
        
        cell.imageBgView.layer.borderWidth = 0.0 ;
        cell.imageBgView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.imageView.image = [UIImage imageWithName:imageName];
        cell.titleLabel.text = self.dataArray[indexPath.row] ;
        cell.titleLabel.textColor = [UIColor whiteColor];
        
        NSString *cellName ;
        switch (indexPath.row) {
            case 0:
                cellName = @"faceShape" ;
                break;
            case 1:
                cellName = self.faceType == 4 ? @"enlargingLevel_new" : @"enlargingLevel" ;
                break;
            case 2:
                cellName = self.faceType == 4 ? @"thinningLevel_new" : @"thinningLevel" ;
                break;
            case 3:
                cellName = @"jewLevel" ;
                break;
            case 4:
                cellName = @"foreheadLevel" ;
                break;
            case 5:
                cellName = @"noseLevel" ;
                break;
            case 6:
                cellName = @"mouthLevel" ;
                break;
                
            default:
                break;
        }
        
        BOOL cellShow = [[self.beautyShapeDict objectForKey:cellName] boolValue];
        cell.imageView.image = cellShow ? [UIImage imageWithName:[NSString stringWithFormat:@"%@_on",imageName]] : [UIImage imageWithName:imageName];
        
        cell.titleLabel.textColor = cellShow ? [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0] : [UIColor whiteColor] ;
        
        if (indexPath.row == self.selectIndex) {
            
            cell.imageBgView.layer.borderWidth = 2.0 ;
            cell.imageBgView.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        
        return cell ;
    }
    return nil ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.type == BeautyViewTypeSkin) {
        
        if (self.demoBarType == FUAPIDemoBarTypeCommon) {
            
            if (indexPath.row == 0) {
                
                if (_selectIndex > 1) {
                    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                        [self.mDelegate beautySkinViewDidSelectType:_selectIndex isShow:NO isDown:NO];
                    }
                }
                
                self.selectIndex = 0 ;
                self.skinDetectEnable = !self.skinDetectEnable ;
                
                [self reloadData];
                
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:indexPath.row isShow:NO isDown:NO] ;
                }
                
                return ;
            }
            
            if (indexPath.row == 1) {
                
                if (_selectIndex > 1) {
                    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                        [self.mDelegate beautySkinViewDidSelectType:_selectIndex isShow:NO isDown:NO];
                    }
                }
                
                self.selectIndex = 1 ;
                
                self.clearBlur = !self.clearBlur ;
                [self reloadData];
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:indexPath.row isShow:NO isDown:NO];
                }
                return ;
            }
            
            
            if (indexPath.row == _selectIndex) {
                
                _selectIndex = -1 ;
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow: isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:indexPath.row isShow:NO isDown:YES];
                }
                
                [self reloadData ];
                
                return ;
            }
            
            if (_selectIndex > 1) {
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:_selectIndex isShow:NO isDown:NO];
                }
            }
            
            _selectIndex = indexPath.row;
            
            [self reloadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:indexPath.row isShow:YES isDown:NO];
                }
            });
        }else {
            
            NSLog(@"---- demoBar type: %ld", self.demoBarType);
            if (indexPath.row == _selectIndex) {
                
                _selectIndex = -1 ;
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow: isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:indexPath.row + 2 isShow:NO isDown:YES];
                }
                
                [self reloadData ];
                
                return ;
            }
            
            if (_selectIndex > -1) {
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:_selectIndex + 2 isShow:NO isDown:NO];
                }
            }
            
            _selectIndex = indexPath.row;
            
            [self reloadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautySkinViewDidSelectType:isShow:isDown:)]) {
                    [self.mDelegate beautySkinViewDidSelectType:indexPath.row + 2 isShow:YES isDown:NO];
                }
            });
            
            
        }
    }else if (self.type == BeautyViewTypeShape) {
        
        if (indexPath.row == _selectIndex) {
            
            _selectIndex = -1 ;
            if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautyShapeViewDidSelectType:isShow: isDown:)]) {
                [self.mDelegate beautyShapeViewDidSelectType:indexPath.row isShow:NO isDown:YES];
            }
            [self reloadData ];
            return ;
        }
        
        if (_selectIndex != -1) {
            if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautyShapeViewDidSelectType:isShow:isDown:)]) {
                [self.mDelegate beautyShapeViewDidSelectType:_selectIndex isShow:NO isDown:NO];
            }
        }
        _selectIndex = indexPath.row ;
        [self reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(beautyShapeViewDidSelectType:isShow: isDown:)]) {
                [self.mDelegate beautyShapeViewDidSelectType:indexPath.row isShow:YES isDown:NO];
            }
        });
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
//    if (self.type == BeautyViewTypeShape) {
//
//    }
    return UIEdgeInsetsMake(16, space, 16, 16) ;
//    return UIEdgeInsetsMake(16, 16, 16, 16) ;
}

- (void)reloadSectionInsects:(BOOL)isReload {
    
    if (self.type == BeautyViewTypeShape) {
        
        if (isReload) {
            
            space = ([UIScreen mainScreen].bounds.size.width - 184)/ 2.0 ;
            self.dataArray = @[@"脸型", @"大眼", @"瘦脸"];
        }else {
            
            space = 16 ;
            self.dataArray = @[@"脸型", @"大眼", @"瘦脸", @"下巴",@"额头", @"瘦鼻",@"嘴型"];
        }
        [self reloadData];
    }
}

-(void)setBeautySkinDict:(NSMutableDictionary *)beautySkinDict {
    _beautySkinDict = beautySkinDict ;
    [self reloadData];
}

-(NSMutableDictionary *)beautySkinDict {
    return _beautySkinDict ;
}

-(void)setBeautyShapeDict:(NSMutableDictionary *)beautyShapeDict {
    _beautyShapeDict = beautyShapeDict ;
    [self reloadData];
}

-(NSMutableDictionary *)beautyShapeDict {
    
    return _beautyShapeDict ;
}

-(void)setFaceType:(NSInteger)faceType {
    _faceType = faceType ;
}

-(void)setDemoBarType:(FUAPIDemoBarType)demoBarType {
    _demoBarType = demoBarType ;
    
    if (self.type == BeautyViewTypeSkin) {
        self.dataArray = _demoBarType == FUAPIDemoBarTypeCommon ? @[@"精准美肤", @"美肤类型", @"磨皮", @"美白",@"红润", @"亮眼",@"美牙"] : @[@"磨皮", @"美白",@"红润"];
        space = demoBarType == FUAPIDemoBarTypePerformance ? ([UIScreen mainScreen].bounds.size.width - 184)/ 2.0 : 16 ;
        
    }else if (self.type == BeautyViewTypeShape){
        
        self.dataArray = @[@"脸型", @"大眼", @"瘦脸"];
    }
    _selectIndex = -1 ;
    [self reloadData ];
}

@end

@implementation BeautySkinCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        self.imageBgView.backgroundColor = [UIColor clearColor];
        self.imageBgView.layer.cornerRadius = 24 ;
        self.imageBgView.layer.masksToBounds = YES ;
        
        [self addSubview:self.imageBgView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 40, 40)];
        self.imageView.layer.masksToBounds = YES ;
        self.imageView.layer.cornerRadius = 22.0 ;
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, frame.size.width, 11)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.titleLabel ];
        
        self.layer.masksToBounds = YES ;
        self.layer.cornerRadius = 4.0 ;
    }
    return self ;
}

@end
