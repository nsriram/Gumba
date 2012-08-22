#import <Foundation/Foundation.h>

@interface Item : NSObject
@property (nonatomic, strong) NSString* tip;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, assign) NSInteger theta;
@property (nonatomic, assign) NSInteger index;

-(id) initWithName:(NSString*)name Tip:(NSString*)tip Description:(NSString*)description Index:(NSInteger)index Radius:(NSInteger)radius End:(NSInteger)theta;
-(CGPoint) raster;
@end