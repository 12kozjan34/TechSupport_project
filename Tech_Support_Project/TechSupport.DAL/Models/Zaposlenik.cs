using System;
using System.Collections.Generic;

namespace TechSupport.DAL.Models;

public partial class Zaposlenik
{
    public int ZaposlenikId { get; set; }

    public int KorisnikId { get; set; }

    public int TvrtkaId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<Odgovor> Odgovors { get; set; } = new List<Odgovor>();

    public virtual Tvrtka Tvrtka { get; set; } = null!;
}
