using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Security.Claims;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Models;
using TechSupport.DAL.Repositories;

namespace Tech_Support.Controllers
{
    [Authorize(Roles = "Moderator")]
    public class ModeratorController : Controller
    {
        private readonly IEmployerRepository employerRepo;
        private readonly ICompanyRepository companyRepo;
        private readonly IUserRepository userRepo;
        private readonly IQuestionRepository questionRepo;
        private readonly IAnswerRepository answerRepo;
        private readonly IMapper mapper;

        public ModeratorController(IEmployerRepository employerRepo, IMapper _mapper, ICompanyRepository companyRepo, IUserRepository userRepo, IQuestionRepository questionRepo, IAnswerRepository answerRepo)
        {
            this.employerRepo = employerRepo;
            mapper = _mapper;
            this.companyRepo = companyRepo;
            this.userRepo = userRepo;
            this.questionRepo = questionRepo;
            this.answerRepo = answerRepo;
        }

        //Lists all the employers of the company of the moderator
        [HttpGet]
        public IActionResult Index()
        {
            var userId = userRepo.GetUserId(User.Identity.Name);

            var blUser = userRepo.GetById(userId);

            if (blUser.Zaposlen == false)
            {
                return BadRequest("Moderator is not employed!!");
            }

            var companyId = companyRepo.GetCompanyIdModerator(userId);
            var blEmployers = employerRepo.GetByCompanyId(companyId);

            List<VMUser> vmUsers = new List<VMUser>();

            blEmployers.ToList().ForEach(x =>
            {
                int userId = x.KorisnikId;
                var blUser = userRepo.GetById(userId);
                var vmUser = mapper.Map<VMUser>(blUser);
                vmUsers.Add(vmUser);
            });

            ViewData["Employers"] = vmUsers;
            return View();
        }

        //Adds a new employer to the company of the moderator
        [HttpGet]
        public IActionResult AddEmploye()
        {
            var userId = userRepo.GetUserId(User.Identity.Name);

            var blUser = userRepo.GetById(userId);

            if (blUser.Zaposlen == false)
            {
                return BadRequest("Moderator is not employed!!");
            }

            var employedUsers = employerRepo.GetAll();
            var blUsers = userRepo.GetAll();
            List<VMUser>unemployed = new List<VMUser>();

            //Gets all the unemployed users
            foreach (var item in blUsers)
            {
                int id = item.KorisnikId;

                if (!employedUsers.Any(x => x.KorisnikId == id))
                {
                    if (item.TipId == 2)
                    {
                        var vmUser = mapper.Map<VMUser>(item);
                        unemployed.Add(vmUser);
                    }
                }
            }

            IEnumerable<VMUser> model = unemployed;
            return View(model);
        }

        [HttpPost]
        public IActionResult AddEmploye(int selectedItem)
        {
            var employerId = employerRepo.GetLastId();
            var blUser = userRepo.GetById(selectedItem);

            var blEmployer = new BLEmployer
            {
                ZaposlenikId = ++employerId,
                KorisnikId = blUser.KorisnikId,
                TvrtkaId = companyRepo.GetCompanyIdModerator(userRepo.GetUserId(User.Identity.Name))
            };

            employerRepo.Add(blEmployer);
            return RedirectToAction("AddEmploye", "Moderator");
        }

        //Shows answered and unaswered questions of the company of the moderator and the request status(has a feature to send request if you are allowed)
        [HttpGet]
        [Authorize(Roles = "Moderator")]
        public IActionResult QuestionsAndRequests()
        {
            var userId = userRepo.GetUserId(User.Identity.Name);

            var blUser = userRepo.GetById(userId);

            if (blUser.Zaposlen == false)
            {
                return BadRequest("Moderator is not employed!!");
            }

            var username = User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;

            var companyId = companyRepo.GetCompanyIdModerator(userId);

            var vmQuestion = mapper.Map<IEnumerable<VMQuestion>>(questionRepo.GetByCompanyId(companyId));

            int count = vmQuestion.Count(p => p.Odgovoreno == false);

            bool request = companyRepo.GetRequestStatus(companyId);

            ViewData["Request"] = request;
            ViewData["Count"] = count;
            ViewData["AnsweredQ"] = vmQuestion.ToList().Where(q => q.Odgovoreno == true);
            ViewData["UnansweredQ"] = vmQuestion.ToList().Where(q => q.Odgovoreno == false);
            return View();
        }

        //Sends a request to the admin to allow the moderator to add new employers
        [HttpPost]
        public IActionResult QuestionsAndRequests(bool request)
        {
            var companyId = companyRepo.GetCompanyIdModerator(userRepo.GetUserId(User.Identity.Name));
            companyRepo.SendRequest(companyId, request);
            return RedirectToAction("QuestionsAndRequests", "Moderator");
        }

        //Function for ranking the employers of the company of the moderator
        public List<VMEmployerRanking> GetEmployerRankings()
        {
            List<VMEmployerRanking> vmEmployerRanking = new List<VMEmployerRanking>();

            //Gets all employers from the company of the moderator
            var blEmployers = employerRepo.GetByCompanyId(companyRepo.GetCompanyIdModerator(userRepo.GetUserId(User.Identity.Name)));
            var blAnswers = answerRepo.GetAll();

            foreach (var item in blEmployers)
            {
                int count = 0;

                //Counts the number of questions answered by the employer
                blAnswers.ToList().ForEach(o =>
                {
                    if (o.ZaposlenikId == item.ZaposlenikId)
                    {
                        count++;
                    }
                });

                vmEmployerRanking.Add(new VMEmployerRanking
                {
                    Id = item.ZaposlenikId,
                    Eployer = mapper.Map<VMUser>(userRepo.GetById(item.KorisnikId)),
                    NumberOfQuestions = count
                });
            }

            return vmEmployerRanking.OrderByDescending(x=>x.NumberOfQuestions).ToList();
        }

        //Shows the ranking of the employers of the company of the moderator
        [HttpGet]
        [Authorize (Roles = "Moderator")]
        public IActionResult EmployerRankings()
        {
            var blUser = userRepo.GetById(userRepo.GetUserId(User.Identity.Name));

            if (blUser.Zaposlen == false)
            {
                return BadRequest("Moderator is not employed!!");
            }

            List<VMEmployerRanking> vmEmployerRanking = GetEmployerRankings();

            ViewData["EmployerRanking"] = vmEmployerRanking;
            return View();
        }
    }
}
