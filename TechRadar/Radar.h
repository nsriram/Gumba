#import <Foundation/Foundation.h>
#import "Quadrant.h"

@interface Radar : NSObject

@property (nonatomic, strong) NSMutableArray* quadrants;

- (void) addQuadrant:(Quadrant*)quadrant;
- (void) print;
+ (Radar*)radarFromFile:(NSString*)fileName;

@end