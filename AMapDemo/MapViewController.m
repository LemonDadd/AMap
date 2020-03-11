//
//  MapViewController.m
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/11.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "MapViewController.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "MyPointAnnition.h"
#import "CousomAnnotationView.h"
#import "MJExtension.h"
#import "TipView.h"
#import "Masonry.h"

@interface MapViewController ()<MAMapViewDelegate>

@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)NSArray *resourceList;
@property (nonatomic, strong)NSMutableArray *views;
@property (nonatomic, strong)TipView *tipView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mapView];
    
    
    for (NSDictionary *dic in self.resourceList) {
        BaseModel *model = [BaseModel mj_objectWithKeyValues:dic];
        MyPointAnnition *pointAnnotation = [[MyPointAnnition alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.lat, model.lng);
        pointAnnotation.model = model;
        [_mapView addAnnotation:pointAnnotation];
    }
    
    
    
    
    
    
}
#pragma mark MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    NSLog(@"%d",updatingLocation);
    NSLog(@"位置更新");
    NSLog(@"当前位置：%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //用户当前位置大头针
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"myLocation"];
        annotationView.frame = CGRectMake(0, 0, 26, 26);
        annotationView.contentMode = UIViewContentModeScaleToFill;
        annotationView.layer.masksToBounds = YES;
        return annotationView;
    }
    
    //其他大头针设置
    else if ([annotation isKindOfClass:[MyPointAnnition class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CousomAnnotationView *annotationView = (CousomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CousomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
//        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        [self.views addObject:annotationView];
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    if ([view isKindOfClass:[CousomAnnotationView class]]) {
        for (CousomAnnotationView *coustomView in self.views) {
            coustomView.isselted = NO;
        }
        CousomAnnotationView *v = (CousomAnnotationView *)view;
        v.isselted = YES;
        [mapView deselectAnnotation:v.annotation animated:YES];
        [self showTipView:v];
    }
    
}


- (void)showTipView:(CousomAnnotationView *)coustomView {
    [self.tipView removeFromSuperview];
    [self.view addSubview:self.tipView];
    MyPointAnnition *annition =(MyPointAnnition *)coustomView.annotation;
    self.tipView.model =annition.model;
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).offset(-80);
        make.height.equalTo(@80);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
    self.tipView.tipviewClose = ^{
        coustomView.isselted = NO;
        [coustomView setSelected:NO];
        [self.tipView removeFromSuperview];
    };
    
}

-(MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
        _mapView.showsCompass = YES;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        _mapView.zoomLevel = 15;
        
    }
    return _mapView;
}

-(NSMutableArray *)views {
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}

-(TipView *)tipView {
    if (!_tipView) {
        _tipView = [TipView new];
    }
    return _tipView;
}

-(NSArray *)resourceList {
    if (!_resourceList) {
        _resourceList = @[@{@"name":@"张三",@"url":@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=265938884,2669931721&fm=26&gp=0.jpg",@"shopName":@"一号店",@"lat":@"37.8998491800",@"lng":@"112.5072097800"},@{@"name":@"李四",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583954068061&di=ab4741d4a9c790a2e0a7400631b2f9b5&imgtype=0&src=http%3A%2F%2Fwww.17qq.com%2Fimg_qqtouxiang%2F81983588.jpeg",@"shopName":@"二号店",@"lat":@"37.8958491800",@"lng":@"112.5072097800"},@{@"name":@"王五",@"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1583954068060&di=66d50f0cd61d2aa23e41584346a5ca80&imgtype=0&src=http%3A%2F%2Fwww.17qq.com%2Fimg_qqtouxiang%2F6581194.jpeg",@"shopName":@"仨号店",@"lat":@"37.7998491800",@"lng":@"112.5172097800"},@{@"name":@"赵柳",@"url":@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2286214529,1477623502&fm=26&gp=0.jpg",@"shopName":@"四号店",@"lat":@"37.8998491800",@"lng":@"112.5032097800"}];
    }
    return _resourceList;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
