//
//  ViewController.swift
//  TestAR
//
//  Created by Sơn Nguyễn on 2/1/20.
//  Copyright © 2020 Sơn Nguyễn. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBox()
        addTapGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addBox() {
        let scene = SCNScene()
        let fishScene = SCNScene(named: "fishModel.dae")
        guard let fishNode = fishScene?.rootNode.childNode(withName: "fishModel", recursively: true) else {
            fatalError("fishModel is not found")
        }
        fishNode.position = SCNVector3(0, 0, -1.0)
        scene.rootNode.addChildNode(fishNode)
        sceneView.scene = scene
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
    }
}
