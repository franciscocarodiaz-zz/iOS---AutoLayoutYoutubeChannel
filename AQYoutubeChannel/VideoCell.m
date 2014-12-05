#import "VideoCell.h"

@interface VideoCell ()

@end

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    self.imageCell.layer.cornerRadius = self.imageCell.frame.size.height/2;
    [self.imageCell setClipsToBounds:YES];
    self.imageCell.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    CGFloat move = 2.5;
    
    CGRect cellRect = CGRectInset(self.bounds, move, move);
    
    UIColor *color = [UIColor clearColor];
    
    UIBezierPath *shape = [UIBezierPath bezierPathWithRoundedRect:cellRect cornerRadius:15];
    [color setFill];
    [shape fill];
}

@end
