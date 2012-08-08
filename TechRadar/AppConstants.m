#import "AppConstants.h"

@implementation AppConstants

+(UIColor*) backgroundColor{
    return [UIColor colorWithRed: 70.0/255.0 green: 130.0/255.0 blue: 170.0/255.0 alpha: 0.9];
}

+(UIColor*) barButtonColor{
    return [UIColor colorWithRed: 55/255.0 green: 56.0/255.0 blue: 60.0/255.0 alpha: 1.0];
}

+(UIColor*) blipColor{
    return [UIColor colorWithRed: 69/255.0 green: 170.0/255.0 blue: 225.0/255.0 alpha: 1.0];
}

+(CGGradientRef) backgroundGradient {
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  231.0/255.0, 231.0/255.0, 232.0/255.0, 0.9,
        218.0/255.0, 219.0/255.0, 220.0/255.0, 0.9 };
    return CGGradientCreateWithColorComponents (CGColorSpaceCreateDeviceRGB(),components,locations,num_locations);
}
@end