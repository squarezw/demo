import UIKit
import PlaygroundSupport

final class BlockCell: UIView {
    
    // Lazy variables for the various elements required to make up our view heirarchy.
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        // Add our components to the view heirarchy.
        addComponents()
        
        // Define our autolayout constraints.
        layoutComponents()
        
        // Apply some sample values
        nameLabel.text = "Username"
        moreButton.setTitle("...", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addComponents() {
        
        userInfoStackView.addArrangedSubview(avatarImageView)
        userInfoStackView.addArrangedSubview(nameLabel)
        userInfoStackView.addArrangedSubview(moreButton)
        
        
        rootStackView.addArrangedSubview(userInfoStackView)
        rootStackView.addArrangedSubview(imageView)
        
        addSubview(rootStackView)
    }
    
    private func layoutComponents() {
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            moreButton.widthAnchor.constraint(equalToConstant: 45),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 3),
            userInfoStackView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
}

let userCell = BlockCell(frame: CGRect(x: 0, y: 0, width: 450, height: 160))
PlaygroundPage.current.liveView = userCell


// Desgin Route...

@dynamicMemberLookup
public protocol RouterProtocol {
    // In general set up as a root view controller
    var entryPage: UINavigationController { get }
    
    // refresh entire router tree once the key path is changed.
    func refresh()
    
    var routeTree: [String: UIViewController] {get}
}

public extension RouterProtocol {
    subscript(dynamicMember member: String) -> UIViewController? {
        return routeTree[member]
    }
}

public protocol RouteCompatible {
    associatedtype CompatableType
    var route: CompatableType { get }
}

public extension RouteCompatible {
    public var route: Auto<Self> {
        get { return Auto(self) }
        set { }
    }
}

public struct Auto<Base>: RouterProtocol {
    public var entryPage: UINavigationController
    
    public func refresh() {
        
    }
    
    public var routeTree: [String : UIViewController] = [:]
    
    public let base: Base
    public init(_ base: Base) {
        self.base = base
        self.entryPage = UINavigationController()
    }
    
    func goto(_ destination: String) {
        
    }
}

extension Auto where Base:UIViewController {
    func goback() {
        self.entryPage.popViewController(animated: true)
    }
}

extension UIViewController: RouteCompatible{
    
}


let vc = UIViewController()
vc.route.goback()









