#import "AppConstants.h"

@implementation AppConstants

+(UIColor*) backgroundColor{
    return [UIColor colorWithRed: 32.0/255.0 green: 134.0/255.0 blue: 174.0/255.0 alpha: 1.0];
}


+(UIColor*) detailBackgroundColor{
    return [UIColor colorWithRed: 32.0/255.0 green: 134.0/255.0 blue: 174.0/255.0 alpha: 1.0];
}

+(UIColor*) barButtonColor{
    return [UIColor colorWithRed: 55/255.0 green: 56.0/255.0 blue: 60.0/255.0 alpha: 1.0];
}

+(UIColor*) blipColor{
    return [UIColor colorWithRed: 255/255.0 green: 255.0/255.0 blue: 244.0/255.0 alpha: 1.0];
}

+(CGGradientRef) backgroundGradient {
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  32.0/255.0, 134.0/255.0, 174.0/255.0, 1.0,
        32.0/255.0, 134.0/255.0, 174.0/255.0, 1.0 };
    return CGGradientCreateWithColorComponents (CGColorSpaceCreateDeviceRGB(),components,locations,num_locations);
}
@end