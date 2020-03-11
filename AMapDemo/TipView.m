//
//  TipView.m
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/12.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "TipView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface TipView()

@property (nonatomic, strong)UIImageView *headerImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *shopNameLabel;
@property (nonatomic, strong)UIButton *closeBtn;

@end

@implementation TipView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.headerImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.shopNameLabel];
        [self addSubview:self.closeBtn];
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@10);
            make.width.height.equalTo(@30);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImageView);
            make.left.equalTo(self.headerImageView.mas_right).offset(5);
        }];
        
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headerImageView);
            make.right.equalTo(@-10);
            make.width.height.equalTo(@20);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.headerImageView.layer.cornerRadius = CGRectGetHeight(self.headerImageView.frame)/2;
            self.headerImageView.layer.masksToBounds = YES;
        });
    }
    return self;
}

-(void)setModel:(BaseModel *)model {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = model.name;
    self.shopNameLabel.text = model.shopName;
}

- (void)close:(UIButton *)sender {
    if (_tipviewClose) {
        _tipviewClose();
    }
}

-(UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [UIImageView new];
    }
    return _headerImageView;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

-(UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        _shopNameLabel = [UILabel new];
    }
    return _shopNameLabel;
}

-(UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundColor:[UIColor redColor]];
        [_closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


@end
