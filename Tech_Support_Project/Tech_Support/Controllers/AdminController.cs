using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Models;
using TechSupport.DAL.Repositories;

namespace Tech_Support.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller
    {
        private readonly IUserRepository userRepo;
        private readonly ICompanyRepository companyRepo;
        private readonly IEmployerRepository employerRepo;
        private readonly IAnswerRepository answerRepo;
        private readonly IMapper mapper;

        public AdminController(IUserRepository _repo, IMapper _mapper, ICompanyRepository companyRepo, IEmployerRepository employerRepo, IAnswerRepository answerRepo)
        {
            userRepo = _repo;
            mapper = _mapper;
            this.companyRepo = companyRepo;
            this.employerRepo = employerRepo;
            this.answerRepo = answerRepo;

        }

        public IActionResult Index()
        {
            int countBlocked = userRepo.NumberOfBlockedAccounts();
            ViewBag.Blocked = countBlocked; 
            return View();
        }

        [HttpGet]
        public IActionResult BlockedAccounts()
        {
            var blockedAccounts = userRepo.GetBlockedAccounts();
            var model = mapper.Map<IEnumerable<BLUser>, IEnumerable<VMUser>>(blockedAccounts);
            return View(model);
        }

        [HttpPost]
        public IActionResult UnblockAccount(int id)
        {
            userRepo.Unblock(id);
            return RedirectToAction("BlockedAccounts","Admin");
        }

        [HttpGet]
        public IActionResult Users(int? page)
        {
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            var blUsers = userRepo.GetAll();

            int totalItems = blUsers.Count();
            int totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var paginatedData = blUsers.Skip((pageNumber - 1) * pageSize).Take(pageSize);

            var users = mapper.Map<IEnumerable<BLUser>, IEnumerable<VMUser>>(paginatedData);

            ViewData["pageNumber"] = pageNumber;
            ViewData["totalPages"] = totalPages;
            return View(users);
        }

        [HttpGet]
        public IActionResult CreateUser()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CreateUser(VMUser request)
        {
            request.Lozinka = CreateHash(request.Lozinka);

            var blUser = mapper.Map<BLUser>(request);
            userRepo.Add(blUser);
            
            return View();
        }

        [HttpGet]
        public IActionResult EditUser(int id)
        {
            var blUser = userRepo.GetById(id);
            var user = mapper.Map<VMUser>(blUser);
            return View(user);
        }

        [HttpPost]
        public IActionResult EditUser(int id, VMUser request)
        {
            try
            {
                var blUser = mapper.Map<BLUser>(request);

                userRepo.Update(id, blUser);
                return RedirectToAction("Users", "Admin");
            }
            catch (Exception ex)
            {
                return BadRequest("You can't change from moderator to user, or user is already employed");
                throw;
            }
        }

        [HttpGet]
        public IActionResult Companies()
        {
            var blCompanies = companyRepo.GetAll();
            var companies = mapper.Map<IEnumerable<BLCompany>, IEnumerable<VMCompany>>(blCompanies);
            return View(companies);
        }

        [HttpGet]
        public IActionResult CreateCompany()
        {
            var unempleyedUsers = userRepo.GetAll().Where(k=>k.Zaposlen == false && k.TipId == 1);

            var users = mapper.Map<IEnumerable<VMUser>>(unempleyedUsers);
            return View(users);
        }

        [HttpPost]
        public IActionResult CreateCompany(int id, VMCompany request)
        {
            var blCompany = mapper.Map<BLCompany>(request);
            blCompany.ModeratorId = id;
            companyRepo.Add(blCompany);
            return RedirectToAction("Companies","Admin");
        }

        [HttpGet]
        public IActionResult EditCompany(int id)
        {
            var blCompany = companyRepo.GetById(id);
            var vmCompnay = mapper.Map<VMCompany>(blCompany);

            var unempleyedUsers = userRepo.GetAll().Where(k => k.Zaposlen == false && k.TipId == 1);
            var moderators = mapper.Map<IEnumerable<VMUser>>(unempleyedUsers);

            ViewData["Moderatori"] = moderators;
            return View(vmCompnay);
        }

        [HttpPost]
        public IActionResult EditCompany(int id, VMCompany request)
        {
            var blCompany = mapper.Map<BLCompany>(request);
            companyRepo.Update(id, blCompany);
            return RedirectToAction("Companies", "Admin");
        }

        [HttpGet] 
        public IActionResult Requests()
        {
            var blRequests = companyRepo.Requests();
            var requests = mapper.Map<IEnumerable<BLCompany>, IEnumerable<VMCompany>>(blRequests);
            return View(requests);
        }

        [HttpPost]
        public IActionResult Requests(int id)
        {
            companyRepo.SendRequest(id, false);
            return RedirectToAction("Requests", "Admin");
        }

        [HttpGet]
        public IActionResult Statistics()
        {
            var vmRanked = mapper.Map<List<VMEmployerRanking>>(GetRankedEmployers());
            var vmCompany = mapper.Map<List<VMCompany>>(companyRepo.GetAll());

            ViewData["ranked"] = vmRanked;
            ViewData["companies"] = vmCompany;
            return View();
        }

        [HttpGet]
        public IActionResult Xml()
        {
            return View();
        }

        public IActionResult XmlDownload()
        {
            var vmData = mapper.Map<List<VMUser>>(userRepo.GetAll().ToList());

            XmlModel model = new XmlModel
            {
                Korisnici = vmData
            };

            using (MemoryStream memoryStream = new MemoryStream())
            {
                var settings = new XmlWriterSettings
                {
                    Indent = true,
                    Encoding = System.Text.Encoding.UTF8,
                    ConformanceLevel = ConformanceLevel.Auto
                };

                using (XmlWriter xmlWriter = XmlWriter.Create(memoryStream, settings))
                {
                    // Create the root element
                    xmlWriter.WriteStartDocument();
                    xmlWriter.WriteStartElement("Korisnici");

                    foreach (var item in model.Korisnici)
                    {
                        xmlWriter.WriteStartElement("Korisnik");
                        // Create elements for each item in the collection
                        xmlWriter.WriteElementString("KorisnikID", item.KorisnikId.ToString());
                        xmlWriter.WriteElementString("TipId", item.TipId.ToString());
                        xmlWriter.WriteElementString("KorisnickoIme", item.KorisnickoIme);
                        xmlWriter.WriteElementString("Ime", item.Ime);
                        xmlWriter.WriteElementString("Prezime", item.Prezime);
                        xmlWriter.WriteElementString("Email", item.Email);
                        xmlWriter.WriteElementString("Slika", item.Slika);
                        xmlWriter.WriteElementString("LastLogedIn", item.LastLogIn.ToString());
                        // Add other properties as needed
                        xmlWriter.WriteEndElement(); // Close the Item element
                    }

                    // Close the root element
                    xmlWriter.WriteEndElement();
                    xmlWriter.WriteEndDocument();
                    xmlWriter.Flush();
                }

                // Set the response headers
                Response.ContentType = "application/xml";
                Response.Headers.Add("Content-Disposition", "attachment; filename=Users.xml");

                // Copy the XML data from the MemoryStream to the response stream
                memoryStream.Seek(0, SeekOrigin.Begin);
                memoryStream.CopyTo(Response.Body);
            }

            return new EmptyResult(); // Return an empty result to prevent further processing
    }

        public List<VMEmployerRanking> GetRankedEmployers()
        {
            List<VMEmployerRanking> rankings = new List<VMEmployerRanking>();
            var blCompanies = companyRepo.GetAll();
            var blAnswers = answerRepo.GetAll();
            var blEmployers = employerRepo.GetAll();
            int count = 0;

            blEmployers.ToList().ForEach(z =>
            {
                blAnswers.ToList().ForEach(a =>
                {
                    if (z.ZaposlenikId == a.ZaposlenikId)
                    {
                        count++;
                    }
                });

                rankings.Add(new VMEmployerRanking
                {
                    Eployer = mapper.Map<VMUser>(userRepo.GetById(z.KorisnikId)),
                    NumberOfQuestions = count,
                    TvrtkaId = z.TvrtkaId
                });
                count = 0;
            });

            return rankings.OrderByDescending(x=>x.NumberOfQuestions).ToList();
        }

        private string CreateHash(string password)
        {
            string salt = BCrypt.Net.BCrypt.GenerateSalt();
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password, salt);
            return hashedPassword;
        }
    }
}
