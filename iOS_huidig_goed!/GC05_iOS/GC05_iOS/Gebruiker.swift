import Foundation

class Gebruiker
{
    var id: String?
    var rijksregisterNr: String?
    var email: String?
    var voornaam: String?
    var naam: String?
    var straat: String?
    var nummer: Int?
    var bus: String?
    var gemeente: String?
    var postcode: Int?
    var telefoon: String?
    var gsm: String?
    var aansluitingsNr: Int?
    var codeGerechtigde: Int?
    
    init(id: String) {
        self.id = id
    }
    
    /*init(gebruiker: PFObject) {
        self.id = gebruiker.objectId
        self.rijksregisterNr = gebruiker["rijksregisterNr"] as? String
        self.email = gebruiker["email"] as? String
        self.wachtwoord = gebruiker["wachtwoord"] as? String
        self.voornaam = gebruiker["voornaam"] as? String
        self.naam = gebruiker["naam"] as? String
        self.straat = gebruiker["straat"] as? String
        self.nummer = gebruiker["nummer"] as? Int
        self.bus = gebruiker["bus"] as? String
        self.gemeente = gebruiker["gemeente"] as? String
        self.postcode = gebruiker["postcode"] as? Int
        self.telefoon = gebruiker["telefoon"] as? String
        self.gsm = gebruiker["gsm"] as? String
        self.aansluitingsNr = gebruiker["aansluitingsNr"] as? Int
        self.codeGerechtigde = gebruiker["codeGerechtigde"] as? Int
    }*/
    
    init(rijksregisterNr: String, email: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int) {
        self.rijksregisterNr = rijksregisterNr
        self.email = email
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.telefoon = telefoon
        self.gsm = gsm
        self.aansluitingsNr = aansluitingsNr
        self.codeGerechtigde = codeGerechtigde
    }
    
    init(id: String, rijksregisterNr: String, email: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int) {
        self.id = id
        self.rijksregisterNr = rijksregisterNr
        self.email = email
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.telefoon = telefoon
        self.gsm = gsm
        self.aansluitingsNr = aansluitingsNr
        self.codeGerechtigde = codeGerechtigde
    }
    
    func initializeVariables(rijksregisterNr: String, email: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int)
    {
        self.rijksregisterNr = rijksregisterNr
        self.email = email
        self.voornaam = voornaam
        self.naam = naam
        self.straat = straat
        self.nummer = nummer
        self.bus = bus
        self.gemeente = gemeente
        self.postcode = postcode
        self.telefoon = telefoon
        self.gsm = gsm
        self.aansluitingsNr = aansluitingsNr
        self.codeGerechtigde = codeGerechtigde
    }
    
    func checkPatternEmail(email: String) -> Bool {
        if countElements(email) == 0 {
            return false
        } else if Regex(p: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email) {
            return true
        }
        return false
    }
    
    private func checkValidNummer(nr: Int) -> Bool {
        if nr <= 0 {
            return false
        }
        return true
    }
    
    private func checkValidPostcode(pc: Int) -> Bool {
        if pc < 1000 || pc > 9992 {
            return false
        }
        return true
    }
    
    private func checkValidTelefoon(tel: String) -> Bool {
        if countElements(tel) == 9 {
            return true
        }
        return false
    }
    
    private func checkValidGsm(gsm: String) -> Bool {
        if countElements(gsm) == 10 {
            return true
        }
        return false
    }
}