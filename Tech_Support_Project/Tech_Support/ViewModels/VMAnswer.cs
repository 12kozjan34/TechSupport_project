using System;
using System.Collections.Generic;

namespace Tech_Support.ViewModels;

public partial class VMAnswer
{
    public int? OdgovorId { get; set; }

    public int? PitanjeId { get; set; }

    public int? ZaposlenikId { get; set; }

    public string Tekst { get; set; } = null!;

    public DateTime? DatumVrijemeOdgovora { get; set; }

    public virtual VMQuestion? Pitanje { get; set; } = null!;

    public virtual VMEmployer? Zaposlenik { get; set; } = null!;
}
