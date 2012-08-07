#import "Item.h"
#import "AppConstants.h"

@implementation Item
@synthesize name= _name,index = _index,theta = _theta, radius = _radius, tip =_tip;

-(id) initWithName:(NSString*)name Tip:(NSString*)tip Index:(NSInteger)index Radius:(NSInteger)radius End:(NSInteger)theta{
    self =   [super init];
    if(self){
        _name = name;
        _tip = tip;
        _index = index;
        _theta = theta;
        _radius = radius;
    }
    return self;
}

-(CGPoint) raster{
    CGFloat x = _radius * RADAR_RATIO * cos((_theta * M_PI/180));
    CGFloat y = _radius * RADAR_RATIO * sin((_theta * M_PI/180));  
    return CGPointMake(x,y);
}
@end