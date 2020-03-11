//
//  MyPointAnnition.h
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/11.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPointAnnition : MAPointAnnotation

@property (nonatomic, strong)BaseModel *model;


@end

NS_ASSUME_NONNULL_END
