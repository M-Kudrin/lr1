//
//  RootTableViewController.m
//  GitHubTrending
//
//  Created by Developer on 22/08/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "RootTableViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "Repository.h"
#import "Contributor.h"
#import "RepositoryTableViewCell.h"

@interface RootTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Repository *> *repositories;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self checkNetworkConnection];
}

- (void)checkNetworkConnection {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        if (status == AFNetworkReachabilityStatusNotReachable){
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"No Internet Connection", nil)
                                                                           message:@""
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Try again", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self checkNetworkConnection];
            }];
            [alert addAction:tryAgainAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [self loadRepositories];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)setupInterface {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerNib];
    self.tableView.refreshControl = [UIRefreshControl new];
    [self.tableView.refreshControl addTarget:self action:@selector(loadRepositories) forControlEvents:UIControlEventValueChanged];
}

- (void)registerNib {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([RepositoryTableViewCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RepositoryTableViewCell"];
}

- (void)loadRepositories {
    self.repositories = [NSMutableArray new];
    [self.tableView.refreshControl beginRefreshing];
    NSURL * url = [NSURL URLWithString:@"https://github-trending-api.now.sh/repositories"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:url.absoluteString
      parameters:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             NSString *htmlString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSArray *dictionaries = [NSJSONSerialization JSONObjectWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
             for (NSDictionary *dictionary in dictionaries) {
                 Repository *repository = [[Repository alloc] initWithDictionary:dictionary];
                 [self.repositories addObject:repository];
             }
             [self.tableView reloadData];
             [self loadContributors];
             [self.tableView.refreshControl endRefreshing];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             [self.tableView.refreshControl endRefreshing];
             NSLog(@"Error: %@", error.localizedDescription);
        }
    ];
}

- (void)loadContributors {
    if (self.repositories.count > 0) {
        for (Repository * repository in self.repositories) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/stats/contributors", repository.author, repository.name]];
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFCompoundResponseSerializer serializer];
            [manager GET:url.absoluteString
              parameters:nil
                 success:^(NSURLSessionTask *task, id responseObject) {
                     NSMutableArray * contributors = [NSMutableArray new];
                     NSString *htmlString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSArray *dictionaries = [NSJSONSerialization JSONObjectWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
                     for (NSDictionary *dictionary in dictionaries) {
                         Contributor *contributor = [[Contributor alloc] initWithDictionary:[dictionary objectForKey:@"author"]];
                         [contributors addObject:contributor];
                     }
                     repository.contributors = contributors;
                 [self.tableView reloadData];
                 } failure:^(NSURLSessionTask *operation, NSError *error) {
                     NSLog(@"Error : %@", error.localizedDescription);
                 }
             ];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma marks - UITableViewDelegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryTableViewCell"];
    if (self.repositories.count > 0) {
        Repository *repository = self.repositories[indexPath.row];
        cell.repository = repository;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Repository *repository = self.repositories[indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:repository.url] options:nil completionHandler:nil];
}

@end
