using System.ComponentModel.DataAnnotations;

namespace Tech_Support.ViewModels
{
    public class VMAnswerRequest
    {
        [Required(ErrorMessage = "This field can't be empty")]
        public string text { get; set; }
    }
}
