#import <UIKit/UIKit.h>

@interface ModernMenu : NSObject
@end

@implementation ModernMenu

static UIView *menuView;

+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self createMenu];
    });
}

+ (void)createMenu
{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    if (!window) return;

    // main menu
    menuView = [[UIView alloc] initWithFrame:CGRectMake(80, 140, 260, 320)];
    menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    menuView.layer.cornerRadius = 18;
    menuView.layer.shadowColor = UIColor.blackColor.CGColor;
    menuView.layer.shadowOpacity = 0.4;
    menuView.layer.shadowRadius = 10;

    [window addSubview:menuView];

    // enable dragging
    UIPanGestureRecognizer *drag =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragMenu:)];
    [menuView addGestureRecognizer:drag];

    // title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 260, 30)];
    title.text = @"Modern Menu";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColor.whiteColor;
    title.font = [UIFont boldSystemFontOfSize:20];
    [menuView addSubview:title];

    // scroll list
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 260, 260)];
    [menuView addSubview:scroll];

    NSArray *items = @[
        @"Item Alpha",
        @"Item Beta",
        @"Item Gamma",
        @"Item Delta",
        @"Map Forest",
        @"Map Desert",
        @"Map City"
    ];

    CGFloat y = 10;

    for (NSString *name in items)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(20, y, 220, 40);
        btn.layer.cornerRadius = 12;
        btn.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1 alpha:1];
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];

        [btn addTarget:self action:@selector(spawnPressed:)
      forControlEvents:UIControlEventTouchUpInside];

        [scroll addSubview:btn];
        y += 50;
    }

    scroll.contentSize = CGSizeMake(260, y + 20);
}

+ (void)spawnPressed:(UIButton *)sender
{
    NSString *name = sender.titleLabel.text;
    NSLog(@"Spawn pressed: %@", name);

    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Spawn"
                                        message:name
                                 preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];

    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)dragMenu:(UIPanGestureRecognizer *)pan
{
    CGPoint t = [pan translationInView:menuView.superview];
    menuView.center = CGPointMake(menuView.center.x + t.x, menuView.center.y + t.y);
    [pan setTranslation:CGPointZero inView:menuView.superview];
}

@end
