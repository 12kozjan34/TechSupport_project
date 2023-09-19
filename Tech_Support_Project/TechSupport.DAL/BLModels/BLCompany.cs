using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.BLModels
{
    public class BLCompany
    {
        public int TvrtkaId { get; set; }

        public int ModeratorId { get; set; }

        public string Naziv { get; set; } = null!;

        public string? Opis { get; set; }

        public int BrojZaposlenika { get; set; }

        public int PreostaliOdgovori { get; set; }

        public short Zahtjev { get; set; }

        public virtual BLUser Moderator { get; set; } = null!;

        public virtual ICollection<BLQuestion> Pitanjes { get; set; } = new List<BLQuestion>();

        public virtual ICollection<BLEmployer> Zaposleniks { get; set; } = new List<BLEmployer>();
    }
}
