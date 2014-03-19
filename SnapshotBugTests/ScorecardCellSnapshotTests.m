//
//  ScorecardCellSnapshotTests.m
//  SnapshotBug
//
//  Created by John Grant on 2014-03-18.
//  Copyright 2014 John Grant. All rights reserved.
//

#import "FBSnapshotTestCase.h"
#import "JGSegmentedControl.h"

@interface ScorecardCellSnapshotTests : FBSnapshotTestCase
@property (nonatomic, strong) JGSegmentedControl *segmentedControl;
@end

@implementation ScorecardCellSnapshotTests

- (void)setUp
{
    [super setUp];

    self.recordMode = NO;
}

- (void)tearDown
{
    [super tearDown];
}
- (void)testSegmentedControl
{
    JGSegmentedControl *control = [[JGSegmentedControl alloc] init];
    control.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.segmentedControl = control;
    [self setNumberOfRounds:4];

    [self forceLayoutInWidth:320];
    FBSnapshotVerifyView(control, nil);
}

- (void)setNumberOfRounds:(NSInteger)numberOfRounds
{
    [self.segmentedControl insertSegmentWithTitle:[self segmentStringForRound:1] atIndex:0 animated:NO];
    [self.segmentedControl insertSegmentWithTitle:[self segmentStringForRound:2] atIndex:1 animated:NO];
    [self.segmentedControl insertSegmentWithTitle:[self segmentStringForRound:3] atIndex:2 animated:NO];
    [self.segmentedControl insertSegmentWithTitle:[self segmentStringForRound:4] atIndex:3 animated:NO];
    
    [self.segmentedControl setSelectedSegmentIndex:1];
    
    for (int i = 0; i < self.segmentedControl.numberOfSegments; i++) {
        [self.segmentedControl setWidth:0 forSegmentAtIndex:i];
    }
}

- (NSString *)segmentStringForRound:(NSInteger)round
{
    return [NSString stringWithFormat:@"RD %ld", (long)round];
}

- (void)forceLayoutInWidth:(CGFloat)width
{
    JGSegmentedControl *control = self.segmentedControl;
    
    CGRect frame = control.frame;
    frame.size.width = 320;
    control.frame = frame;
    [control layoutSubviews];
    
    CGSize size = [control systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    frame = control.frame;
    frame.size.height = size.height;
    control.frame = frame;
}
@end