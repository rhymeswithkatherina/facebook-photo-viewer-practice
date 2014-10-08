//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var imageView : UIImageView!
    var isPresenting : Bool = true
    var offset : Float!
    
    @IBAction func onTap(sender: AnyObject) {
        println("detected tap")
        imageView = sender.view as UIImageView!
        
        performSegueWithIdentifier("bigModal", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as bigPhotoViewController
        
        //inserts image
        destinationVC.image = self.imageView.image
        
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var window = UIApplication.sharedApplication().keyWindow
        var frame = window.convertRect(imageView.frame, fromView: self.scrollView)
        var tempImage = UIImageView(frame: frame)
        
        
        if (isPresenting ) {
            
            tempImage.image = imageView.image
            tempImage.contentMode = UIViewContentMode.ScaleAspectFill
            tempImage.clipsToBounds = true
            
            view.addSubview(tempImage)
            
            println("is presenting true")
            println(imageView.center)
            
            containerView.addSubview(toViewController.view)
            if let vc = toViewController as? bigPhotoViewController {
                vc.imageView.hidden = true
            }
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
               self.prepForTransition(tempImage)
                toViewController.view.alpha = 1
                
                }) { (finished: Bool) -> Void in
                    if let vc = toViewController as? bigPhotoViewController {
                        vc.imageView.hidden = false
                    }
                    tempImage.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    
            }
        
        } else {
            
            println("is not presenting")
            println(imageView.center)
            
            tempImage.image = imageView.image
            tempImage.contentMode = UIViewContentMode.ScaleAspectFill
            tempImage.clipsToBounds = true
            
            view.addSubview(tempImage)
            
            prepForTransition(tempImage)
            
            toViewController.view.alpha = 1
           // toViewController.view.image
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                fromViewController.view.alpha = 0
                tempImage.frame = frame
                
                }) { (finished: Bool) -> Void in
                    println("finished not presenting state")
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                    tempImage.removeFromSuperview()
                }
        }
    }

    
    func prepForTransition(tempImage : UIImageView!) {
        tempImage.frame.size.width = 320
        tempImage.frame.size.height = 320 * (tempImage.image!.size.height/tempImage.image!.size.width)
        tempImage.center.x = 320/2
        tempImage.center.y = 568/2

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
}
