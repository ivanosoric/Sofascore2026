import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    private let contentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.headerBackground
        
        setupView()
        setupLayout()
        
        title = "Settings"
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
    }
    
    private func setupView() {
        view.addSubview(contentView)
        contentView.backgroundColor = AppColors.background
    }

    private func setupLayout() {
        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
}
