﻿using System;
using System.Collections.Generic;
using Joetz.Models.Domain;
using Parse;

namespace Joetz.Models.DAL
{
    public class VakantieRepository: IVakantieRepository
    {
        public Vakantie GetVakantie(ParseObject vakantieObject)
        {
            Vakantie vakantie = new Vakantie("test");

            vakantie.Id = vakantieObject.ObjectId;
            vakantie.Titel = vakantieObject.Get<string>("titel");
            vakantie.Locatie = vakantieObject.Get<string>("locatie");
            vakantie.KorteBeschrijving = vakantieObject.Get<string>("korteBeschrijving");
            vakantie.AantalDagenNachten = vakantieObject.Get<string>("aantalDagenNachten");
            vakantie.BasisPrijs = vakantieObject.Get<Double>("basisPrijs");
            vakantie.BondMoysonLedenPrijs = vakantieObject.Get<Double>("bondMoysonLedenPrijs");
            vakantie.Formule = vakantieObject.Get<string>("formule");
            vakantie.InbegrepenPrijs = vakantieObject.Get<string>("inbegrepenPrijs");
            vakantie.Link = vakantieObject.Get<string>("link");
            vakantie.MaxAantalDeelnemers = vakantieObject.Get<int>("maxAantalDeelnemers");
            vakantie.MinLeeftijd = vakantieObject.Get<int>("minLeeftijd");
            vakantie.MaxLeeftijd = vakantieObject.Get<int>("maxLeeftijd");
            vakantie.SterPrijs1Ouder = vakantieObject.Get<Double>("sterPrijs1ouder");
            vakantie.SterPrijs2Ouders = vakantieObject.Get<Double>("sterPrijs2ouders");
            vakantie.TerugkeerDatum = vakantieObject.Get<DateTime>("terugkeerdatum");
            vakantie.VertrekDatum = vakantieObject.Get<DateTime>("vertrekdatum");
            vakantie.Vervoerwijze = vakantieObject.Get<string>("vervoerwijze");

            return vakantie;

        }

        public Vakantie FindBy(string vakantieId)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantieId);
            ParseObject vakantieObject = query.FirstAsync().Result;

            var vakantie = GetVakantie(vakantieObject);
            return vakantie;
        }

        public IList<Vakantie> FindAll()
        {
            var query = ParseObject.GetQuery("Vakantie");
            IEnumerable<ParseObject> vakantieObjects = query.FindAsync().Result;

            IList<Vakantie> vakanties = new Vakantie[]{};
            Vakantie vakantie;

            foreach (ParseObject vakantieObject in vakantieObjects)
            {
                vakantie = GetVakantie(vakantieObject);
                vakanties.Add(vakantie);
            }

            return vakanties;
        }

        public void Add(Vakantie vakantie)
        {
            ParseObject vakantieObject = new ParseObject("Vakantie");

            vakantieObject["titel"] = vakantie.Titel;
            vakantieObject["locatie"] = vakantie.Locatie;
            vakantieObject["korteBeschrijving"] = vakantie.KorteBeschrijving;
            vakantieObject["aantalDagenNachten"] = vakantie.AantalDagenNachten;
            vakantieObject["basisPrijs"] = vakantie.BasisPrijs;
            vakantieObject["bondMoysonLedenPrijs"] = vakantie.BondMoysonLedenPrijs;
            vakantieObject["formule"] = vakantie.Formule;
            vakantieObject["inbegrepenPrijs"] = vakantie.InbegrepenPrijs;
            vakantieObject["link"] = vakantie.Link;
            vakantieObject["maxAantalDeelnemers"] = vakantie.MaxAantalDeelnemers;
            vakantieObject["minLeeftijd"] = vakantie.MinLeeftijd;
            vakantieObject["maxLeeftijd"] = vakantie.MaxLeeftijd;
            vakantieObject["sterPrijs1ouder"] = vakantie.SterPrijs1Ouder;
            vakantieObject["sterPrijs2ouders"] = vakantie.SterPrijs2Ouders;
            vakantieObject["terugkeerdatum"] = vakantie.TerugkeerDatum;
            vakantieObject["vertrekdatum"] = vakantie.VertrekDatum;
            vakantieObject["vervoerwijze"] = vakantie.Vervoerwijze;

            vakantieObject.SaveAsync();
        }

        public void Delete(Vakantie vakantie)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantie.Id);
            ParseObject vakantieObject = query.FirstAsync().Result;

            vakantieObject.DeleteAsync();
        }
    }
}