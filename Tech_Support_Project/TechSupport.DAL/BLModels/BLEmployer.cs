using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.BLModels
{
    public class BLEmployer
    {
        public int ZaposlenikId { get; set; }

        public int KorisnikId { get; set; }

        public int TvrtkaId { get; set; }

        public virtual BLUser Korisnik { get; set; } = null!;

        public virtual ICollection<BLAnswer> Odgovors { get; set; } = new List<BLAnswer>();

        public virtual BLCompany Tvrtka { get; set; } = null!;
    }
}
