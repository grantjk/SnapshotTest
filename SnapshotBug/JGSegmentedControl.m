#import "JGSegmentedControl.h"

@interface JGSegmentedControl ()
@property (nonatomic, strong) UIColor *dividerColor;
@end

@implementation JGSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.dividerColor = [UIColor colorWithRed:48/255.0 green:49/255.0f blue:48/255.0f alpha:1];
    
    [self setBackgroundImage:[self drawBackgroundImageWithColor:[UIColor whiteColor]]
                    forState:UIControlStateNormal
                  barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self drawBackgroundImageWithColor:self.dividerColor]
                    forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];
    
    UIImage *divider = [self drawDividerImage];
    [self setDividerImage:divider
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:divider
      forLeftSegmentState:UIControlStateSelected
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];

    [self setDividerImage:divider
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateSelected
               barMetrics:UIBarMetricsDefault];
    
    self.tintColor = [UIColor blackColor];
    
    NSDictionary *titleTextAttributes = @{
                                          NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:10],
                                          };
    if ([[titleTextAttributes allKeys] count] > 0) {
        [self setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }

    NSDictionary *selectedSegmentAttributeOverrides = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    if ([[selectedSegmentAttributeOverrides allKeys] count] > 0) {
        NSMutableDictionary *selectedTitleTextAttributes = [titleTextAttributes mutableCopy];
        [selectedTitleTextAttributes addEntriesFromDictionary:selectedSegmentAttributeOverrides];
        [self setTitleTextAttributes:[selectedTitleTextAttributes copy] forState:UIControlStateSelected];
    }

    return self;
}

- (UIImage *)drawBackgroundImageWithColor:(UIColor *)color
{
    CGFloat cornerRadius = 4.0f;
    CGSize size = CGSizeMake(20, 30.0f);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGRect rect = CGRectMake(0.5, 0.5, size.width-1, size.height-1);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    [self.dividerColor setStroke];
    [color setFill];
    [path fill];
    [path stroke];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)];
}

- (UIImage *)drawDividerImage
{
    CGSize size = CGSizeMake(1, 30.0f);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    [self.dividerColor setStroke];
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 0, 1)];
}

@end
