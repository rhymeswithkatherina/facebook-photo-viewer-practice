//
//  bigPhotoViewController.swift
//  Facebook
//
//  Created by Katherina Nguyen on 10/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class bigPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var bigPhotoScrollView: UIScrollView!
    
    @IBOutlet weak var subTabBar: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var feedbackbar: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage!
    var offset : Float!

    @IBAction func onDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigPhotoScrollView.contentSize = CGSize(width: 320, height: image.size.height)
        
        imageView.image = image
        bigPhotoScrollView.zoomScale = 1
        
        
        bigPhotoScrollView.delegate = self
        
        // Do any additional setup after loading the view.

    }

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        println("I'm scrolling")
        
        offset = Float(scrollView.contentOffset.y)
        
        if offset > 0 {
            scrollView.frame.origin.y = 0
        }

        if offset <= 0 && offset > -20 {
            
            UIView.animateWithDuration(0.6, animations: { () -> Void in

                self.subTabBar.alpha = 1
                self.doneButton.alpha = 1
                self.view.backgroundColor = UIColor(white: 0, alpha: 1)
                
                }) { (finished: Bool) -> Void in
            }

            
        }
        
        if offset < -20 && offset > -100 {
            println("offset more than 20")
            
            UIView.animateWithDuration(0.6, animations: { () -> Void in
                self.view.backgroundColor = UIColor(white: 0, alpha: 0.2)
                self.subTabBar.alpha = 0
                self.doneButton.alpha = 0
                
                }) { (finished: Bool) -> Void in
            }
        }
        
        if offset < -100 {
            println("offset more than 100")
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.view.backgroundColor = UIColor(white: 0, alpha: 0)
                
                
                }) { (finished: Bool) -> Void in
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            println("I let go")
            if offset > -100 {
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    scrollView.frame.origin.y = 0
                    self.view.backgroundColor = UIColor(white: 0, alpha: 1)
                    self.subTabBar.alpha = 1
                    self.doneButton.alpha = 1
                    
                    }) { (finished: Bool) -> Void in
                }
                
            }
            
            if offset < -100 {
                println("scrollview stopped, offset more than 100")
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    self.subTabBar.alpha = 0
                    self.doneButton.alpha = 0
                    self.bigPhotoScrollView.alpha = 0
                
                self.dismissViewControllerAnimated(true, completion: nil)
              
                    
                    }) { (finished: Bool) -> Void in
                        
                }
            }
    }

    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
