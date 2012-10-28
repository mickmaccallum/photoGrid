//  ViewController.m
//
//  Created by Michael MacCallum on 10/28/12.
//  NO COPYRIGHT AND ABSOLUTELY NO WARRANTY EXPRESSED OR IMPLIED
//
#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUInteger buttonWidth = 100;
    NSUInteger buttonHeight = 100;
    NSUInteger space = 5;

    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSInteger numberOfAssets = [group numberOfAssets];
        if (numberOfAssets > 0) {
            float scrollContentY = (ceilf((float)numberOfAssets / 3) * (buttonHeight + space));
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger idx, BOOL *stop) {
                int row = idx / 3;
                int column = idx % 3;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake((buttonWidth + space) * column + space, (buttonHeight + space) * row + space , buttonWidth, buttonHeight);
                [button setBackgroundImage:[UIImage imageWithCGImage:[result thumbnail]] forState:UIControlStateNormal];
                [self.scrollView addSubview:button];
                [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, scrollContentY)];
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end