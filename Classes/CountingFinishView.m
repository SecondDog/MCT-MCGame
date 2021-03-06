//
//  FinishView.m
//  MCGame
//
//  Created by kwan terry on 13-5-22.
//
//

#import "CountingFinishView.h"
#import "PopChangeUserViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MCFonts.h"

#define BLACK_BAR_COMPONENTS_Finish				{ 0.22, 0.22, 0.22, 1.0, 0.07, 0.07, 0.07, 1.0 }
@implementation CountingFinishView
@synthesize viewLoadedFromXib,finishViewType;
@synthesize changeUserPopover = _changeUserPopover;
@synthesize lastingTime;
@synthesize userNameEditField;
@synthesize raceTimeLabel;
@synthesize raceStepCountLabel;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title{
    if ((self = [super initWithFrame:frame])) {
		
        self.x_outerMargin = 137;
        self.y_outerMargin = 134;
        
        self.isShowColseBtn = YES;
        // Margin between edge of panel and the content area. Default = 20.0
        self.innerMargin =  0.0f;
        
        // Border color of the panel. Default = [UIColor whiteColor]
        self.borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        
        // Border width of the panel. Default = 1.5f;
        self.borderWidth = 0.0f;
        
        // Corner radius of the panel. Default = 4.0f
        self.cornerRadius = 0;
        
        // Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
        self.contentColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        
        // Shows the bounce animation. Default = YES
        self.shouldBounce = YES;
        finishViewType = kFinishView_Default;
        // Height of the title view. Default = 40.0f
        [self setTitleBarHeight:0.0f];
        
        // The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = UAGradientBackgroundStyleLinear
        [[self titleBar] setGradientStyle:UAGradientBackgroundStyleLinear];
        
        // The line mode of the gradient view (top, bottom, both, none). Top is a white line, bottom is a black line.
        [[self titleBar] setLineMode: UAGradientLineModeBottom];
        
        // The noise layer opacity. Default = 0.4
        [[self titleBar] setNoiseOpacity:0.8];
        
        // The header label, a UILabel with the same frame as the titleBar
        [self headerLabel].font = [UIFont boldSystemFontOfSize:floor(self.titleBarHeight / 2.0)];
        
        [[NSBundle mainBundle] loadNibNamed:@"CountingFinishView" owner:self options:nil];
        
        for (UIView *view in [self.contentContainer subviews]) {
            [view removeFromSuperview];
        }
        
        CGRect xibViewFrame = viewLoadedFromXib.frame;
        CGRect contentContainerFrame = self.contentContainer.frame;
        
        viewLoadedFromXib.frame = CGRectMake((contentContainerFrame.size.width - xibViewFrame.size.width)/2,
                                             (contentContainerFrame.size.height - xibViewFrame.size.height)/2, xibViewFrame.size.width, xibViewFrame.size.height);
        
        [self.contentContainer addSubview:viewLoadedFromXib];
        
        // Set user name.
        [self updateUserName];
        
        // Init panel for choosing user
        PopChangeUserViewController *contentForChangeUser = [[PopChangeUserViewController alloc] init];
        _changeUserPopover = [[UIPopoverController alloc] initWithContentViewController:contentForChangeUser];
        _changeUserPopover.popoverContentSize = CGSizeMake(320., 216.);
        _changeUserPopover.delegate = self;
        [contentForChangeUser release];
        
        
        [self.window makeKeyAndVisible];
        
        // KnowledgePanel
        viewLoadedFromXib.layer.cornerRadius = 5.0;
        _knowledgePanel.layer.cornerRadius = 6.0;
        _userNameEditPanel.layer.cornerRadius = 5.0;
        
        // Set font
        [_celebrationLabel setFont:[MCFonts customFontWithSize:35]];
        [_userNameLabel setFont:[MCFonts customFontWithSize:23]];
        [_raceStepTitleLabel setFont:[MCFonts customFontWithSize:23]];
        [_raceScoreTitleLabel setFont:[MCFonts customFontWithSize:23]];
        [_raceTimeTitleLabel setFont:[MCFonts customFontWithSize:23]];
        [raceStepCountLabel setFont:[MCFonts customFontWithSize:23]];
        [_raceScoreLabel setFont:[MCFonts customFontWithSize:23]];
        [raceTimeLabel setFont:[MCFonts customFontWithSize:23]];
        [userNameEditField setFont:[MCFonts customFontWithSize:18]];
        [_knowLedgeTextView setFont:[MCFonts customFontWithSize:17]];
        [_knowledgeTitleLabel setFont:[MCFonts customFontWithSize:19]];
    }    
	return self;

};

- (IBAction)goBackBtnPressed:(id)sender{
    if ([self insertRecord]) {
        finishViewType = kFinishView_GoBack;
        if ([delegate respondsToSelector:@selector(shouldCloseModalPanel:)]) {
            if ([delegate shouldCloseModalPanel:self]) {
                UADebugLog(@"Closing using delegates for modalPanel: %@", self);
                [self hide];
            }
        }
    }
};

- (IBAction)oneMoreBtnPressed:(id)sender{
    if ([self insertRecord]) {
        // append here
    }
};

- (IBAction)goCountingBtnPressed:(id)sender{
    if ([self insertRecord]) {
        // append here
    }
};

- (IBAction)shareBtnPressed:(id)sender{
    if ([self insertRecord]) {
        // append here
    }
};

- (IBAction)changeUserBtn:(id)sender {
    UIButton *tapbtn = (UIButton*)sender;
    
    [_changeUserPopover presentPopoverFromRect:tapbtn.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)dealloc {
	[viewLoadedFromXib release];
    [userNameEditField release];
    [_changeUserPopover release];
    [raceTimeLabel release];
    [raceStepCountLabel release];
    [_changeUserBtn release];
    [_knowledgePanel release];
    [_celebrationLabel release];
    [_userNameLabel release];
    [_raceTimeTitleLabel release];
    [_raceStepTitleLabel release];
    [_knowledgeTitleLabel release];
    [_knowLedgeTextView release];
    [_userNameEditPanel release];
    [_raceScoreLabel release];
    [_raceScoreTitleLabel release];
    [super dealloc];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}



/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    // Update user name
    [self updateUserName];
}


- (void)updateUserName{
    // Set current user name
    MCUserManagerController *userManagerController = [MCUserManagerController sharedInstance];
    if (userManagerController.userModel.currentUser.name == nil || [userManagerController.userModel.currentUser.name compare:@""] != NSOrderedSame) {
        self.userNameEditField.text = userManagerController.userModel.currentUser.name;
    }
    
    // If no user, set change btn invalide.
    if ([userManagerController.userModel.allUser count] < 2) {
        [self.changeUserBtn removeFromSuperview];
    }
}

- (BOOL)insertRecord{
    if ([self.userNameEditField.text compare:@""] == NSOrderedSame) {
        // Alter nil
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"用户名不能为空" message:@"你所输入的用户名为空,请输入其他再试一次" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    // While closing, save time and step date.
    MCUserManagerController *userManagerController = [MCUserManagerController sharedInstance];
    
    if (userManagerController.userModel.currentUser.name != nil && [userManagerController.userModel.currentUser.name compare:self.userNameEditField.text] == NSOrderedSame) {
        [userManagerController createNewScoreWithMove:self.stepCount Time:self.lastingTime];
    }
    else{
        // New user, create it.
        [userManagerController createNewUser:self.userNameEditField.text];
        [userManagerController createNewScoreWithMove:self.stepCount Time:self.lastingTime];
    }
    
    // Save current user name.
    [userManagerController saveCurrentUser];
    
    return  YES;
}



@end
