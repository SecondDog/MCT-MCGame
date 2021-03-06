//
//  MCNormalPlaySceneController.h
//  MCGame
//
//  Created by kwan terry on 13-3-9.
//
//
#import <Foundation/Foundation.h>
#import "sceneController.h"
#import "MCMagicCube.h"
#import "MCMagicCubeUIModelController.h"
#import "RotateType.h"
#import "MCPlayHelper.h"
@interface MCNormalPlaySceneController : sceneController{
    MCMagicCubeUIModelController* magicCubeUI;
    MCMagicCube * magicCube;
    MCPlayHelper * playHelper;
    BOOL isShowQueue;
     UILabel *_tipsLabel;
    //float rotation_per_second;
}
@property (nonatomic,retain)MCMagicCube * magicCube;
@property (nonatomic,retain)MCPlayHelper * playHelper;
@property (assign)BOOL isShowQueue;
@property(nonatomic,retain)UILabel *tipsLabel;
//@property(assign)float rotation_per_second;
+ (MCNormalPlaySceneController*)sharedNormalPlaySceneController;
-(void)loadScene;
-(void)reloadScene;
- (void) rotateOnAxis : (AxisType)axis onLayer: (int)layer inDirection: (LayerRotationDirectionType)direction isTribleRotate:(BOOL)is_trible_roate;
-(void)rotate:(RotateType*)rotateType;
-(void)previousSolution;
-(void)nextSolution;
-(void)reloadLastTime;
-(void)showQueue;
-(void)checkIsOver;
-(void)closeSpaceIndicator;
-(void)releaseSrc;
@end
