using System;
using System.Collections.Generic;

namespace TechSupport.DAL.Models;

public partial class Pitanje
{
    public int PitanjeId { get; set; }

    public int TvrtkaId { get; set; }

    public string Naslov { get; set; } = null!;

    public DateTime DatumVrijemePitanja { get; set; }

    public string Tekst { get; set; } = null!;

    public string Slika { get; set; } = null!;

    public string? Video { get; set; }

    public bool Odgovoreno { get; set; }

    public virtual ICollection<Odgovor> Odgovors { get; set; } = new List<Odgovor>();

    public virtual Tvrtka Tvrtka { get; set; } = null!;
}
