//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by user on 10/8/22.
//  Copyright © 2022 Dan. All rights reserved.
//
import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var favourited:Bool = false
    var tweetId:Int = -1
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setFavourite(_ isFavourited:Bool){
        favourited = isFavourited
        if (favourited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    @IBAction func favouriteTweet(_ sender: Any) {
        let toBeFavorited = !favourited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (error) in
                print("Favorite fail \(error )")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure: { (error) in
                print("Unfavorite succeed \(error )")
            })
        }
    }
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
             self.setRetweeted(true)
        }, failure: { (error) in
            print("Error in retweeting \(error)")
        })
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
