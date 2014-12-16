﻿using Joetz.Models.DAL;
using Joetz.Models.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Controllers
{
    public class FeedbackController : Controller
    {
        private IFeedbackRepository feedbackRepository;

        public FeedbackController()
        {
            this.feedbackRepository = new FeedbackRepository();
        }

        public FeedbackController(IFeedbackRepository feedbackRepository)
        {
            this.feedbackRepository = feedbackRepository;
        }

        public async Task<ActionResult> Index()
        {
            var feedbackTask = feedbackRepository.FindAll();
            IEnumerable<Feedback> feedback = await feedbackTask;
            return View(feedback);
        }

        public async Task<ActionResult> Edit(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            await feedbackRepository.Update(feedback);
            return RedirectToAction("Index");
        }
        
               
        public async Task<ActionResult> Delete(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            return View(feedback);
        }

        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            await feedbackRepository.Delete(feedback);
            return RedirectToAction("Index");
        }
                
        public async Task<ActionResult> Details(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            return View("Details", feedback);
        }
    }
}