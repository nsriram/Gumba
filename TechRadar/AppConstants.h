#import <Foundation/Foundation.h>
#define TECHNIQUES @"Techniques"
#define LANGUAGES @"Languages"
#define TOOLS @"Tools"
#define PLATFORMS @"Platforms"
#define GUMBA @"gumba"
#define JSON @"json" 
#define TRIANGLE_TEXT_ANGLE 0.0
#define CIRCLE_TEXT_ANGLE 0.0
#define RADAR_RATIO 0.9
#define CIRCLE_RADIUS 10.0
#define TRIANGLE_SIDE 10.0

@interface AppConstants : NSObject
+(UIColor*) backgroundColor;
+(UIColor*) detailBackgroundColor;
+(UIColor*) blipColor;
+(UIColor*) barButtonColor;
+(UIColor*) textColor;
+(CGGradientRef) backgroundGradient;
+(UIFont*) labelTextFont;
+(UIFont*) circleTextFont;
+(UIFont*) titleTextFont;
+(UIFont*) blipTextFont;
+(UIFont*) boldLabelTextFont;
@end