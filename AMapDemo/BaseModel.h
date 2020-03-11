//
//  BaseModel.h
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/12.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *shopName;
@property (nonatomic, assign)float lat;
@property (nonatomic, assign)float lng;

@end

NS_ASSUME_NONNULL_END
