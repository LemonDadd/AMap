//
//  CousomAnnotationView.h
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/11.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CousomAnnotationView : MAAnnotationView

@property (nonatomic, strong)UIImageView *imgV;
@property (nonatomic, assign)BOOL isselted;//是否选中


@end

NS_ASSUME_NONNULL_END
