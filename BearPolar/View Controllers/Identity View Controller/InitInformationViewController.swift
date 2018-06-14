//
//  IdentityStageViewController.swift
//  BearPolar
//
//  Created by Vincent Coetzee on 2018/06/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class InitInformationViewController: UIViewController,UIAdaptivePresentationControllerDelegate,UIPopoverPresentationControllerDelegate
    {

    override func viewDidLoad() 
        {
        super.viewDidLoad()
        self.navigationItem.title = "Information"
        let controller = InformationViewController()
        let contentView = controller.view!
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.addSubview(controller.view)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        let containerView = self.view!
        scrollView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: contentView.bounds.size.height).isActive = true
        }
        
    override func didReceiveMemoryWarning() 
        {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    }
