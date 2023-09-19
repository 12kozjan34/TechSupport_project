using System;
using System.Collections.Generic;

namespace TechSupport.DAL.Models;

public partial class TipKorisnika
{
    public int TipId { get; set; }

    public string Naziv { get; set; } = null!;

    public virtual ICollection<Korisnik> Korisniks { get; set; } = new List<Korisnik>();
}
