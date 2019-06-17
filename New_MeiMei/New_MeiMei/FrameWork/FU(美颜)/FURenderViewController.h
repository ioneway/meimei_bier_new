//
//  FULiveViewController.h
//  FULive
//
//  Created by L on 2018/1/15.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FURenderViewControllerDelegate <NSObject>

-(void)saveFu:(BOOL)isSave;

@end

@class FULiveModel ;
@interface FURenderViewController : UIViewController

@property (nonatomic, strong) FULiveModel *model ;

@property (nonatomic,strong) id<FURenderViewControllerDelegate> delegate;
@end
