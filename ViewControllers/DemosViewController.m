//
//  DemosViewController.m
//  IGListKitDemo
//
//  Created by iOS on 2017/6/27.
//  Copyright © 2017年 lg. All rights reserved.
//

#import "DemosViewController.h"
#import <IGListKit.h>
#import "DemoSectionController.h"
#import "LoadMoreViewController.h"

@interface DemosViewController () <IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<DemoItem *> *demos;

@end

@implementation DemosViewController

- (void)initSetup {
    IGListAdapterUpdater *adapterUpdater = [[IGListAdapterUpdater alloc] init];
    _adapter = [[IGListAdapter alloc] initWithUpdater:adapterUpdater viewController:self];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    _demos = @[
               [DemoItem DemoItemWithName:@"Tail Loading" controllerClass:[LoadMoreViewController class]]
               ];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSetup];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - IGListAdapterDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.demos;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[DemoSectionController alloc] init];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end