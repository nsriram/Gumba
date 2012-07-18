#import <Foundation/Foundation.h>

@interface Item : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, assign) NSInteger theta;
@property (nonatomic, assign) NSInteger index;

-(id) initWithName:(NSString*)name Index:(NSInteger)index Radius:(NSInteger)radius End:(NSInteger)theta;
-(CGPoint) raster;

@end
