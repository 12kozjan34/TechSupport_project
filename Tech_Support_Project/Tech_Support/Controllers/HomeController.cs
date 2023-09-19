using AutoMapper;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Diagnostics;
using System.Net.NetworkInformation;
using System.Security.Claims;
using Tech_Support.ViewModels;
using TechSupport.DAL.BLModels;
using TechSupport.DAL.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting.Internal;
using System.Net.WebSockets;

namespace Tech_Support.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IUserRepository userRepo;
        private readonly IMapper mapper;

        public HomeController(ILogger<HomeController> logger, IUserRepository _repo, IMapper _mapper)
        {
            _logger = logger;
            userRepo = _repo;
            mapper = _mapper;
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
            if(username != null)
            {
                var blUser = userRepo.GetUserByName(username);
                var vmUser = mapper.Map<VMUser>(blUser);
                return View(vmUser);
            }
            return View();
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
        public IActionResult UpdateAccount(int id, VMUser vmUser)
        {
             var blUser = mapper.Map<BLUser>(vmUser);
             userRepo.Update(id, blUser);
             return RedirectToAction("UserProfile");
        }
    }
}