using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Repositories;

namespace Tech_Support.Controllers
{
    [Authorize(Roles = "User,Moderator")]
    public class RegisteredController : Controller
    {
        private readonly IUserRepository userRepo;
        private readonly IEmployerRepository employerRepo;
        private readonly IQuestionRepository questionRepo;
        private readonly IAnswerRepository answerRepo;
        private readonly IMapper mapper;

        public RegisteredController(IUserRepository userRepo, IMapper mapper, IEmployerRepository employerRepo, IQuestionRepository questionRepo, IAnswerRepository answerRepo)
        {
            this.userRepo = userRepo;
            this.mapper = mapper;
            this.employerRepo = employerRepo;
            this.questionRepo = questionRepo;
            this.answerRepo = answerRepo;
        }

        //Shows all questions for employer, divides them into answered(has a button to answer it) and unanswered
        public IActionResult Index()
        {
            var blUser = userRepo.GetUserByName(User.Identity.Name);

            if (blUser.Zaposlen == false)
            {
                return BadRequest("You are not employed, access denied");
            }

            var username = User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;

            var vmQuestions = mapper.Map<IEnumerable<VMQuestion>>(questionRepo.GetByCompanyId(employerRepo.GetCompanyId(blUser.KorisnikId)));

            int count = vmQuestions.Count(p=>p.Odgovoreno == false);

            ViewData["Count"] = count;
            ViewData["AnsweredQ"] = vmQuestions.ToList().Where(q=>q.Odgovoreno == true);
            ViewData["UnansweredQ"] = vmQuestions.ToList().Where(q=>q.Odgovoreno == false);
            return View();
        }

        [HttpGet]
        public IActionResult AnswerQuestion(int id)
        {
            var vmPitanje = mapper.Map<VMQuestion>(questionRepo.GetById(id));

            var questionId = vmPitanje.PitanjeId;

            ViewData["Question"] = vmPitanje;
            return View();
        }

        //Adds answer to question and marks it as answered
        [HttpPost]
        public IActionResult AnswerQuestion(int id, VMAnswerRequest request)
        {
            var username = User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;
            var employerId = employerRepo.GetEmployerId(userRepo.GetUserId(username));

            var vmOdgovor = new VMAnswer
            {
                PitanjeId = id,
                ZaposlenikId = employerId,
                Tekst = request.text
            };

            var blAnser = mapper.Map<BLAnswer>(vmOdgovor);
            answerRepo.Add(blAnser);

            var blQuestion = questionRepo.GetById(id);
            blQuestion.Odgovoreno = true;
            questionRepo.Update(id, blQuestion);

            return RedirectToAction("Index","Registered");
        }
    }
}
