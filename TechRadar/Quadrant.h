#import <Foundation/Foundation.h>
#import "Item.h"

@interface Quadrant : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger end;

@property (nonatomic, strong) NSMutableArray* circles;
@property (nonatomic, strong) NSMutableArray* triangles;

-(id) initWithName:(NSString*)name Start:(NSInteger)start End:(NSInteger)end;
-(void) addCircle:(Item*) item;
-(void) addTriangle:(Item*) item;
@end