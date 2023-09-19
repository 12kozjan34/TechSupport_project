using System;
using System.Collections.Generic;

namespace TechSupport.DAL.Models;

public partial class Korisnik
{
    public int KorisnikId { get; set; }

    public int TipId { get; set; }

    public string KorisnickoIme { get; set; } = null!;

    public string Lozinka { get; set; } = null!;

    public string? Ime { get; set; }

    public string? Prezime { get; set; }

    public string? Email { get; set; }

    public string? Slika { get; set; }

    public bool Blocked { get; set; }

    public bool Zaposlen { get; set; }

    public DateTime? LastLogIn { get; set; }

    public virtual TipKorisnika Tip { get; set; } = null!;

    public virtual ICollection<Tvrtka> Tvrtkas { get; set; } = new List<Tvrtka>();

    public virtual ICollection<Zaposlenik> Zaposleniks { get; set; } = new List<Zaposlenik>();
}
