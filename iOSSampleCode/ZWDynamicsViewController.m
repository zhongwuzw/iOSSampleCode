//
//  ZWDynamicsViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/11.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWDynamicsViewController.h"

@interface ZWDynamicsViewController () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, assign) BOOL firstContact;

@end

@implementation ZWDynamicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* square = [[UIView alloc] initWithFrame:
                      CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor]; [self.view addSubview:square];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    
    [_animator addBehavior:_gravity];
    
    UIDynamicItemBehavior* itemBehaviour =
    [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    
    itemBehaviour.elasticity = 0.6; [_animator addBehavior:itemBehaviour];
    
    UIView* barrier = [[UIView alloc]
                       initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor]; [self.view addSubview:barrier];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    _collision.translatesReferenceBoundsIntoBoundary = YES; [_animator addBehavior:_collision];
    
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width,
                                    barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrier.frame.origin toPoint:rightEdge];
    
    _collision.collisionDelegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollisionBehaviorDelegate
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
    if (!_firstContact) {
        _firstContact = YES;
        
        
        UIView* square = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 100, 100)];
        square.backgroundColor = [UIColor grayColor]; [self.view addSubview:square];
        [_collision addItem:square]; [_gravity addItem:square];
        
        UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:item attachedToItem:square];
        [_animator addBehavior:attach];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
