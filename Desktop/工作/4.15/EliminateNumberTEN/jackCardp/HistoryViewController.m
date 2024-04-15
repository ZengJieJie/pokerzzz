#import "HistoryViewController.h"
#import "HistoryItem.h"

@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<HistoryItem *> *historyItems;
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UILabel *noDataLabel;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; // 半透明背景
    
    // 添加全屏背景图
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"fullscreenBackgroundImage"];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImageView];
    
    // 添加返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backButtonImage"] forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(20, 50, 80, 40);
    [self.view addSubview:backButton];
    
    // 添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, CGRectGetWidth(self.view.bounds) - 40, 30)];
    titleLabel.text = @"History";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor]; // 白色文字
    [self.view addSubview:titleLabel];
    
    [self setupTableView];
    [self loadHistoryItems];
}

- (void)setupTableView {
    CGFloat tableViewWidth = CGRectGetWidth(self.view.bounds) - 60; // 调整表格宽度
    CGFloat tableViewHeight = CGRectGetHeight(self.view.bounds) - 220; // 调整表格高度
    CGRect tableViewFrame = CGRectMake((CGRectGetWidth(self.view.bounds) - tableViewWidth) / 2, 100, tableViewWidth, tableViewHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 隐藏分割线
    self.tableView.layer.cornerRadius = 10.0; // 添加一点点圆角
    self.tableView.layer.masksToBounds = YES; // 裁剪子视图
    [self.view addSubview:self.tableView];
    
    // 暂无数据的提示信息背景板
    self.noDataView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    self.noDataView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.noDataView.layer.cornerRadius = 10.0; // 圆角
    self.noDataView.hidden = YES;
    [self.tableView addSubview:self.noDataView];
    
    // 暂无数据的提示文字信息
    self.noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.noDataView.bounds), 30)];
    self.noDataLabel.text = @"No History";
    self.noDataLabel.textAlignment = NSTextAlignmentCenter;
    self.noDataLabel.font = [UIFont systemFontOfSize:18];
    self.noDataLabel.textColor = [UIColor whiteColor];
    [self.noDataView addSubview:self.noDataLabel];
    self.noDataLabel.center = CGPointMake(CGRectGetMidX(self.noDataView.bounds), CGRectGetMidY(self.noDataView.bounds));
}

- (void)loadHistoryItems {
    // Load history items from local storage (e.g., UserDefaults)
    // Example: Retrieve NSArray from UserDefaults
    NSArray *savedItems = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryItems"];
    
    // Convert NSArray to NSMutableArray of HistoryItem objects
    self.historyItems = [NSMutableArray array];
    for (NSDictionary *dict in savedItems) {
        HistoryItem *item = [[HistoryItem alloc] init];
        item.date = dict[@"Date"];
        item.score = [dict[@"Score"] integerValue];
        [self.historyItems addObject:item];
    }
    
    // Sort history items by score in descending order
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    [self.historyItems sortUsingDescriptors:@[sortDescriptor]];
    
    // Reload table view data
    [self.tableView reloadData];
    self.noDataView.hidden = (self.historyItems.count > 0); // 隐藏或显示暂无数据的提示信息
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HistoryCell"];
        cell.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7]; // 半透明黑色背景
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 禁用选中效果
    }
    
    HistoryItem *item = self.historyItems[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)item.score];
    cell.detailTextLabel.text = [self formatDate:item.date];
    cell.textLabel.textColor = [UIColor whiteColor]; // 白色文字
    cell.detailTextLabel.textColor = [UIColor whiteColor]; // 白色文字
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - Helper Methods

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterMediumStyle;
    return [formatter stringFromDate:date];
}

- (void)backButtonTapped {
    // 返回按钮点击事件处理
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

