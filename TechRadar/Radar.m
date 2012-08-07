#import "Radar.h"
#import "SBJson.h"

#define GUMBA @"gumba"
#define JSON @"json"
#define RADAR_QUADRANTS @"radar_quadrants"
#define RADAR_DATA @"radar_data"
#define NAME @"name"
#define TIP @"tip"
#define START @"start"
#define END @"end"
#define PC @"pc"
#define R @"r"
#define T @"t"
#define C @"c"
#define MOVEMENT @"movement"

@implementation Radar
@synthesize quadrants = _quadrants;

-(id) init {
    self = [super init];
    if(self){
        _quadrants = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSMutableDictionary *)fileContents:(NSString *)fileName {
    NSString *fileContent = @"";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:JSON];  
    if (filePath) {
        fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];  
    }
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    return [parser objectWithString:fileContent error:nil];
}

+ (Item *)item:(NSMutableDictionary *)radarItem index:(int)i{
    NSString *itemName = [radarItem objectForKey:NAME];
    NSString *itemTip = [radarItem objectForKey:TIP];
    NSMutableDictionary *itemPosition = [radarItem objectForKey:PC];
    NSInteger itemRadius = [[itemPosition objectForKey:R] integerValue];
    NSInteger itemTheta = [[itemPosition objectForKey:T] integerValue];
    return [[Item alloc] initWithName:itemName Tip:itemTip Index:i Radius:itemRadius End:itemTheta];
}

+ (Quadrant *)quadrant:(NSMutableDictionary *)radarQuadrant allPoints:(NSMutableArray *)allPoints {
    NSString *name =  [radarQuadrant objectForKey:NAME];
    NSInteger start =  [[radarQuadrant objectForKey:START] integerValue];
    NSInteger end =  [[radarQuadrant objectForKey:END] integerValue];
    
    Quadrant *quadrant = [[Quadrant alloc] initWithName:name Start:start End:end];
    for(int itemIndex = start; itemIndex < end; itemIndex = itemIndex +1 ){
        NSMutableDictionary *radarItem = [allPoints objectAtIndex:itemIndex];
        Item *item = [Radar item:radarItem index:itemIndex+1];
        NSString *movement = [radarItem objectForKey:MOVEMENT];            
        if([movement isEqualToString:C]){
            [quadrant addCircle:item];
        }else {
            [quadrant addTriangle:item];
        }
    }
    return quadrant;
}

+ (Radar*) radarFromFile:(NSString*) fileName {
    NSMutableDictionary *radarData = [Radar fileContents:fileName];    
    NSMutableArray *allQuadrants = [radarData objectForKey:RADAR_QUADRANTS];
    NSMutableArray *allPoints = [radarData objectForKey:RADAR_DATA];
    Radar *radar = [[Radar alloc]init];
    for(NSMutableDictionary *radarQuadrant in allQuadrants){
        Quadrant *quadrant = [Radar quadrant:radarQuadrant allPoints:allPoints];
        [radar addQuadrant:quadrant];
    }
    return radar;
}

- (void) addQuadrant:(Quadrant*)quadrant{
    [_quadrants addObject:quadrant];
}
@end