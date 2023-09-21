using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Repositories;

namespace Tech_Support.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IUserRepository userRepo;
        private readonly IMapper mapper;
        private readonly IWebHostEnvironment _hostingEnvironment;

        public HomeController(ILogger<HomeController> logger, IUserRepository _repo, IMapper _mapper, IWebHostEnvironment hostingEnvironment)
        {
            _logger = logger;
            userRepo = _repo;
            mapper = _mapper;
            _hostingEnvironment = hostingEnvironment;
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [Authorize(Roles = "Admin,Moderator,User")]
        public IActionResult UserProfile()
        {
            var username = User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.Name).Value;
            //HEre we get path to external folder where all images are saved
            string dir = _hostingEnvironment.ContentRootPath;
            var parent = System.IO.Path.Combine(dir, "..");

            if (username != null)
            {
                var blUser = userRepo.GetUserByName(username);
                var vmUser = mapper.Map<VMUser>(blUser);

                //path for wwwroot folder
                var webRootPath = _hostingEnvironment.WebRootPath;
                var wwwRootPath = Path.Combine(webRootPath, "ProfileImage", vmUser.Slika);

                var picturePath = parent + "/Images/" +  vmUser.Slika;

                //This is check for if picture we are trying to show desn't exist in external folder, sets to default image and deletes image from wwwroot folder
                if (!System.IO.File.Exists(picturePath))
                {
                    if (System.IO.File.Exists(wwwRootPath))
                    {
                        System.IO.File.Delete(wwwRootPath); 
                    }

                    picturePath = parent + "/Images/NoImage.jpg";
                    vmUser.Slika = "NoImage.jpg";
                    userRepo.Update(vmUser.KorisnikId,mapper.Map<BLUser>(vmUser));

                }

                byte[] fileBytes  = System.IO.File.ReadAllBytes(picturePath);
                IFormFile file = new FormFile(new MemoryStream(fileBytes), 0, fileBytes.Length, "name", Path.GetFileName(picturePath));

                if (!System.IO.File.Exists(vmUser.Slika))
                {
                    AddToWwwRootAsync(file);
                }

                return View(vmUser);
            }
            return View();
        }

        //This method is used to add image to wwwroot folder
        private async Task AddToWwwRootAsync(IFormFile file)
        {
            string webRootPath = _hostingEnvironment.WebRootPath;
            string folderPath = Path.Combine(webRootPath, "ProfileImage");

            // Create the folder if it doesn't exist
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }
            string filePath = Path.Combine(folderPath,file.FileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }
        }

        [HttpGet]
        [Authorize(Roles = "Admin,Moderator,User")]
        public IActionResult UpdateAccount(int id)
        {
            var vmUser = mapper.Map<VMUser>(userRepo.GetById(id));
            return View(vmUser);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Moderator,User")]
        public IActionResult UpdateAccount(int id, VMUser vmUser, IFormFile file)
        {
            if (file != null)
            {
                UploadImageAsync(file);
            }
            
            //Update image name in database
            vmUser.Slika = file.FileName;

            var blUser = mapper.Map<BLUser>(vmUser);
            userRepo.Update(id, blUser);
            return RedirectToAction("UserProfile");
        }

        //This method is used to upload image to external folder
        private async Task UploadImageAsync(IFormFile file)
        {
            string dir = _hostingEnvironment.ContentRootPath;
            var parent = System.IO.Path.Combine(dir, "..");
            var externalFolder = Path.Combine(parent + "/Images", file.FileName);

            if (!System.IO.File.Exists(externalFolder))
            {
                using (var stream = new FileStream(externalFolder, FileMode.Create))
                {
                    await file.CopyToAsync(stream);
                } 
            }
        }
    }
}