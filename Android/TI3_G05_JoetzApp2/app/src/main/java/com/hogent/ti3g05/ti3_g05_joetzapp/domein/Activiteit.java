package com.hogent.ti3g05.ti3_g05_joetzapp.domein;


public class Activiteit {

    private String activiteitID;
    private String titel, locatie, korteBeschrijving, GegevensContactPersoon;

    public Activiteit(){

    }

    public String getGegevensContactPersoon() {
        return GegevensContactPersoon;
    }

    public void setGegevensContactPersoon(String gegevensContactPersoon) {
        GegevensContactPersoon = gegevensContactPersoon;
    }

    public String getActiviteitID() {
        return activiteitID;
    }

    public void setActiviteitID(String activiteitID) {
        this.activiteitID = activiteitID;
    }

    public String getTitel() {
        return titel;
    }

    public void setTitel(String titel) {
        this.titel = titel;
    }

    public String getLocatie() {
        return locatie;
    }

    public void setLocatie(String locatie) {
        this.locatie = locatie;
    }

    public String getKorteBeschrijving() {
        return korteBeschrijving;
    }

    public void setKorteBeschrijving(String korteBeschrijving) {
        this.korteBeschrijving = korteBeschrijving;
    }
}
