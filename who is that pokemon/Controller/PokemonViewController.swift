import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
        
    @IBOutlet var answerButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButtons()
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
    }
    
    func createButtons() {
        
    }
}
