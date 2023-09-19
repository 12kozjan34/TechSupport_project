using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Tech_Support.ViewModels;

public partial class VMQuestion
{
    public int PitanjeId { get; set; }

    public int? TvrtkaId { get; set; }

    public string Naslov { get; set; } = null!;

    public DateTime DatumVrijemePitanja { get; set; }

    public string Tekst { get; set; } = null!;

    public string Slika { get; set; } = null!;

    public string? Video { get; set; }

    public bool Odgovoreno { get; set; }

    public virtual ICollection<VMAnswer> Odgovors { get; set; } = new List<VMAnswer>();

    public virtual VMCompany? Tvrtka { get; set; } = null!;
}
