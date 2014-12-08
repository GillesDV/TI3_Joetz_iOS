import Foundation

class Monitor: Gebruiker {
    var lidNr: String?
    
    override init(id: String) {
        super.init(id: id)
    }
    
    override init(rijksregisterNr: String, email: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int) {
        super.init(rijksregisterNr: rijksregisterNr, email: email, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
    
    init(rijksregisterNr: String, email: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, lidNr: String) {
        self.lidNr = lidNr
        super.init(rijksregisterNr: rijksregisterNr, email: email, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
    
    init(id: String, rijksregisterNr: String, email: String, voornaam: String, naam: String, straat: String, nummer: Int, bus: String, gemeente: String, postcode: Int, telefoon: String, gsm: String, aansluitingsNr: Int, codeGerechtigde: Int, lidNr: String) {
        self.lidNr = lidNr
        super.init(id: id, rijksregisterNr: rijksregisterNr, email: email, voornaam: voornaam, naam: naam, straat: straat, nummer: nummer, bus: bus, gemeente: gemeente, postcode: postcode, telefoon: telefoon, gsm: gsm, aansluitingsNr: aansluitingsNr, codeGerechtigde: codeGerechtigde)
    }
}