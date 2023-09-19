using System.ComponentModel.DataAnnotations;

namespace Tech_Support.ViewModels
{
    public class Login
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
        public bool? Blocked { get; set; }
    }
}
