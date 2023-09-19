using System;
using System.Collections.Generic;

namespace TechSupport.DAL.Models;

public partial class Tvrtka
{
    public int TvrtkaId { get; set; }

    public int ModeratorId { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public int BrojZaposlenika { get; set; }

    public int PreostaliOdgovori { get; set; }

    public short Zahtjev { get; set; }

    public virtual Korisnik Moderator { get; set; } = null!;

    public virtual ICollection<Pitanje> Pitanjes { get; set; } = new List<Pitanje>();

    public virtual ICollection<Zaposlenik> Zaposleniks { get; set; } = new List<Zaposlenik>();
}
