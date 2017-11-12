//
//  WatchContainerViewController.swift
//  Demo App
//
//  Created by Cal Stephens on 11/11/17.
//  Copyright © 2017 Cal Stephens. All rights reserved.
//

import UIKit

public class WatchContainerViewController: UIViewController {
    
    var interfaceFileName: String!
    var applicationNamespace: String!
    
    // MARK: Presentation
    
    public static func create(
        withInterfaceFileNamed interfaceFileName: String,
        inNamespace applicationNamespace: String) -> WatchContainerViewController
    {
        let storyboard = UIStoryboard(name: "WatchContainer", bundle: Bundle(for: WatchContainerViewController.self))
        let containerViewController = storyboard.instantiateInitialViewController() as! WatchContainerViewController
        containerViewController.interfaceFileName = interfaceFileName
        containerViewController.applicationNamespace = applicationNamespace.replacingOccurrences(of: " ", with: "_")
        return containerViewController
    }
    
    // MARK: Setup
    
    var watchStoryboard: WatchStoryboard!
    @IBOutlet weak var watchContainer: UIView!
    @IBOutlet weak var menuItemStackView: UIStackView!
    @IBOutlet weak var stackViewContainer: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        watchStoryboard = WatchStoryboard(fileName: interfaceFileName, applicationNamespace: applicationNamespace)
        watchStoryboard.delegate = self
        updateStackView(with: watchStoryboard.currentController?.menuItems ?? [])
        
        guard let watchView = watchStoryboard?.watchView else { return }
        watchContainer.addSubview(watchView)
    }
    
    // MARK: User Interaction
    
    private func updateStackView(with menuItems: [WatchStoryboardMenuItem]) {
        menuItemStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, menuItem) in menuItems.enumerated() {
            let button = UIButton(type: .system)
            
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05570419521)
            button.setTitle((menuItem.title ?? "Menu Item"), for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.3614874276, green: 0.6923985945, blue: 0, alpha: 1), for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
            button.setContentCompressionResistancePriority(.required, for: .horizontal)
            button.tag = index
            button.addTarget(self, action: #selector(forceTouchButtonPressed(_:)), for: .touchUpInside)
            
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            
            menuItemStackView.addArrangedSubview(button)
        }
        
        menuItemStackView.layoutIfNeeded()
        stackViewContainer.layoutIfNeeded()
        self.stackViewContainer.playTransition(duration: 0.15, transition: kCATransitionFade)
    }
    
    @objc func forceTouchButtonPressed(_ button: UIButton) {
        if let menuItem = watchStoryboard.currentController?.menuItems[button.tag] {
            watchStoryboard.performForceTouchAction(menuItem)
        }
    }
    
}

// MARK: WatchStoryboardDelegate

extension WatchContainerViewController: WatchStoryboardDelegate {
    
    public func storyboard(
        _ storyboard: WatchStoryboard,
        didUpdateForceTouchOptionsTo forceTouchOptions: [WatchStoryboardMenuItem])
    {
        updateStackView(with: forceTouchOptions)
    }
    
}

// MARK: Helpers

extension UIView {
    
    func playTransition(
        duration: Double,
        transition transitionName: String,
        subtype: String? = nil,
        timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
    {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.type = transitionName
        
        transition.subtype = subtype
        transition.timingFunction = timingFunction
        layer.add(transition, forKey: nil)
    }
}

