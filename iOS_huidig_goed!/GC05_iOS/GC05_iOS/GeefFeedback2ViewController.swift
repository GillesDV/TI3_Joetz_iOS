import UIKit

class GeefFeedback2ViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var scorePickerView: UIPickerView!
    @IBOutlet var txtFeedback: UITextView!
    
    var scores: [Int] = [1, 2, 3, 4, 5]
    var score: Int?
    var feedback: Feedback!
    var vakantie: Vakantie!
    var titel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        
        self.navigationItem.title = self.titel
        
        var grayColor: UIColor = UIColor.grayColor()
        txtFeedback.layer.borderColor = grayColor.CGColor
        txtFeedback.layer.borderWidth = 1.0
        txtFeedback.layer.cornerRadius = 5.0
        
        scorePickerView.delegate = self
        scorePickerView.dataSource = self
        scorePickerView.reloadAllComponents()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scores.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(scores[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.score = scores[row]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let geefFeedbackSuccesvolViewController = segue.destinationViewController as GeefFeedbackSuccesvolViewController
        var gebruiker = getGebruiker(PFUser.currentUser().email)
        feedback = Feedback(id: "test")
        
        feedback.datum = NSDate()
        feedback.gebruiker = gebruiker
        feedback.vakantie = self.vakantie
        if self.score == nil {
            self.score = scores[0]
        }
        feedback.score = self.score
        feedback.waardering = self.txtFeedback.text
        feedback.goedgekeurd = false
        geefFeedbackSuccesvolViewController.feedback = self.feedback
    }
    
    func getGebruiker(email: String) -> Gebruiker {
        ParseData.deleteOuderTable()
        ParseData.vulOuderTableOp()
        var gebruiker: Gebruiker!
        
        var responseOuder = OuderSQL.getOuderWithEmail(email)
        
        if responseOuder.1 != nil {
            ParseData.deleteMonitorTable()
            ParseData.vulMonitorTableOp()
            var responseMonitor = MonitorSQL.getMonitorWithEmail(email)
            if responseMonitor.1 == nil {
                gebruiker = MonitorSQL.getGebruiker(responseMonitor.0)
            } else {
                println("ERROR: er is geen gebruiker met dit id teruggevonden in FeedbackSQL")
            }
        }
        else {
            gebruiker = OuderSQL.getGebruiker(responseOuder.0)
        }
        return gebruiker
    }
}