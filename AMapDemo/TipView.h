//
//  TipView.h
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/12.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TipViewClose)(void);

@interface TipView : UIView

@property (nonatomic, copy)TipViewClose tipviewClose;
@property (nonatomic, strong)BaseModel *model;


@end

NS_ASSUME_NONNULL_END
