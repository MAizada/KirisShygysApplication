//
//  TransactionsChartsView.swift
//  kirisShygysApp
//
//  Created by Aizada on 06.12.2023.
//

import UIKit

class TransactionsChartView: UIView {
    private var incomeTransactions: [Transaction] = []
    private var expenseTransactions: [Transaction] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawChart()
    }
    
    var transactions = [Transactions]()
    
    //убоать отсюда
    func updateTransactions() {
        FirebaseManager.shared.loadTransactions { [weak self] transactions in
            self?.incomeTransactions = transactions.filter { $0.type == .income }
            self?.expenseTransactions = transactions.filter { $0.type == .expense }

            // Trigger a redraw of the chart view
            self?.setNeedsDisplay()
            print("Transactions updated from Firebase")
        }
    }
    
    private func drawIncomePath(_ incomePoints: [CGPoint]) {
        let incomePath = UIBezierPath()
        incomePath.lineWidth = 5.0
        
        if let greenColor = UIColor(named: "green") {
            greenColor.setStroke()
        } else {
            UIColor.green.setStroke()
        }
        
        incomePath.move(to: incomePoints.first ?? .zero)
        
        for i in 0 ..< incomePoints.count {
            if i + 1 < incomePoints.count {
                let startPoint = incomePoints[i]
                let endPoint = incomePoints[i + 1]
                
                let controlPoint1 = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.7, y: startPoint.y)
                let controlPoint2 = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.7, y: endPoint.y)
                
                incomePath.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            }
        }
        
        incomePath.lineCapStyle = .round
        incomePath.stroke()
    }

    private func drawExpensePath(_ expensePoints: [CGPoint]) {
        let expensePath = UIBezierPath()
        expensePath.lineWidth = 5.0
        
        if let redColor = UIColor(named: "red") {
            redColor.setStroke()
        } else {
            UIColor.red.setStroke()
        }
        
        expensePath.move(to: expensePoints.first ?? .zero)
        
        for (index, point) in expensePoints.enumerated() {
            guard index + 1 < expensePoints.count else {
                break
            }
            
            let startPoint = point
            let endPoint = expensePoints[index + 1]
            
            let controlPoint1 = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.7, y: startPoint.y)
            let controlPoint2 = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.7, y: endPoint.y)
            
            expensePath.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
        
        expensePath.lineCapStyle = .round
        expensePath.stroke()
    }

    private func drawChart() {
        let incomePoints = calculatePointsForTransactions(incomeTransactions)
        let expensePoints = calculatePointsForTransactions(expenseTransactions)

        drawIncomePath(incomePoints)
        drawExpensePath(expensePoints)
    }

    
    private func calculatePointsForTransactions(_ transactions: [Transaction]) -> [CGPoint] {
        let spacing = bounds.width / CGFloat(transactions.count - 1)
        var points: [CGPoint] = []
        for (index, transaction) in transactions.enumerated() {
            let x = spacing * CGFloat(index)
            let y = mapValueToYCoordinate(value: Double(transaction.amount) ?? 0)
            points.append(CGPoint(x: x, y: y))
        }
        return points
    }
    
    private func mapValueToYCoordinate(value: Double) -> CGFloat {
        let maxValue: Double = 1000.0
        let normalizedValue = min(max(value, 0), maxValue)
        let y = bounds.height - (bounds.height * CGFloat(normalizedValue) / CGFloat(maxValue))
        return y
    }
}
