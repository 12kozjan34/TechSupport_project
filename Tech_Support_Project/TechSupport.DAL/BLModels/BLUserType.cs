using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.BLModels
{
    public class BLUserType
    {
        public int TipId { get; set; }

        public string Naziv { get; set; } = null!;

        public virtual ICollection<BLUser> Korisniks { get; set; } = new List<BLUser>();
    }
}
