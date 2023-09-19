using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Repositories;

namespace Tech_Support.Controllers
{
    [AllowAnonymous]
    public class AnnonimousController : Controller
    {
        private readonly ICompanyRepository companyRepo;
        private readonly IQuestionRepository questionRepo;
        private readonly IMapper mapper;

        public AnnonimousController(ICompanyRepository companyRepo, IMapper mapper, IQuestionRepository questionRepo)
        {
            this.companyRepo = companyRepo;
            this.questionRepo = questionRepo;
            this.mapper = mapper;
        }

        public IActionResult Index()
        {
            var vmQuestions = mapper.Map<IEnumerable<VMQuestion>>(questionRepo.GetAll());

            var vmCompanies = mapper.Map<IEnumerable<VMCompany>>(companyRepo.GetAll());

            DropDownModel model = new DropDownModel()
            {
                Questions = vmQuestions,
                Companies = vmCompanies
            };

            return View(model);
        }

        //Used for getting questions for a specific company
        [HttpGet]
        public IActionResult GetData(int companyId)
        {
            var selectedCompanyData = questionRepo.GetByCompanyId(companyId);
            List<VMQuestion> questions = new List<VMQuestion>();
            selectedCompanyData.ToList().ForEach(q => questions.Add(new VMQuestion { Naslov = q.Naslov, Odgovoreno = q.Odgovoreno }));

            return Json(questions);
        }

        [HttpGet]
        public IActionResult SendQuestion()
        {
            var vmCompanies = mapper.Map<IEnumerable<VMCompany>>(companyRepo.GetAll());

            ViewData["Companies"] = vmCompanies;
            return View();
        }

        [HttpPost]
        public IActionResult SendQuestion(VMQuestion request)
        {

            var blQuestion = mapper.Map<BLQuestion>(request);
            questionRepo.Add(blQuestion);

            var vmCompanies = mapper.Map<IEnumerable<VMCompany>>(companyRepo.GetAll());

            ViewData["Companies"] = vmCompanies;
            return RedirectToAction("Index");
        }
    }
}
