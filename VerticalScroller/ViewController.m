//
//  ViewController.m
//  VerticalScroller
//
//  Created by Macx on 2017/11/16.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ViewController.h"

//竖向跑马灯
#import "SMKCycleScrollView.h"

//横向跑马灯
#import "CLRollLabel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SMKCycleScrollView * cycleScrollView;

@property (nonatomic, strong) CLRollLabel * rollLabel;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 45 * 4) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor brownColor];
    [self verticalScrollView];
    [self horScrollView];
    [self initData];
    [self addTimer];
}

/**
 横向跑马灯
 */
- (void) horScrollView
{
    self.rollLabel = [[CLRollLabel alloc] initWithFrame:CGRectMake(50, 150, self.view.bounds.size.width - 100, 30) font:[UIFont systemFontOfSize:12] textColor:[UIColor darkGrayColor]];
    self.rollLabel.rollSpeed = 0.3;
    [self.view addSubview:self.rollLabel];
    
    self.rollLabel.text = @"散落了一地的光阴，被岁月穿成了念珠，开成了善意的花朵，即便是有盛开，有凋零，也会在光阴的诗行里，书写深情款款。";
}

/**
 竖向跑马灯(单行)
 */
- (void) verticalScrollView
{
    self.cycleScrollView = [[SMKCycleScrollView alloc] init];
    self.cycleScrollView.frame = CGRectMake(50, 100, self.view.bounds.size.width - 100 ,30 );
    self.cycleScrollView.backColor = [UIColor whiteColor];
    
    self.cycleScrollView.titleColor = [UIColor darkGrayColor];
    self.cycleScrollView.titleFont = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.cycleScrollView];
    
    self.cycleScrollView.titleArray =  @[@"aaaaaaa",@"bbbbbb"];
    [self.cycleScrollView setSelectedBlock:^(NSInteger index, NSString *title) {
        //        NSLog(@"%zd-----%@",index,title);
    }];
}

/**
 竖向跑马灯(多行)
 */
- (void) initData
{
    self.dataArray = [NSMutableArray arrayWithArray:@[@"xxxxxxxx",@"yyyyyyyy",@"zzzzzzzz",@"sssssssss",@"pppppppp",@"mmmmmmm",@"nnnnnnnnn"]];
    [self.tableView reloadData];
}

/**
 设置定时器
 */
- (void) addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 重排数据
 */
- (void) loadData
{
    if (self.dataArray.count == 0) {
        
        return;
    }
    NSString * string = self.dataArray[0];
    for (int i = 0; i< self.dataArray.count - 1; i++)
    {
        self.dataArray[i] = self.dataArray[i+1];
    }
    self.dataArray[self.dataArray.count - 1] = string;
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
