﻿using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web;
using System.IO;
using Joetz.Models.DAL;
using Joetz.Models.Domain;
//using Excel;

namespace Joetz.Controllers
{
    public class MonitorController : Controller
    {
        private IMonitorRepository monitorRepository;

        public MonitorController()
        {
            this.monitorRepository = new MonitorRepository();
        }

        public MonitorController(IMonitorRepository monitorRepository)
        {
            this.monitorRepository = monitorRepository;
        }

        /*public async Task<ActionResult> Index()
        {
            var monitorenTask = monitorRepository.FindAll();
            IEnumerable<Monitor> monitoren = await monitorenTask;
            return View(monitoren);
        }*/

        public ActionResult Index()
        {
            return View();
        }

        //onderstaande methode dient voor de fileupload
        [HttpPost]
        public async Task<ActionResult> Index(HttpPostedFileBase file)
        {
            // Zeker zijn dat gebruiker bestand heeft geselecteerd
            /*if (file != null && file.ContentLength > 0)
            {
                //file name ophalen
                string fileName = Path.GetFileName(file.FileName);
                if (fileName.EndsWith(".xlsx") || (fileName.EndsWith(".xls"))) //enkel gewoon Excel bestand wordt aanvaard.
                {
                    // store the file inside ~/App_Data/uploads folder
                    var path = Path.Combine(Server.MapPath("~/App_Data/uploads/"), fileName);
                    file.SaveAs(path);
                    Monitor m = new Monitor();
                    IList<Monitor> monitorern = new List<Monitor>();

                    IExcelDataReader reader = ExcelReaderFactory.CreateOpenXmlReader(file.InputStream);
                    
                        while(reader.Read()) //14 kolommen +-
                        {
                            m.Aansluitingsnummer = reader.GetInt32(0);
                            m.Bus = reader.GetString(1);
                            m.CodeGerechtigde = reader.GetInt32(2);
                            m.Email = reader.GetString(3);
                            m.Gemeente = reader.GetString(4);
                            m.Gsm = reader.GetString(5);
                            m.Lidnummer = reader.GetString(6);
                                m.Naam = reader.GetString(7);
                            m.Nummer = reader.GetInt32(8);
                            m.Postcode =reader.GetInt32(9);
                            m.Rijksregisternummer = reader.GetString(10);
                            m.Straat = reader.GetString(11);
                            m.Telefoon = reader.GetString(12);
                            m.Voornaam = reader.GetString(13);

                            
                            await monitorRepository.Add(m);
                        }
                    } // the using */
/*
                    using (var package = new ExcelPackage(fileBase.InputStream))
                    {
                        // get the first worksheet in the workbook
                        ExcelWorksheet worksheet = package.Workbook.Worksheets[1];
                        int col = 1;
                        for (int row = 1; worksheet.Cells[row, col].Value != null; row++)
                        {
                            // do something with worksheet.Cells[row, col].Value                    
                        }
                    } // the using */
                    // redirect back to the index action to show the form once again
                /*return RedirectToAction("Index");
                }*/
            return View();
        }

        //public ActionResult Create()
        //{
        //    return View(new Monitor());
        //}

        //[HttpPost]
        //public ActionResult Create(Monitor monitor)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        monitorRepository.Add(monitor);
        //        TempData["Info"] = "Monitor " + monitor.Voornaam + " " + monitor.Naam + " is toegevoegd";
        //        return RedirectToAction("Index");    
        //    }
        //    return View(monitor);
        //}

        public async Task<ActionResult> Edit(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            return View(monitor);
        }

        [HttpPost]
        public async Task<ActionResult> Edit(string id, FormCollection formValues)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            UpdateModel(monitor, formValues.ToValueProvider());
            monitorRepository.Update(monitor);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Delete(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            return View(monitor);
        }

        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            monitorRepository.Delete(monitor);
            return RedirectToAction("Index");
        }

    }
}
