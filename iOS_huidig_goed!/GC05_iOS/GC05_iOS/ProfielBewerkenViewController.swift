import UIKit

class ProfielBewerkenViewController: ResponsiveTextFieldViewController {
    
    @IBOutlet weak var voornaamTxt: UITextField!
    @IBOutlet weak var naamTxt: UITextField!
    @IBOutlet weak var telefoonTxt: UITextField!
    @IBOutlet weak var gsmTxt: UITextField!
    
    var monitor: Monitor?
    var statusTextFields: [String: String] = [:]
    var redColor: UIColor = UIColor.redColor()
    
    @IBAction func opslaan(sender: AnyObject) {
        ParseData.deleteMonitorTable()
        ParseData.vulMonitorTableOp()
        
        monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        setStatusTextFields()
        pasLayoutVeldenAan()
        
        if controleerRodeBordersAanwezig() == true {
            foutBoxOproepen("Fout", "Gelieve de velden correct in te vullen!", self)
        } else {
            vulGegevensIn()
            ParseData.updateMonitor(self.monitor!)
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Profiel") as UIViewController
            sideMenuController()?.setContentViewController(destViewController)
            hideSideMenuView()
        }
    }
    
    func setStatusTextFields() {
        if voornaamTxt.text.isEmpty {
            statusTextFields["voornaam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["voornaam"] = "ingevuld"
        }
        
        if naamTxt.text.isEmpty {
            statusTextFields["naam"] = "leeg"
        } else {
            //TO DO: checken op pattern?
            statusTextFields["naam"] = "ingevuld"
        }
        if telefoonTxt.text.isEmpty {
            statusTextFields["telefoon"] = "leeg"
        } else {
            if !checkPatternTelefoon(telefoonTxt.text) {
                statusTextFields["telefoon"] = "ongeldig"
            } else {
                statusTextFields["telefoon"] = "geldig"
            }
        }
        
        if gsmTxt.text.isEmpty {
            statusTextFields["gsm"] = "leeg"
        } else {
            if !checkPatternGsm(gsmTxt.text) {
                statusTextFields["gsm"] = "ongeldig"
            } else {
                statusTextFields["gsm"] = "geldig"
            }
        }
    }
    
    func pasLayoutVeldenAan() {
        if statusTextFields["voornaam"] == "leeg" {
            giveUITextFieldRedBorder(voornaamTxt)
        } else {
            giveUITextFieldDefaultBorder(voornaamTxt)
        }
        
        if statusTextFields["naam"] == "leeg" {
            giveUITextFieldRedBorder(naamTxt)
        } else {
            giveUITextFieldDefaultBorder(naamTxt)
        }
        if statusTextFields["telefoon"] == "ongeldig"{
            giveUITextFieldRedBorder(telefoonTxt)
        } else {
            giveUITextFieldDefaultBorder(telefoonTxt)
        }
        
        if statusTextFields["gsm"] == "leeg" || statusTextFields["gsm"] == "ongeldig"{
            giveUITextFieldRedBorder(gsmTxt)
        } else {
            giveUITextFieldDefaultBorder(gsmTxt)
        }
    }
    
    func controleerRodeBordersAanwezig() -> Bool {
        if CGColorEqualToColor(voornaamTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(naamTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(telefoonTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else if CGColorEqualToColor(gsmTxt.layer.borderColor, redColor.CGColor) {
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
    
        self.monitor = ParseData.getMonitorWithEmail(PFUser.currentUser().email)
        
        voornaamTxt.text = monitor!.voornaam
        naamTxt.text = monitor!.naam
        gsmTxt.text = monitor!.gsm
        
        if monitor!.telefoon == "" {
            telefoonTxt.text = ""
        } else {
            telefoonTxt.text = monitor!.telefoon
        }
    }
    
    func vulGegevensIn() {
        monitor?.voornaam = voornaamTxt.text
        monitor?.naam = naamTxt.text
        monitor?.telefoon = telefoonTxt.text
        monitor?.gsm = gsmTxt.text
    }
}