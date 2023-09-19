using System;
using System.Collections.Generic;

namespace TechSupport.DAL.Models;

public partial class Odgovor
{
    public int OdgovorId { get; set; }

    public int PitanjeId { get; set; }

    public int ZaposlenikId { get; set; }

    public string Tekst { get; set; } = null!;

    public DateTime DatumVrijemeOdgovora { get; set; }

    public virtual Pitanje Pitanje { get; set; } = null!;

    public virtual Zaposlenik Zaposlenik { get; set; } = null!;
}
