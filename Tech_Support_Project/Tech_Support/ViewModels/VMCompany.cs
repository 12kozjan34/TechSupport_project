using System;
using System.Collections.Generic;

namespace Tech_Support.ViewModels;

public partial class VMCompany
{
    public int TvrtkaId { get; set; }

    public int ModeratorId { get; set; }

    public string Naziv { get; set; } = null!;

    public string? Opis { get; set; }

    public int BrojZaposlenika { get; set; }

    public int PreostaliOdgovori { get; set; }

    public short Zahtjev { get; set; }

    public virtual VMUser Moderator { get; set; } = null!;

    public virtual ICollection<VMQuestion> Pitanjes { get; set; } = new List<VMQuestion>();

    public virtual ICollection<VMEmployer> Zaposleniks { get; set; } = new List<VMEmployer>();
}
