using System;
using System.Collections.Generic;

namespace Tech_Support.ViewModels;

public partial class VMEmployer
{
    public int ZaposlenikId { get; set; }

    public int KorisnikId { get; set; }

    public int TvrtkaId { get; set; }

    public virtual VMUser Korisnik { get; set; } = null!;

    public virtual ICollection<VMAnswer> Odgovors { get; set; } = new List<VMAnswer>();

    public virtual VMCompany Tvrtka { get; set; } = null!;
}
