import UIKit

class IndienenVoorkeurViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    //@IBOutlet weak var txtViewPeriodes: UITextView!
    @IBOutlet weak var periodeLabel: UILabel!
    
    var vakanties: [Vakantie] = []
    var pickerData: [String] = []
    var voorkeur: Voorkeur = Voorkeur(id: "test")
    //var vorming: Vorming!
    //var inschrijvingVorming: InschrijvingVorming = InschrijvingVorming(id: "test")
    
    @IBAction func gaTerugNaarOverzicht(sender: AnyObject) {
        annuleerControllerVoorkeur(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSideMenuView()
        periodeLabel.hidden = true
        
        vakanties = ParseData.getAlleVakanties()
        
        for vakantie in vakanties {
            pickerData.append(vakantie.titel!)
        }
        
        //giveUITextViewDefaultBorder(txtViewPeriodes)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        periodeLabel.hidden = true
        /*var vertrekdatumStr = self.voorkeur.vakantie?.vertrekdatum.toS("dd/MM/yyyy")
        var terugkeerdatumStr = self.voorkeur.vakantie?.terugkeerdatum.toS("dd/MM/yyyy")
        periodeLabel.text = ("\(vertrekdatumStr) \(terugkeerdatumStr)")*/
        return pickerData[row]
    }
    @IBAction func toonPeriode(sender: AnyObject) {
        var vertrekdatumStr = self.voorkeur.vakantie?.vertrekdatum.toS("dd/MM/yyyy")
        var terugkeerdatumStr = self.voorkeur.vakantie?.terugkeerdatum.toS("dd/MM/yyyy")
        
        if self.voorkeur.vakantie == nil {
            var vakantie = vakanties[0]
            vertrekdatumStr = vakantie.vertrekdatum.toS("dd/MM/yyyy")
            terugkeerdatumStr = vakantie.terugkeerdatum.toS("dd/MM/yyyy")
        }
        
        periodeLabel.text = ("\(vertrekdatumStr!) - \(terugkeerdatumStr!)")
        periodeLabel.hidden = false
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var vakantieNaam = pickerData[row]
        
        var vakantie: Vakantie = Vakantie(id: "test")
        
        for v in vakanties {
            if v.titel == vakantieNaam {
                vakantie = v
            }
        }
        
        voorkeur.vakantie = vakantie
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indienenVoorkeurSuccesvolViewController = segue.destinationViewController as IndienenVoorkeurSuccesvolViewController
            
        /*if txtViewPeriodes.text.isEmpty {
            giveUITextViewRedBorder(txtViewPeriodes)
            foutBoxOproepen("Fout", "Gelieve het veld in te vullen!", self)
            
        } else {*/
            
            var query = PFQuery(className: "Monitor")
            query.whereKey("email", containsString: PFUser.currentUser().email)
            var monitorPF = query.getFirstObject()
            var monitor = Monitor(monitor: monitorPF)
            
            self.voorkeur.monitor = monitor
            //self.voorkeur.data = txtViewPeriodes.text
            
            if self.voorkeur.vakantie == nil {
                self.voorkeur.vakantie = vakanties[0]
            }
            
            indienenVoorkeurSuccesvolViewController.voorkeur = self.voorkeur
        //}

    }
    
    

    
    @IBAction func toggle(sender: AnyObject) {
        toggleSideMenuView()
    }
}