//
//  AnalyticsViewController.swift
//  IndusTrees
//
//  Created by Andrea Vultaggio on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit
import SwiftCharts

class AnalyticsViewController: UIViewController {
    
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var fifth: UILabel!
    @IBOutlet weak var sixth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        first.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 3))
        second.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 3))
        third.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 3))
        fourth.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 3))
        fifth.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 3))
        sixth.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 3))
        
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        let chart = BarsChart(
            frame: CGRect(x: 0, y: 0, width: 300, height: 380) ,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("Vultaggio", 2),
                ("Salvato", 4.5),
                ("Antonino", 3),
                ("D'Alena", 5.4),
                ("Saltarelli", 6.8),
                ("Rossi", 0.5)
            ],
            color: .white,
            barWidth: 20
        )
        
        chart.view.center = CGPoint(x: CGFloat(self.view.center.x - 30), y: CGFloat(self.view.center.y - 20))
        
        backView.addSubview(chart.view)
       
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
