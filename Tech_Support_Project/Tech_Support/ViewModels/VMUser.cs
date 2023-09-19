using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace Tech_Support.ViewModels;

public partial class VMUser
{
    [XmlElement("KorisnikId")]
    public int KorisnikId { get; set; }
    [XmlElement("TipId")]
    public int TipId { get; set; }
    [XmlElement("KorisnickoIme")]
    public string KorisnickoIme { get; set; } = null!;
    [XmlElement("Lozinka")]
    public string Lozinka { get; set; } = null!;
    [XmlElement("Ime")]
    public string? Ime { get; set; }
    [XmlElement("Prezime")]
    public string? Prezime { get; set; }
    [XmlElement("Email")]
    public string? Email { get; set; }
    [XmlElement("Slika")]
    public string? Slika { get; set; }
    [XmlIgnore]
    public bool Blocked { get; set; }
    [XmlIgnore]
    public bool Zaposlen { get; set; }
    [XmlElement("LastLogIn")]
    public DateTime? LastLogIn { get; set; }
    [XmlIgnore]
    public virtual VMUserType Tip { get; set; } = null!;
    [XmlIgnore]
    public virtual ICollection<VMCompany> Tvrtkas { get; set; } = new List<VMCompany>();
    [XmlIgnore]
    public virtual ICollection<VMEmployer> Zaposleniks { get; set; } = new List<VMEmployer>();
}
