import UIKit

extension UIImageView {
    
    func setImage(from url: URL?) {
        image = nil
        
        guard let url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard
                let self,
                let data,
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

