#import <Foundation/Foundation.h>

@interface Item : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, assign) NSInteger theta;
-(id) initWithName:(NSString*)name Radius:(NSInteger)radius End:(NSInteger)theta;
@end
