//
//  PhotoHomeViewController.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "PhotoHomeViewController.h"
#import "PhotoKitHeader.h"
#import "PhotoManager.h"
#import "AlbumModel.h"

static NSString *cellResuableID = @"UITableViewCell";

@interface PhotoHomeViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceMuArray;

@end

@implementation PhotoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH / 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellResuableID];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    AlbumModel *tempModel = self.dataSourceMuArray[indexPath.row];
    cell.textLabel.text = tempModel.title;
    cell.imageView.image = tempModel.thumbnail;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - publicMethod

+ (void)presentSelectPhoto:(UIViewController *)viewController{
    PhotoHomeViewController *tempVc = [PhotoHomeViewController new];
    UINavigationController *tempNav = [[UINavigationController alloc] initWithRootViewController:tempVc];
    
    [viewController presentViewController:tempNav animated:YES completion:nil];
}

#pragma mark - privateMethod

- (void)rightBarButtonClicked:(UIBarButtonItem *)barButtonItem{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tempView = [[UITableView alloc] init];
        
        tempView.delegate = self;
        tempView.dataSource = self;
        tempView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempView.backgroundColor = [UIColor clearColor];
        [tempView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellResuableID];
        
        _tableView = tempView;
    }
    return _tableView;
}

- (NSMutableArray *)dataSourceMuArray{
    if (!_dataSourceMuArray) {
        NSArray *tempArray = [[PhotoManager shareInstance] getAlbums];
        NSMutableArray *tempMuArray = [[NSMutableArray alloc] initWithArray:tempArray];
        
        _dataSourceMuArray = tempMuArray;
    }
    return _dataSourceMuArray;
}

@end
