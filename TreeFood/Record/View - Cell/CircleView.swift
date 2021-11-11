//
//  CircleView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/11.
//

import UIKit

let endPointMargin: CGFloat = 3.fit

let PI: CGFloat = 3.14159265358979323846264338327950288
let PI_2: CGFloat = 1.57079632679489661923132169163975144

class CircleView: UIView {
    public var progress: CGFloat = 0.0
    public var lineWidth: CGFloat = 10.fit

    private var trackLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var endPoint = UIView()
    let backLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    func configUI() {
        let centerX = bounds.size.width / 2.0
        let centerY = bounds.size.height / 2.0
        // 半径
        let radius = (bounds.size.width - lineWidth) / 2.0
        // 创建贝塞尔路径

        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -0.5 * PI, endAngle: 1.5 * PI, clockwise: true)
        backLayer.frame = bounds
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = UIColor(r: 50, g: 50, b: 50, alpha: 0.2).cgColor
        backLayer.lineWidth = lineWidth
        backLayer.path = path.cgPath
        backLayer.strokeEnd = 1
        layer.addSublayer(backLayer)

        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        // 指定path的渲染颜色
        progressLayer.strokeColor = UIColor(r: 255, g: 255, b: 255, alpha: 1).cgColor // UIColor.black.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(red: 0.99, green: 0.45, blue: 0.38, alpha: 1).cgColor, UIColor(red: 0.99, green: 0.45, blue: 0.38, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = progressLayer // 用progressLayer来截取渐变层
        layer.addSublayer(gradientLayer)
    }

    func updateUI(value: CGFloat) {
        let rangeValue = abs(value)
        progressLayer.strokeEnd = rangeValue / 100.0
        progress = rangeValue / 100.0
        progressLayer.removeAllAnimations()
        backLayer.strokeColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
        progressLayer.strokeColor = UIColor(r: 255, g: 255, b: 255, alpha: 1).cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleProgressView: UIView {
    lazy var circle: CircleView = {
        let circle = CircleView(frame: CGRect(x: 0, y: 0, width: 140.fit, height: 140.fit))
        let lineWidth: Float = Float(0.1 * bounds.size.width)
        circle.lineWidth = CGFloat(lineWidth)
        return circle
    }()

    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {
        addSubview(circle)
        addSubview(percentLabel)

        circle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        percentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateUI(with value: Int) {
        circle.progress = CGFloat(value)
        let str = String(value)
        let strlen = str.count
        let attr1: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 13)!, .foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1)]
        let attr2: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Light", size: 25)!, .foregroundColor: UIColor(red: 0.96, green: 0.46, blue: 0.33, alpha: 1)]
        let attrString = NSMutableAttributedString(string: "剩余\n" + str + "\n千卡")
        attrString.addAttributes(attr1, range: NSRange(location: 0, length: 3))
        attrString.addAttributes(attr2, range: NSRange(location: 3, length: strlen))
        attrString.addAttributes(attr1, range: NSRange(location: strlen + 3, length: attrString.length - strlen - 3))
        percentLabel.attributedText = attrString
        percentLabel.numberOfLines = 0
        circle.updateUI(value: CGFloat(value))
    }
}
