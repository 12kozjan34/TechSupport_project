using Microsoft.AspNetCore.Mvc;

namespace Tech_Support.Controllers
{
    public class DefaultController : Controller
    {
        //Used for redirecting to the login page if the user is not authenticated
        public IActionResult Index()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Login", "Access");
        }
    }
}
