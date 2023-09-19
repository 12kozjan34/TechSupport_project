using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.BLModels
{
    public class BLQuestion
    {
        public int PitanjeId { get; set; }

        public int TvrtkaId { get; set; }

        public string Naslov { get; set; } = null!;

        public DateTime DatumVrijemePitanja { get; set; }

        public string Tekst { get; set; } = null!;

        public string Slika { get; set; } = null!;

        public string? Video { get; set; }

        public bool Odgovoreno { get; set; }

        public virtual ICollection<BLAnswer> Odgovors { get; set; } = new List<BLAnswer>();

        public virtual BLCompany Tvrtka { get; set; } = null!;
    }
}
