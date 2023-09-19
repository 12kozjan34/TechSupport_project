using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.BLModels
{
    public class BLUser
    {
        public int KorisnikId { get; set; }

        public int TipId { get; set; }

        public string KorisnickoIme { get; set; } = null!;

        public string Lozinka { get; set; } = null!;

        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        public string? Email { get; set; }

        public string? Slika { get; set; }

        public bool Blocked { get; set; }

        public bool Zaposlen { get; set; }

        public DateTime? LastLogIn { get; set; }

        public virtual BLUserType Tip { get; set; } = null!;

        public virtual ICollection<BLCompany> Tvrtkas { get; set; } = new List<BLCompany>();

        public virtual ICollection<BLEmployer> Zaposleniks { get; set; } = new List<BLEmployer>();
    }
}
