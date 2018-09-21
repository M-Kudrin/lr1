//
//  RepositoryTableViewCell.m
//  GitHubTrending
//
//  Created by Developer on 05/09/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "RepositoryTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface RepositoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *countForkLabel;
@property (weak, nonatomic) IBOutlet UILabel *countStarLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contributorImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *contributorImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *contributorImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *contributorImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *contributorImageView5;

@end

@implementation RepositoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setRepository:(Repository *)repository {
    _repository = repository;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ / %@", repository.author, repository.name];
    self.descriptionLabel.text = repository.descrtion;
    self.languageLabel.text = repository.language;
    self.countForkLabel.text = [NSString stringWithFormat:@"%ld", (long)repository.forks];
    self.countStarLabel.text =  [NSString stringWithFormat:@"%ld", (long)repository.stars];
    
    int index = 0;
    for (Contributor *contributor in repository.contributors) {
        switch (index) {
            case 0:
                [self.contributorImageView1 setImageWithURL:[NSURL URLWithString:contributor.avatarUrl]];
                break;
            case 1:
                [self.contributorImageView2 setImageWithURL:[NSURL URLWithString:contributor.avatarUrl]];
                break;
            case 2:
                [self.contributorImageView3 setImageWithURL:[NSURL URLWithString:contributor.avatarUrl]];
                break;
            case 3:
                [self.contributorImageView4 setImageWithURL:[NSURL URLWithString:contributor.avatarUrl]];
                break;
            case 4:
                [self.contributorImageView5 setImageWithURL:[NSURL URLWithString:contributor.avatarUrl]];
                break;
                
            default:
                break;
        }
        index++;
    }
}


@end
