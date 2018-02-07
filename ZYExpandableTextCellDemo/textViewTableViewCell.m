//
//  textViewTableViewCell.m
//  ZYExpandableTextCellDemo
//
//  Created by 中商国际 on 2018/2/6.
//  Copyright © 2018年 中商国际. All rights reserved.
//

#import "textViewTableViewCell.h"
#import "ZY_TextView.h"
#define kPadding 5

@interface textViewTableViewCell ()<UITextViewDelegate>
@property (nonatomic, strong) ZY_TextView * textView;
@end

@implementation textViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.textView];
    }
    return self;
}
- (ZY_TextView *)textView
{
    if (_textView == nil) {
        CGRect cellFrame = self.contentView.bounds;
        cellFrame.origin.y += kPadding;
        cellFrame.size.height -= kPadding;
        //cellFrame.size.width  -= self.frame.size.width - 80;
        
        _textView = [[ZY_TextView alloc] initWithFrame:CGRectMake(80, cellFrame.origin.y, cellFrame.size.width - 80, cellFrame.size.height)];
        _textView.delegate = self;
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.textAlignment = NSTextAlignmentRight;
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        // textView.contentInset = UIEdgeInsetsZero;
    }
    return _textView;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil){
        _leftLabel = [UILabel new];
        _leftLabel.frame = CGRectMake(10, 0, 70, self.frame.size.height);
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor blackColor];
    }
    return _leftLabel;
}
- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI
    self.textView.text = text;
}

- (CGFloat)cellHeight
{
    return [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height + kPadding * 2;
}


#pragma mark - Text View Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(ExpandableTableViewDelegate)]) {
        
        id<ExpandableTableViewDelegate> delegate = (id<ExpandableTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
        _text = self.textView.text;
        //NSLog(@"%@",self.textView.text);
        [delegate tableView:self.expandableTableView
                updatedText:_text
                atIndexPath:indexPath];
        
        CGFloat newHeight = [self cellHeight];
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        if (fabs(newHeight - oldHeight) > 0.01) {
            
            // update the height
            if ([delegate respondsToSelector:@selector(tableView:updatedHeight:atIndexPath:)]) {
                [delegate tableView:self.expandableTableView
                      updatedHeight:newHeight
                        atIndexPath:indexPath];
            }
            
            // refresh the table without closing the keyboard
            [self.expandableTableView beginUpdates];
            [self.expandableTableView endUpdates];
        }
    }

}


@end

#pragma mark -

@implementation UITableView (ACEExpandableTextCell)

- (textViewTableViewCell *)expandableTextCellWithId:(NSString *)cellId
{
    textViewTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[textViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end

