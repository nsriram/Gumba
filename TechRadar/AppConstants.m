#import "AppConstants.h"

@implementation AppConstants

+(UIColor*) backgroundColor{
    return [UIColor colorWithRed: 220.0/255.0 green: 221.0/255.0 blue: 222.0/255.0 alpha: 1.0];
}

+(UIColor*) textColor{
    return [UIColor colorWithRed: 61.0/255.0 green: 125.0/255.0 blue: 150.0/255.0 alpha: 1.0];
}

+(UIColor*) detailBackgroundColor{
    return [AppConstants backgroundColor];
}

+(UIColor*) barButtonColor{
    return [UIColor colorWithRed: 55/255.0 green: 221.0/255.0 blue: 222.0/255.0 alpha: 1.0];
}

+(UIColor*) blipColor{
    return [UIColor colorWithRed: 255/255.0 green: 255.0/255.0 blue: 244.0/255.0 alpha: 1.0];
}

+(UIFont*) titleTextFont{
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:48.0];
}

+(UIFont*) labelTextFont{
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:15.0];
}

+(UIFont*) circleTextFont{
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:15.0];
}


+(UIFont*) boldLabelTextFont{
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:20.0];
}

+(UIFont*)blipTextLargeFont {
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:11.0];
}

+ (UIFont *)blipTextMediumFont {
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:11.0];
}

+ (UIFont *)blipTextSemiMediumFont {
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:9.5];
}

+(UIFont*)blipTextSmallFont {
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:9.0];
}
+ (UIFont *)blipTextTinyFont {
    return [UIFont fontWithName:@"FranklinGothicITCbyBT-Book" size:8.9];
}

+(CGGradientRef) backgroundGradient {
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  220.0/255.0, 221.0/255.0, 222.0/255.0, 1.0,
        220.0/255.0, 221.0/255.0, 222.0/255.0, 1.0 };
    return CGGradientCreateWithColorComponents (CGColorSpaceCreateDeviceRGB(),components,locations,num_locations);
}
@end