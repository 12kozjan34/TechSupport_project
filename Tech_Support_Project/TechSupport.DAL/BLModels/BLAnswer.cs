using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechSupport.DAL.Models;

namespace TechSupport.DAL.BLModels
{
    public class BLAnswer
    {
        public int OdgovorId { get; set; }

        public int PitanjeId { get; set; }

        public int ZaposlenikId { get; set; }

        public string Tekst { get; set; } = null!;

        public DateTime DatumVrijemeOdgovora { get; set; }

        public virtual BLQuestion Pitanje { get; set; } = null!;

        public virtual BLEmployer Zaposlenik { get; set; } = null!;
    }
}
