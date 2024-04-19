//
//  imageview.m
//  3Patti puke
//
//  Created by adin on 2024/3/25.
//

#import "imageview.h"

@implementation imageview


- (instancetype)initWithFrame:(CGRect)frame value:(NSInteger)value {
    self = [super initWithFrame:frame];
    if (self) {
        self.value = value;
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5.0;
        UIImageView * imageview=[[UIImageView alloc]initWithFrame:self.bounds];
        [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)value]]];
        [self addSubview:imageview];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
