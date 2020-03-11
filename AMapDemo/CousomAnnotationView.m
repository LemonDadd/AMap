//
//  CousomAnnotationView.m
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/11.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "CousomAnnotationView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MyPointAnnition.h"

@implementation CousomAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, 60, 60);
        MyPointAnnition *ann = (MyPointAnnition *)annotation;
        
        _imgV = [UIImageView new];
        _imgV.backgroundColor = [UIColor redColor];
        _imgV.layer.masksToBounds = YES;
        _imgV.layer.borderColor = [UIColor whiteColor].CGColor;
        _imgV.layer.borderWidth = 2;
        [_imgV sd_setImageWithURL:[NSURL URLWithString:ann.model.url] placeholderImage: [UIImage imageNamed:@""]];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgV];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(void)setIsselted:(BOOL)isselted {
    _isselted = isselted;
    if (isselted) {
        [UIView animateWithDuration:0.1 animations:^{
            self.bounds = CGRectMake(0, 0, 80, 80);
        }];
        
        [self layoutIfNeeded];
    } else {
        self.bounds = CGRectMake(0, 0, 60, 60);
        [self layoutIfNeeded];
        [self setSelected:NO animated:YES];
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _imgV.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
