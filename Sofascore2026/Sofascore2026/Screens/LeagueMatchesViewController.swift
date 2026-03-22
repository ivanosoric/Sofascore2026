import UIKit
import SnapKit

final class LeagueMatchesViewController: UIViewController {
    
    private let dataLoader = LeagueMatchesDataLoader()
    private let headerView = LeagueHeaderView()
    private let contentStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        setupView()
        setupLayout()
        loadData()
    }
    
    private func setupView() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 12
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        
        view.addSubview(headerView)
        view.addSubview(contentStackView)
    }
    
    private func setupLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func loadData() {
        let headerViewModel = dataLoader.makeLeagueHeaderViewModel()
        headerView.configure(with: headerViewModel)
        
        let rowViewModels = dataLoader.makeMatchRowViewModels()
        rowViewModels.forEach { viewModel in
            let rowView = MatchRowView()
            rowView.configure(with: viewModel)
            contentStackView.addArrangedSubview(rowView)
        }
    }
}
