#import "Item.h"

@implementation Item
@synthesize name= _name,theta = _theta, radius = _radius;

-(id) initWithName:(NSString*)name Radius:(NSInteger)radius End:(NSInteger)theta{
    self =   [super init];
    if(self){
        _name = name;
        _theta = theta;
        _radius = radius;
    }
    return self;
}
@end