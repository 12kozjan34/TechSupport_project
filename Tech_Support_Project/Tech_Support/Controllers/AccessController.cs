using AutoMapper;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Repositories;


namespace Tech_Support.Controllers
{
    public class AccessController : Controller
    {
        private readonly IUserRepository userRepo;
        private readonly IMapper mapper;

        public AccessController(IUserRepository _repo, IMapper _mapper)
        {
            userRepo = _repo;
            mapper = _mapper;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Login()
        {
            string sessionData = HttpContext.Session.GetString("sessionData");
            int count = !string.IsNullOrEmpty(sessionData) ? int.Parse(sessionData) : 0;

            return View();
        }

        [HttpPost]
        public IActionResult Login(Login credentials)
        {
            if (ModelState.IsValid)
            {
                var blUser = userRepo.CheckCredentials(credentials.Username, credentials.Password);

                string sessionData = HttpContext.Session.GetString("sessionData");
                int count = !string.IsNullOrEmpty(sessionData) ? int.Parse(sessionData) : 0;

                if (blUser!=null && blUser.Blocked == true)
                {
                    ModelState.AddModelError("", "Account is blocked");
                    return View();
                }

                if (blUser == null)
                {
                    count++;
                    HttpContext.Session.SetString("sessionData", count.ToString());
                    ModelState.AddModelError("", "Wrong username or password");
                    return View();
                }

                if(count >= 3 && blUser.KorisnickoIme!="admin")
                {
                    userRepo.Block(blUser);
                    ModelState.AddModelError("", "Account is blocked");
                    return View();
                }

                blUser.LastLogIn = System.DateTime.Now;
                userRepo.UpdateTime(blUser);

                ClaimsIdentity identity = null;
                bool isAuthenticate = false;

                if (blUser.TipId == 0)
                {
                    identity = new ClaimsIdentity(new[]
                    {
                        new Claim(ClaimTypes.Name, blUser.KorisnickoIme),
                        new Claim(ClaimTypes.Role, "Admin")
                    }, CookieAuthenticationDefaults.AuthenticationScheme);
                    isAuthenticate = true;
                }

                else if (blUser.TipId == 1)
                {
                    identity = new ClaimsIdentity(new[]
                    {
                        new Claim(ClaimTypes.Name, blUser.KorisnickoIme),
                        new Claim(ClaimTypes.Role, "Moderator")
                    }, CookieAuthenticationDefaults.AuthenticationScheme);
                    isAuthenticate = true;
                }
                else
                {
                    identity = new ClaimsIdentity(new[]
                    {
                        new Claim(ClaimTypes.Name, blUser.KorisnickoIme),
                        new Claim(ClaimTypes.Role, "User")
                    }, CookieAuthenticationDefaults.AuthenticationScheme);
                    isAuthenticate = true;
                }
                if (isAuthenticate)
                {
                    count = 0;
                    HttpContext.Session.SetString("sessionData", count.ToString());
                    var principal = new ClaimsPrincipal(identity);
                    HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", "Account is blocked");
                    return View();
                }
            }
            return View();
        }

        public IActionResult Logout()
        {
            var login = HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Login", "Access");
        }
    }
}
