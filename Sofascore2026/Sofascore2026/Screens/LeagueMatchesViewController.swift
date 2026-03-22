import UIKit
import SnapKit

final class LeagueMatchesViewController: UIViewController {
    
    private let dataLoader = LeagueMatchesDataLoader()
    
    private let sportSelectorView = SportSelectorView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var selectedSport: SportType = .football
    private var sections: [LeagueSectionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        setupView()
        setupLayout()
        setupActions()
        loadData()
    }
    
    private func setupView() {
        view.addSubview(sportSelectorView)
        view.addSubview(tableView)
        
        sportSelectorView.setSelectedSport(.football)
        
        tableView.register(
            MatchRowTableViewCell.self,
            forCellReuseIdentifier: MatchRowTableViewCell.reuseIdentifier
        )
        
        tableView.register(
            LeagueHeaderTableViewHeaderFooterView.self,
            forHeaderFooterViewReuseIdentifier: LeagueHeaderTableViewHeaderFooterView.reuseIdentifier
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.sectionHeaderTopPadding = 0
        tableView.alwaysBounceVertical = true
    }
    
    private func setupLayout() {
        sportSelectorView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupActions() {
        sportSelectorView.onSportSelected = { [weak self] sport in
            self?.selectedSport = sport
            self?.loadData()
        }
    }
    
    private func loadData() {
        sections = dataLoader.makeSections(for: selectedSport)
        tableView.reloadData()
    }
}

extension LeagueMatchesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].matchRowViewModels.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchRowTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MatchRowTableViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = sections[indexPath.section].matchRowViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
}

extension LeagueMatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueHeaderTableViewHeaderFooterView.reuseIdentifier
        ) as? LeagueHeaderTableViewHeaderFooterView else {
            return nil
        }
        
        let viewModel = sections[section].headerViewModel
        header.configure(with: viewModel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}
