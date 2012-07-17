#import "Quadrant.h"

@implementation Quadrant

@synthesize name = _name, start = _start,end = _end, circles = _circles, triangles = _triangles;

-(id) initWithName:(NSString*)name Start:(NSInteger)start End:(NSInteger)end {
    self = [super init];
    if(self){
        _name=name;
        _start = start;
        _end = end;
    }
    return self;
}

-(void) addCircle:(Item*) item {
    [_circles addObject:item];
}

-(void) addTriangle:(Item*) item {
    [_triangles addObject:item];
}
@end