//
//  ViewController.m
//  WKWebViewTest
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

#import "ItemBankHeadCell.h"
#import "ItemBankDetailCell.h"
#import "ItemBankServiceCell.h"
#import "TimeHelper.h"
#import "Util.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, WKUIDelegate, WKNavigationDelegate>
{
    CGFloat _webHeight;
}
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIScrollView *scrollViews;

@property (nonatomic,strong) ItemBankHeadCell* headCell;

@property (nonatomic,assign) BOOL flag;//是否翻转的动画

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webHeight = 0.0;
    
    [self setupWebView];
    
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
   [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = false;
    [self.tableView registerNib:[UINib nibWithNibName:@"ItemBankHeadCell" bundle:nil] forCellReuseIdentifier:@"ItemBankHeadCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"ItemBankDetailCell" bundle:nil] forCellReuseIdentifier:@"ItemBankDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ItemBankServiceCell" bundle:nil] forCellReuseIdentifier:@"ItemBankServiceCell"];
    
    [self.dataArray addObject:@"1"];
    [self.dataArray addObject:@"2"];
    [self.dataArray addObject:@"3"];
    [self.tableView reloadData];
    
    
    UIButton *rollBtn  = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, kScreenHeight-100, 70, 35)];
    rollBtn.backgroundColor = [Util colorWithHexString:@"14C5AA"];
    [rollBtn addTarget:self action:@selector(rollAction) forControlEvents:UIControlEventTouchUpInside];
    [rollBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rollBtn setTitle:@"翻转动画" forState:UIControlStateNormal];
    rollBtn.titleLabel.font  = kFont_Medium(14);
    rollBtn.layer.cornerRadius = 5;
    [self.view addSubview:rollBtn];
    
    _flag  = false;
}
- (void)rollAction
{
    if (_flag) {
        return;
    }
    [self.headCell setCostPriceView:NO];
    [self rotateView:self.headCell.itemLowPriceView];
    _flag = !_flag;
}
- (void)rotateView:(UIView *)view
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:M_PI/2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = 0;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)setupWebView
{
      WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
       WKUserContentController *wkUController = [[WKUserContentController alloc] init];
       config.userContentController = wkUController;
    // 自适应屏幕宽度js
       NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
       WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
       // 添加js调用
       [wkUController addUserScript:wkUserScript];
    
       self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-30, 1) configuration:config];
       self.webView.backgroundColor = [Util colorWithHexString:@"F2F2F2"];
       self.webView.opaque = NO;
       [self.webView sizeToFit];
       self.webView.scrollView.bounces = NO;
        
       self.webView.scrollView.scrollEnabled = NO;//禁用webView滑动
        self.webView.scrollView.userInteractionEnabled = NO;
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
        NSURLRequest *cacheRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:cacheRequest];
        //监听webView.scrollView的contentSize属性
        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
       self.scrollViews = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 55, kScreenWidth-30, 1)];
       [self.scrollViews addSubview:self.webView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
//        __weak typeof(self) weakSelf = self;
//执行js方法"document.body.offsetHeight" ，获取webview内容高度
        [_webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat contentHeight = [result floatValue];
            
            NSLog(@"contentHeight=%f",contentHeight);

                _webHeight = contentHeight;
                self.webView.frame = CGRectMake(0, 0, kScreenWidth-30, _webHeight);
            
                 self.scrollViews.frame = CGRectMake(15, 55, kScreenWidth-30, _webHeight);
                 self.scrollViews.contentSize =CGSizeMake(kScreenWidth-30, _webHeight);
            
                _webHeight += 60;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

#pragma mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArray.count - 1) {
        return _webHeight;
    }
    if (indexPath.row == 0) {
        return 348;
    }
    if (indexPath.row == 1) {
        return 83;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
            {
                static NSString *cellId = @"ItemBankHeadCell";
                ItemBankHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
                }
                cell.tagArray = @[@"考前押题",@"模拟练习"];
                [self setBottomViewLine:cell.costPriceLabel withPrice: @"¥268"];
                [cell setCostPriceView:!_flag];
                self.headCell = cell;
                return cell;
            }
            break;
            case 1:
            {
                static NSString *cellId = @"ItemBankServiceCell";
               ItemBankServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
               if (!cell) {
                   cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
                   cell.selectionStyle = UITableViewCellSelectionStyleNone ;
               }
               return cell;
            }
            break;
        default:
        {
            static NSString *cellId = @"ItemBankDetailCell";
               ItemBankDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone ;
               [cell.contentView addSubview:self.scrollViews];
              return cell;
        }
            break;
    }
    
}
- (void)setBottomViewLine:(UILabel *)l withPrice:(NSString *) price
{
    NSString *textStr = price;
    //中划线
     NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
     NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
     // 赋值
     l.attributedText = attribtStr;
}

- (void)dealloc
{
    [[TimeHelper share]stopTimer];
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
@end
